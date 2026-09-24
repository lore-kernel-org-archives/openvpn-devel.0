Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA709C98318
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vA14NbvwKPeYu3kMF0+NQ1ch3yiGJp/tHEBCVxilS4=; b=iU1ZcWHVWcrZBKW1gGgNWGLbOM
	rLDNgV4qAGvDg8f0eSNQprnx8t6TRhKMEaD9vm7k+A26tAP7DATufg0Xek3aWeYiiuNw1NrOZdUFb
	+n4y/qZqmNex94E/pyltVw6gfhFu+geDoSiF8Oi3QqO7eQtpzcH07OwrjcMvrqOrA2vI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9qig-0002Mf-4v;
	Thu, 24 Sep 2026 21:11:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9qie-0002MY-Q0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 21:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z6wdrTem4s6zSXW8WebA3ZHBsrsyWvjaLnwlsgortPU=; b=YzbtajBzlkBepocWchJDmlVjIF
 NKS4L1T6U8V9I04BC0+lceRs1c+ZC8lfBRd2JUsWT/0IhBjSWKjFsUY5jeNYrqK/TndisKtubBfO/
 YiEjYEd4suq5cbqYct6kOwTsbufDQPEcKMoqpyoaXK0h6z2DPoMBEbady+I5PPtkfOow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z6wdrTem4s6zSXW8WebA3ZHBsrsyWvjaLnwlsgortPU=; b=g
 WWL3moxzGLLA/8kcp0xP0rD0KUIbc+7NTk2/QfeTRLRRB9aOOCr33rcjXlqXCkX7y6QockwLwetba
 fkAEsVgNu2XxCytRPf3BfmEUZZsIK9MWwHKEIX5Z/EHLrPMGtCybyObB+iVFDYvgILGB/NOrohyll
 LkWbaudgUhxWbbZY=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9qid-0003wE-II for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 21:11:04 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so120512f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790284257; x=1790889057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z6wdrTem4s6zSXW8WebA3ZHBsrsyWvjaLnwlsgortPU=;
 b=Sweo//2wFwxz6dBbxw47v/EMcDJ2hKcXeETK/30pbGN2TZSdvJPGy+iBPmpWcBUQ5+
 yX7m7mlhtjVEqOHZ4F25XJ5QymVM3q2zdIB8P+MlBukVsjdGRLKuhlXPIzSwxeyUFu3+
 3quToAzzXazrtW8Mou0YTvKgD8b6HyhvheSYql5Yfzls9yCq4nuPcLjRHu4PyV1ilC+C
 MXpSgG8O54QJPRfVWGNqYiifnNe9rH5q2B1Ktpfmgxm+zzAhaZHPCslthkbruf2UoN9v
 EMEpNqA5SbzT5/z4XaAXQIJU1M5u3PtK53ivxiviStvfTH+99CJAKjW0P+RA5Lanez1S
 e1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284257; x=1790889057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z6wdrTem4s6zSXW8WebA3ZHBsrsyWvjaLnwlsgortPU=;
 b=AtAM8h9+w1bWkRpNXyT0gGz8TDH3y4g5zQPNuAJx7n8uEiY5J9Qz1n576xnbmJBhmD
 8k4d/Tte1o8OzFarBqtCPiwvx2/aNwcVqQNsnDRwp11K0Uy5QMheqs57RXLombtzYOSp
 mioEA5Lk1WfDHMWvGvYypX2eFwMHVfiL23RBzE0v74tSsqROr6gt6kZTwmc4KUR+7X3C
 D/hW9YeKy1KyOoEqAYUO4C8M0N6nLQcMG7fYLC5cSl9Ca6C8rSwaRfSyfSnUO6W0ni7F
 WknvG+vPmCgLeMOkfou9t82u3/qh//jkG+w79wuMJ3OzKulhpXgYJQJNYvgJu0QTAeIk
 GmuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuW7dk/ciw61Osg6PyeRZK51YWu0E4WBRYQpQSiJwz9RJVamIF8k55wUVBO9ygMwfLqzNSokfzTayZUdjA@lists.sourceforge.net
X-Gm-Message-State: AFuF++mzLBroJcvs9OsI0G389h2y+ZifgcWs/jcDmxueuBfQwSQz/Klg
 GCekcC7BSBtlTCt5UEchJs8+44I+SO4o+lP1bde21p//nE66eqovPHdGqclaayC5AZvq5Sb4iZc
 1kmxJowbWIBzTS81VPBdqQzRw/SWSRwsEy+QQ4apEg4JUgguO3FoK1vCqLdRT6GLZ+QeCbp0CNj
 jqiwM8yg==
X-Gm-Gg: AYBFou3NuY/ROq7VporBTYZxJ14FvPS/OOA2CUlTD+tQxmVscaHGbhgZnMY9+B5ROuV
 wTU9m9lC174849YBMq0/A9hJ4p74kJkVHR/jmwvNi+rRLv2gkZUiQFrpy+XJsK26DEzPmhV6CDD
 HI6uhTxQWsKvrBZywNrqRp2mFtz8Kgo9glt1VE6Xo+SDi2H7rw6OVdwFXZVj7Xa36xekXhwzBgI
 HtlUWgrZzICKRtYM5x5xKyDAlcHgfpVNc6+dWQZMVLKeTfYCSFBJW0s1vkeE4mvvDcdt71roKjl
 1fsCPTMsD0JaCYnPiBCbQqvgzEJQPpdywCIQzQ4VciOaovkgrnLQBCo78vAnlnsMjWj96yRxT1P
 VqimkukOy+S89+EQiZStmaOlBwNBEBCuqKISqRolielkWefmiW4T3HbC8RxX/G7ucy6Jl+rtbQN
 To30UVNA16oks7jufimMPaqx/kbKpjOq88Aewg+iz3CpOWbRocWCPw2KoicacK5h7iti2z15Knd
 NFNNaoxvysuXsc36uJn0vHfWme8c57M/7vop2xNyvvdikUterttrfu0VP1Mfd+Agd157pExAWjU
 7vJsEylEQoWMxaKX9UwLA7D8DfBailBkKRxUj6QTZHnGtb7J2lHbMqe432KCwW2ygXesrQ8=
X-Received: by 2002:a05:6000:2481:b0:487:11db:986c with SMTP id
 ffacd0b85a97d-4887177b8c8mr6882844f8f.51.1790284256870; 
 Thu, 24 Sep 2026 14:10:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349fa1sm2588461f8f.8.2026.09.24.14.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:10:56 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 21:10:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: faaea4c811c3bc93b2121a96b2a4aef893259467
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 21:10:54 +0000
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b1d5154336f4a1dc841905ea1d78831567c690c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9qid-0003wE-II
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: read
 multicast notifications on a dedicated netlink socket
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7343172295785279940=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7343172295785279940==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DW0xWNtg61Y="; charset=UTF-8

--DW0xWNtg61Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

ordex has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1737?usp=3Demail )

Change subject: dco_linux: read multicast notif=
ications on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/dco_=
linux=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment/ed2cda66=
_7ff780fd?usp=3Demail :
PS1, Line 1228:         return 0;
> So before this =
patch, we exit early here if `__is_locked`=2E [=E2=80=A6]
I am not understa=
nding the question=2E=2Eif there is any? =F0=9F=98=83



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd=
5
Gerrit-Change-Number: 1737
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antoni=
o@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
omment-Date: Thu, 24 Sep 2026 21:10:54 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--DW0xWNtg61Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>ordex has posted commen=
ts on this change by ordex=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1737?usp=3Demail">View Change</a></p><p>1 comment:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment=
/ed2cda66_7ff780fd?usp=3Demail">Patch Set #1, Line 1228:</a> <code style=3D=
"font-family:monospace,monospace">        return 0;</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">S=
o before this patch, we exit early here if `__is_locked`=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I am not understanding the question=2E=2Eif there is any? =F0=
=9F=98=83</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail">change 1737</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7894fc360b12c5a0f63f=
ad2abb9bbb1ad9c2bd5 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1737 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 24 Sep 2026 21:10:54 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: r=
azvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--DW0xWNtg61Y=--


--===============7343172295785279940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7343172295785279940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7343172295785279940==--

