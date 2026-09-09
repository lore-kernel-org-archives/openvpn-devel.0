Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF84DC79FAD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=534GWiyllUtjB/stRD3cQgx7ig2o4TAzX6LtVqt8JcE=; b=O30QzSXc9SwbrgAZmGtBfbSSIm
	TaWO6wrOsPRMjNRKCgw9Gro1MTAcIU0ZZ93sn1ntiCwGavfQdNL7snjtSyQRSVAmQGCSmxk70TxC9
	nPyZlSZDajEqvZZHdjHDqNKv9FHx55REs4O+ETWJTWyrrZwbE4fiyOWuEk8+zAHsDENk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4GiE-0002Fq-9O;
	Wed, 09 Sep 2026 11:43:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4GiD-0002Fk-QK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=j9cxlPgMm4GguZFrNWf95IbnVC7pvOoSn4TMTwrn1Lw=; b=cMZNecajFeNE7Y5lrbXkrtgpu2
 mwyS6RBcsJMe9xv5l7xKPhOSMT/GoSvwmIySqU+RTc3Y1OzsKPdVqFigUNsgtaea4ixF1unlW4ulu
 z6EoU9AKLu4OV727vAiWCgUP1EycPPyD9cSg/P/Rp4pCKU5JHvVp6T4Y/MWA1yRZlQ/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j9cxlPgMm4GguZFrNWf95IbnVC7pvOoSn4TMTwrn1Lw=; b=j
 Fzg7Mf4ryQdiIa9b9TvIN1e08x5ddNol9J7IXuNU03ZjCeuQlaeVLJPc+SIt8mrorzlJc8ERUBLgX
 vXB+Tv+JqFSORS3wJl/CyTPUbJAxQMs9OgSwi4U3XZTsE/bRpdi0qDoJlBsw6vk4MEJ9mDUYuIlKF
 fJ8ThCOXfDHM+Jrk=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Gi8-0007he-Gr for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso4742465f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788954202; x=1789559002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j9cxlPgMm4GguZFrNWf95IbnVC7pvOoSn4TMTwrn1Lw=;
 b=clMLHcRVvqYXU51rhj7O7QLlLbxfdNUXUFymbDWAIrpbGC4Y+cRaAg9j2EP5cUnkbE
 o2EJuwsHhcMEvL+f/bJBdXK9Oyp8IRg8/TUvNOX+n2CWYJuNIphvRr/KcsJJHnFaW+cM
 ZXBbf7uwaqk8qCqFxERUfK29bIAB5xhgIgANzA683uqF73AzPY/qIEMUoBorGATc/vE1
 ztbKtFo5oRwuwjzFkfTBWB4yv4RJAI+HUBobIA0La3XPuA+6+3L8wHBRogEfOE4Bv1QV
 iWwb/V6DXI/kreFrYkyd/p3LLvdpQGot0yDWtlRMdII9ZPsilzcH0IfTgjRNpV7TtxU3
 X0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954202; x=1789559002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j9cxlPgMm4GguZFrNWf95IbnVC7pvOoSn4TMTwrn1Lw=;
 b=I1p92h88RTwoWeWMern5yVdf7EQ6accIFVPP6Il9emCZwaU65lhdlOKCY8gQiLfqT1
 luVLPuyNlPqlmkZQeFxrwSYikChS80WpbKnRHvTHhw017a1ZoakwC+RMFuR3UIEo+Ngs
 zlOH9OptRKZx1ndz47cEsI8Of1QLQ/u1DxAkU3TGNzxmYDUvjyqLT1inzpnprQuwHqAk
 VJVpSo9FSuKqM4xfBUrA2YTv4R4yfPYLThrCumN3lNwEmQAa/FaNd+kMv2cP6CwfH1va
 Qz96532yjFxbc6HLK1mS6x8ok4Sb0Cm7763CPniiXJKAG37PU9MSTp1cC+Y/r4jt5IHz
 lAPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByCQgsFfh94q12LwjRgDCMRWoqfq/D5IYZIgGnb17Mo1k2BnyTW5G6sNkKTYsyIyjtOhIdQ5YUfNzXNWsGd@lists.sourceforge.net
X-Gm-Message-State: AFuF++kB6BiQ3KYAffQYk/1bHLaHNXRoJ8Jue02KDpF9A2odH4/1lvv9
 Cu51VmSmL7pheZOISvUgQrYE1XGKz73VN68PddXyysAHlxt0YtTmQY5mQoxz55OyZXkQx6Eu/9d
 bZxapnA4dV9bxFAok528jvvuSegF2Y981YFFmuBUVsZnacFyLzXz00Fwuyvru7VlDI9bk
X-Gm-Gg: AYBFou0C6/jSbJpZhT+mnZZO3zefgQud19jUbY0I2+m4dIamNQMVdnkdDgtecTsV5op
 Egd4+x3nQogzXbwsAQm9nfvybOXzwKhGzE1JP7WlgCq+D137LZBkuIQxJUhzFv6yf7x0lZg+DhE
 YM2c1Ci3RoG5RNZEoRIuYKSN0lV+qVS39CwqQLG34NQ7xebF8wNL9dMUmVcOkIW8YFbKW8K41cS
 QnzepJIX2qkuD+GkC6zX/2xKzNJMEfFHWvoh+M1SuKE9X+WjKjGI+qh+1+ajVVMxkJX8ao15SKX
 mHKpjpn2SOBtexHnWuhjjXQU5AY7wL5WShp54uPLs01q+zXtxB4Gk6XHKMnp4FB/FujDNcglwPf
 x/duKZ5L/BXOyHIZeeqCNgqx6YzasQTh7Q1MjrtT3DyvMG8OdnPQ5Jfbb3+i3sYG6H722OJtK9c
 1n0WL+oEQrFBdjYslL61YV/+tYx7uCBdc+afAs5Lexjn8AFgsHE3oe6QqVNHMXDvfmv6Oy+6Osk
 XRptDBoos1lvDKoUhg2bwGS2+nWPOxFMTWTIEYye/yblyttvctbVtuuWDJ6oWnIciRGvyYa8Gf6
 eOsOcaVT4lD9WAcFQ7206PAsCSTdbBgeiYmpMeLswUsRMQO8FSHfobuaLcGzVT2KBbkg6XpZ
X-Received: by 2002:a05:6000:4b0f:b0:484:3d1b:7871 with SMTP id
 ffacd0b85a97d-485872c1af1mr35532979f8f.19.1788954201713; 
 Wed, 09 Sep 2026 04:43:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfdf6sm44248035f8f.34.2026.09.09.04.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:43:20 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:43:19 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: cce38c5f2703f7386944ddbdd8f4e962f94ffc95
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 11:43:19 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95ee253f5ae5661e53b81b32a7c1f5ca108f31b7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Gi8-0007he-Gr
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8777572500015356089=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8777572500015356089==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="swdS6EHlGVY="; charset=UTF-8

--swdS6EHlGVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1746?usp=3Demail )

Change subject: oob: Add probe-result ranking=
 for server selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 14: Code-Review+1

(3 comments)

Patchset:

PS14: 
ju=
st a couple of nits


Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1746/comment/706946a1_bc197678?usp=3Demail :
PS14, Line 19:   - candi=
dates are ordered by RFC-2782 weighted-random selection by weight, so
This =
is just an observation but after looking at RFC 2782 I noticed a semantic d=
ifference in the usage of 0-weight entries=2E

RFC 2782 puts 0-weight entri=
es first and draws from [0, sum] inclusively, giving a 0-weight entry a sma=
ll nonzero chance=2E This implementation draws from [0, sum) and therefore =
gives zero-weight entries no chance until all positive-weight entries have =
been selected=2E

This behavior, however, seems perfectly reasonable, espec=
ially since the openvpn draft permits clients to choose their algorithm=2E
=


File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746=
/comment/b55bcb85_9707d675?usp=3Demail :
PS14, Line 253: announcing 0 asks =
not to be
              :          * compared on weight
Is this true tho? A=
 fastest server advertising zero remains a candidate, and a slower server c=
an join using its own larger margin; they are then compared by weight=2E Ze=
ro only gives that particular server a 0-width admission margin=2E



-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f=
84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-PatchSet: 14
Gerrit-Owner:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 11:43:19 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--swdS6EHlGVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 14:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #14:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">just a couple of nits</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1746/comment/706946a1_bc197678?usp=3Demail">Patch Se=
t #14, Line 19:</a> <code style=3D"font-family:monospace,monospace">  - can=
didates are ordered by RFC-2782 weighted-random selection by weight, so</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This is just an observation but after looking at RFC 2782 I noticed=
 a semantic difference in the usage of 0-weight entries=2E</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">RFC 2782 put=
s 0-weight entries first and draws from [0, sum] inclusively, giving a 0-we=
ight entry a small nonzero chance=2E This implementation draws from [0, sum=
) and therefore gives zero-weight entries no chance until all positive-weig=
ht entries have been selected=2E</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This behavior, however, seems perfectl=
y reasonable, especially since the openvpn draft permits clients to choose =
their algorithm=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746/comment/b55bc=
b85_9707d675?usp=3Demail">Patch Set #14, Line 253:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">announcing 0 asks not to be<br>         * compared on weight<br><=
/pre></blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Is this true tho? A fastest server advertising zero =
remains a candidate, and a slower server can join using its own larger marg=
in; they are then compared by weight=2E Zero only gives that particular ser=
ver a 0-width admission margin=2E</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">chan=
ge 1746</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 11:43:19 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--swdS6EHlGVY=--


--===============8777572500015356089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8777572500015356089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8777572500015356089==--

