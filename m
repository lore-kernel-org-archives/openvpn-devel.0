Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E9C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 22:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcJ562ddVH1uMUaI6rRaFH8ECbSFReYQU73218tyCPU=; b=W/E4/kO6Jrh/R/S6vN5vYqrYw+
	LYyNDNzRj+ePel/D17kCe65nOtQz+UPHecHEEP5LMESLbT4PaLsdbEHz9+NLp2GDut7bZS5uxCNqi
	pUKfrYlFmkWjBc+qUYWZlnGVRPeJ8hW3iw+YHiHervYaILllD0snCF7chfUX9/2uJQCY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfPbS-0000PX-Cd;
	Thu, 02 Jul 2026 22:09:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfPbR-0000PL-SJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 22:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BWTXni18QX36FRZuQ0hJhSMsp3Z7AO29RiB7WjVnSXk=; b=J5WAdTJlzYxYpWm65yuK1hIsUp
 WQaQCE7C6Q6HpSkiQtkHQNQW0VeRmGjNZgkitrDDp49Bo+fGEcxQipdGKoYpOr3QhunNM3qWN3n3q
 n4wKag5TrN0oF5LnBhKtWhFpLN/sQLOZCOsKG+8vF+nCB83MYbucLLR7148LVJWckiHw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BWTXni18QX36FRZuQ0hJhSMsp3Z7AO29RiB7WjVnSXk=; b=O
 5BG5KY3SQ3iGY52g4HvngutFP8hl2fcQlzwunVDDmOFqBYZLWJ0dDfDeiQC9gyzNjEsW1/nHUVMZH
 PTnxB1L1N9oJuUrMbUtykqhhdcZVpuuVZdelQkYjtdzK83aw+UHsb/qC8+krmDc2DBCeJybO7r3zE
 w5+jKFgzuQt0H8Lk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfPbP-000662-Iy for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 22:09:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so1958184f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783030176; x=1783634976; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BWTXni18QX36FRZuQ0hJhSMsp3Z7AO29RiB7WjVnSXk=;
 b=PfBCxljlDGXiDXB+QWOmWcXhfxmPBsFDws4GaExbQjgtp3wEQab0tgUwIx11WcME09
 C93voTDmMN6uUghuaY41436rluUdhx3LA0y3zTVTvtNZD10dqRXHTeJyo9SgffHZ+Ozj
 BBhmvV8sY1lz2BxE4MBY3b4UKf102R/6WOIfo7O8a/MLG/rPOahpayIaJbeQR0KMralk
 0TDhYnHJEij0GdZyABfDKzXq6tUK/R2AJILI5duOhjHK4n/XqJ1UO2NVFzj7QfOig6cI
 SgshGVzo6TM3qDeexYlEpQkczRrC8M3y+yx2OqG2K1pPzkXZOqZuMvDB39uEuUOftz7u
 k4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783030176; x=1783634976;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWTXni18QX36FRZuQ0hJhSMsp3Z7AO29RiB7WjVnSXk=;
 b=pEGLb1b+qGjpehqsmptNMP1wdFDMkA31IBduhkmGeyI9E85t5obIkEoPoT7cgtL0EK
 LrFaNCz7aWxYLTLdRqBQEmlLLql26PYpev+rUGUwSQFcVfhI1QhFBNuL+pHeT/VlgVWv
 qOx8HAKFUxI0codJOL65lEAo2Nhj6X1A9/Ao/BErDgixYKD0B+BKQLUSrJIJPM8vZ6z/
 aOMx8rIMLGh0TAkCQAVGqhY4egR1WctCkqbNxHs5xCYkmelF88r4UB8lOf3AvEwyqPxv
 9yMPbgD+pSsVkr1WQ0SoqHz7kk/zT9sUHVTrC+6/il34/hzPoTT4QeHo1LTZLMWqV2jA
 uZwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDKAPVgausyAbrOclv9phw8SDOd5m9CBukXAjmeJ5j+kPx9+e6c1JXT0c6uVa1laJSJSHTfXtHseY5pcGY@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyWjz94+ovb7oFY0ywsXa6m84+zhsHp9tyClqUsEk1kTtt7Ym9O
 oXAz4x856Td4L/pH/Gv3TPByEmU0VB2CyrfLyG+wmHcIuSLNVKZBZbbv67meJCjk46+Q7opKZUh
 CFmaKc8hgIlm9xib+uADbkEMIgl9A6nKMDywvJQpl8xxRcwG8EJY1Uozn9AmU7V0WWJjjYMOo1M
 qqVi2CfA==
X-Gm-Gg: AfdE7cny4K49qAuYC2P9U5ol3C7oXqtzt70iGKS7rgxmVdC/HyFmqq4yEn+34/r4MjA
 nsv7s1S/bx3CW+wMCmM6ENSmyhK6W3pLYD9KiJ++ILTxuhhIv5kVaDI68F96ZOi+bqyuBNuibQ/
 dPKZ68LhxFNF4x+w9Xyb7Suzy6CYRJGeUJBqT6xiwJthn9CXXl4i/i+m3KpTwvVTZMcXjHUiRdi
 LS8/Cz2rm5A5sku7kUii+1YnfLfLz3WQY2mx91g9Hb4+hpcUTTGoDtbHHZIYl63Mig8d/b3o4qD
 eUiWXjtI6M3Rv02rh66ibXTYDjZ85P+E+ACCzhw8haSTf3DoUaPDBoOfINT7rTckO+Xugk/BCwS
 U+WvlWKjXdBNIFAh4uspXlpzBaGa8pJ9lNcOzOP/iMzDX8Y5huo/d2pzitRURdnWpAXqch0cVYN
 oz1ncfZrmJ6izTsyQ1sdmAY8YQaL8DfVl6orKhPrivngYpBiRoJXrNAnySSzDR3/lvYhkCXcGwk
 +4j7WfqaOLH1UPtaMTxi9iMsdTj+a/y6b7sBDRAvEmKkssxcnfsO3dZ6XxrGEokqNwO94Rc+2Kd
 Y84=
X-Received: by 2002:a05:6000:4719:b0:473:41c6:f1c2 with SMTP id
 ffacd0b85a97d-4775a6d59bdmr12055409f8f.20.1783030176324; 
 Thu, 02 Jul 2026 15:09:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477d766e0b4sm11909144f8f.0.2026.07.02.15.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 15:09:35 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 22:09:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 522eaaef80c1394de08ecf773b6595d0b17a84b3
X-Gerrit-Comment-Date: Thu, 2 Jul 2026 22:09:34 +0000
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92e74a94dc30056ce3b352ddc180d6efb16d3cb2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfPbP-000662-Iy
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mingw: avoid C99
 "hh" scanf length modifier
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
 openvpn-devel@lists.sourceforge.net
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3071739117640229037=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3071739117640229037==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dZYdpAGDJjI="; charset=UTF-8

--dZYdpAGDJjI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

d12fk has posted commen=
ts on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
733?usp=3Demail )

Change subject: mingw: avoid C99 "hh" scanf length modif=
ier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(1 comment)

File src/openvpn/crypto=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1733/comment/a49a3e2c_5f20a54c?usp=3Demail :
PS2, Line 1=
477:                         ASSERT(sscanf((const char *)hex_byte, "%" SCNx=
8, &u) =3D=3D 1);
> I am confused about this one=2E [=E2=80=A6]
Certainly t=
rue for MinGW on 26=2E04=2E There is a uLibc, that supports %hhx=2E Unfortu=
nately MinGW isn't linked with it, but MSVCRT, which doesn't support %hhx=
=2E That is true for Ubuntu=2E Debian also provides MinGW with uLibc=2E Ubu=
nutu doesn't have those packages for some reason=2E So the situation is tha=
t the headers are shared (it seems) between both libc implementations, whil=
e the compiler is hard liked to one of them=2E Which one the headers do not=
 seem to care about much=2E

There seems to be some compile time flag, whic=
h makes MinGW use the glibc scanf/printf format string parser, which does s=
upport C99 as well, but when you have to recompile going uLibc is the saner=
 approach=2E

Even more sane is to skip on use of unsupported C99 features =
until this mess is resolved in all distros=2E uLibc seems to be the standar=
d today already with MSVC=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1733?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I6595695ab6401047d498d530f8739686880bea3a
Gerrit-Change-Number: =
1733
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 02 Jul 2026 22:09:34 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--dZYdpAGDJjI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1733?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/crypto=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733/com=
ment/a49a3e2c_5f20a54c?usp=3Demail">Patch Set #2, Line 1477:</a> <code styl=
e=3D"font-family:monospace,monospace">                        ASSERT(sscanf=
((const char *)hex_byte, &quot;%&quot; SCNx8, &amp;u) =3D=3D 1);</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">I am confused about this one=2E [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ce=
rtainly true for MinGW on 26=2E04=2E There is a uLibc, that supports %hhx=
=2E Unfortunately MinGW isn&#39;t linked with it, but MSVCRT, which doesn&#=
39;t support %hhx=2E That is true for Ubuntu=2E Debian also provides MinGW =
with uLibc=2E Ubunutu doesn&#39;t have those packages for some reason=2E So=
 the situation is that the headers are shared (it seems) between both libc =
implementations, while the compiler is hard liked to one of them=2E Which o=
ne the headers do not seem to care about much=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">There seems to be some=
 compile time flag, which makes MinGW use the glibc scanf/printf format str=
ing parser, which does support C99 as well, but when you have to recompile =
going uLibc is the saner approach=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Even more sane is to skip on use o=
f unsupported C99 features until this mess is resolved in all distros=2E uL=
ibc seems to be the standard today already with MSVC=2E</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1733?usp=3Demail">change 1733</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1733?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1733 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Thu, 02 Jul 2026 22:09:34 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--dZYdpAGDJjI=--


--===============3071739117640229037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3071739117640229037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3071739117640229037==--

