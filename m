Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FC0CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFpcQzuMzaRH8Z2xpDR2KmZJctF8PY94yOQXTTsLAn0=; b=DQxSO/spCNJrNcSQU1jX9sWGZU
	VGu5divwzjI+8BGdvRUYDGy5GQ2QQCij2lvd/aYuXhbfpgWbLfIkagzEXICs+8bscd6IBoEjA7baL
	+ri0HaNpvdP4JspuNEFmGhRiUeRwZRscRFUBpzoJTMS+noYE4eAxdhhzyuNWwiMJHK04=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xINcB-0004gZ-4u;
	Sun, 18 Oct 2026 09:55:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xINcA-0004gS-II
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KXGJb+rOqngjGZEepsTtPCGCL2wUkh7rF1aHJz4vXaw=; b=kTMToJi7pDFo4V1HOcjQxngEQu
 UUeu07Ku0zp3bsnGmPk2ZOxANjgE7BIbDc68Wl5uZeoz/uERiJLRawNJtmYou2qAc1fU5OY+Ikb04
 0QRgfVx1+Le+cB9FLVynsLkBlzh3WbyhItT6SQz42Oo8EUkgDN123uvJhbFm1d8KjVbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KXGJb+rOqngjGZEepsTtPCGCL2wUkh7rF1aHJz4vXaw=; b=B
 Tb2ZuNMKsZax3VC+e6+lU+BoT+dMT8mjkGZZcDGR92kuK+4naW7RJ3LwcORMH6dpuyV7PRnelPJb9
 yj1a0IxQ/3BgQzM60FMtxSbnAQul8PBgcDKCx5MlGuMGD37MjAu3xL/T/u+BJjL1f0pzCJtvYytJW
 enUZ0I6fi2d4MzW4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xINc7-00017X-DU for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:55:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7918745e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792317329; x=1792922129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KXGJb+rOqngjGZEepsTtPCGCL2wUkh7rF1aHJz4vXaw=;
 b=eKMEOycfRMbBTAnRgfzBkvKQ1+1nGQTcq5vsgL5L8wVkaeaOGlgHY/6Gy0S6plq+2u
 GyUOHzwAJC6cC6KfCpcAHCr3Ic+4xFt8sVTL94RqTJjVoELMfhqRLMBjKIdDZL8fl9n0
 cruu1gZ/cBbZ5IvB20c0JSmoLYlaA3L3g1ZRnVPM4IQwFivXPyj9xaOWsl1FeU01IjIz
 dneaPEmveNQvLeKYJ6i3DYfjkdsYp2YYxqJksLYSvQMHDvOCF0sLDZBYaYm5GjVgcA+d
 M9xRmesvDptfjMRg4ZqJs+OJej+zMViXXuIvqux366ve6puf05PKqymp3zRZmEVBr8wc
 sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792317329; x=1792922129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KXGJb+rOqngjGZEepsTtPCGCL2wUkh7rF1aHJz4vXaw=;
 b=S5rd20TGS35xw/Um9IKeWY6U7CvZj00DwU3H1z5YRQP2oKV0jFywHf7esch3cDOFre
 fVLBlVvgAT8Zyjr2jgymzerMfgJumkXnl4WdnKPsQMmh+2FbuM2Ng8dZNUFJCGXCX03r
 XoLVQ1IGIG8HCILZvvT3t+rTRk/j/QGjR0hO3LvqJ/CWSYuqCTT/O7+WU+veTnGlhGX0
 xEPN/ijKVeFnhmmY+6Trwb6BGo+fZWeWkMRCvRRNA1wLSrkHNJnYZfBHL64+icVYdp5h
 cx8qAAgTqfJ2MuB+01GtjmcV3ZI99mDO4GEjF1DHjRRG385r+7rmKRea2W8z16TvyC8S
 PZxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3ttHfX5A0x+kjUGFJUkBds0NR1vlXEeqDTbcF59gF129N8yRJm4zb84PuhRnRs7byQ9Og5d7kHjzPDQyT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIo1pKNVdOUbcfsRK3OlEbaTX7Fp7iLX9G6IMpfQ3K9XqP9d7Nq
 +ORkE+qw5e/7DbywLIGAknyzj9ob3oTsqdPReVgf1QuO1uwAl+ui5g7O2FqdiLhWZuA2MPTyaGq
 O3D/iVdLL1KsfBgcEvbz0K9PcNceYGkqjY6l/C9sbENnyRDvCD6tBP5us6Vu8vJSRfH/erJ1hJM
 8aQVdOoQ==
X-Gm-Gg: AYBFou18whVCBdkzs7jsouOQHpzt6uGqGasfNPh0nKXfpCkD8EB995anK+sXDCmeNCo
 y2umbMXKqfB++X8kX9o+lI0wmoHjBOvGzhf5BwIXmAPu2/JWE5LTXs/sy2I+uQxvhziqVHYbCiA
 Zc/cpndT4ljXYrUSuOuRt5TsRvgt4kbKLIiSLwyUbtL+ieo74pWaKhFDiUeHBPsZqicptmgGquA
 zeMAXJ4BmRf+RQzR74aQKb0noYdGZjL1gjDfnMOeJ1qb/byV/dUSimktLxe5Vr6ZiCBInjJ78p5
 kXcx6WjXOwuYH/nYadPyvI0MmEQnX8HGqEcS25pTyv+JoBBKPVm2D+rBgt44zXZrbh3J0aGcf3u
 vGZM46Sqr0uF1AFHB1SqAnrB2IfmYXc23lOxzNC8OCyDU2DDINE2wTr+2WT7tW0rSibco396d+M
 AafAC9HhkNZ3VYMc8DU+1WQxA7A5JWeYxCii+FRpRxteCEFnIl53XBpDactCD0kJvTY5HImXAeQ
 8874tKg3QS4eVqLYamVnRaKCJB4zr0a5VVzgIpZzX7t6YPJLTR8ydBucoV471kHxuEzBbpoLHB9
 UOD5aB8FIf2d374rkMgUvtDxsSJc7uXo1oq4Y46oQv8HIGyIjHwreBlsGKZc6TY7lT71z1g=
X-Received: by 2002:a05:600c:4e8a:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-4a1d75f8399mr100169445e9.12.1792317328724; 
 Sun, 18 Oct 2026 02:55:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce325107sm157284995e9.3.2026.10.18.02.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:55:28 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:55:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 2b8e1791c89fe2b5ea9f63b1fdb874771db2a4b3
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 09:55:26 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ffc3529fb2c5e4460e4a4a4442429ff6c09fdee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xINc7-00017X-DU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3864637810709492099=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3864637810709492099==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7EanxxgGHvY="; charset=UTF-8

--7EanxxgGHvY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(1 commen=
t)

File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1852/comment/07f0b910_1a45ab9f?usp=3Demail :
PS10, Line 4381:              =
   platform_get_tmp_dir(), "omi", &c->gc);
> So `c->options=2E [=E2=80=A6]
=
Acknowledged



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307=
e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-Pat=
chSet: 13
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Sun, 18 Oct 2026 09:55:26 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>

--7EanxxgGHvY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1852/comment/07f0b910_1a45ab9f?usp=3Demail">Patch Set #=
10, Line 4381:</a> <code style=3D"font-family:monospace,monospace">        =
        platform_get_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">So `c-&gt;options=2E [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bff=
f665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 18=
52 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18=
 Oct 2026 09:55:26 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--7EanxxgGHvY=--


--===============3864637810709492099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3864637810709492099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3864637810709492099==--

