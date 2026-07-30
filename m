Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54241C5516E
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TK/h7WZNUlc5NHvFWkUafBzUcdVCSJmC+mTGakVKFlM=; b=eoo+fqz10IVWCvCu9j47DfSERQ
	hb9Y9C+idhspHtmGZD5c7EHqLYWTYbUjy7cLZPX0HoNoX1Lny056CM/IuVhNq1crOSvTsJJF/lnQk
	3Udq+TfsfEvzBnd4p5iSnN3I7e31XPvAB6fcEVy7kB5jCgC89qbVw2Gbdadnwp1RWFeo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpVop-0003kg-EE;
	Thu, 30 Jul 2026 18:49:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpVoo-0003ka-1L
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DMm3YdN5WLTTyWoLw805O2rDqVKSRBRH7SpwsnND3zM=; b=NYEMQhh31G1YN0399Tj37NSFv6
 Z6E7oin7hhiaY3hHN8dz1ghZmMgHEZjgQ14pARMh0Lt7vcqk7PRlslDRvXtRULcjf7OrxOJ33PMUd
 jJv69SEKN0gu9qMmZjF1l/oVjg3JH7U2J80dRsrqnqJztWkZuFOO7P6D6jNpKwweC7n0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DMm3YdN5WLTTyWoLw805O2rDqVKSRBRH7SpwsnND3zM=; b=F
 sHyIGZtF/Ol0ZAL2s3EyCKtfy5QgQCnjVe6r7NWK6tXEWsV/4x5GsdHPCfEa95G6CMb3Q0zmJnAFN
 e2DBw9us58FjjpH+7wIXpYym8AmEqBc+C8Nif9nGZVm8L4Erj6QNcv3yPqCAV0ncUmzSyGjzgJobf
 eA9bsGHAe2jq+uFM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpVoi-00049m-Hb for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:49:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495437bb891so82885e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785437350; x=1786042150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DMm3YdN5WLTTyWoLw805O2rDqVKSRBRH7SpwsnND3zM=;
 b=Z8wCswAZMHztjzQS32PHdOudGw568R5PnY2K/gkxMRkyzBMpvkRrNJhBFuWXMBMhAM
 N68ezmPLggtbx/BS5Ryf1BsxQAeEPw7gQ91mUMdjfpVSfYKKf9kz7i5ESnP+pKRt00xD
 2rwl7tbtNRMu8yrIbzHoWq+Hg6EBe0iV3xd9QWeohTW28Udaye7tWdphhkQE6u+NJtOG
 n6WVCtsTBcgUTiR37smsKYWH4DNqBfFaLEWnVNQ7nmOZAJeCjLTLpKCbdTpn19M/SO/+
 XVcO/dbAsxIJVo8F7nIdFljUeo1jWb+YLziuIou9AF2hP8MyUo2I962xTf64of+sBlZn
 68zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785437350; x=1786042150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DMm3YdN5WLTTyWoLw805O2rDqVKSRBRH7SpwsnND3zM=;
 b=SEI6oNqK4A+kDbjyUZ9iBjaTXazKdzJqxxEX7kXJebqoc0gYLNLSTb0LZbJhjMUjQn
 sT5aesXNZO5HqSyHcbt6FtwfeKMWapLNTqKjibf2b68zxHZebL4hrUHvn/JA39o3KP5g
 C0q4rILe7hmribbYfz9rYXP8kZC1r2+nhUgkLI9Q3I33uGK4E/JOxXpKkZF+PRXg5Wfs
 sx+Xf6G55KQPbxz9m4CuNAGXfbudOXXg+Ynl9Tgu0AIMZ+Y44rWgW/bFEwOEMmc2uE/v
 c8DYH7/XaPFX9zMVT1dHpiaI6sTw192f5a2qvYWuIQjcxMOcLi8qFqKAqvZYT06s3e2I
 0woA==
X-Gm-Message-State: AOJu0Yzh+78RSvViBL5tzqn1uWIcLs8eGql23eoYSIxE9cxCIJobi2mb
 YBCyoZHEh/NpIN3DHSEGniAVVlccmVyB5Un5+tjLFdu1NvFuQJ0kS/Vo8OukCGOVy0nSI2Wqruq
 HhSSLXp82UDElunhU2Rt24BoEvh5uwTOKOXeOOX/RTXT8dxAapQoG2+WZ+9pzpr0TeUHh
X-Gm-Gg: AR+sD13nNmVvSu0FgkfwvQBw19jS+Liq+2fprTqU2daf+90tBcMQ2aYCF2VpfWm+n7l
 4KZNf/Xy22SjFJryXD+rycnhatE0gk/oiztQkgQp20/mw3lsU4g4703vG2RjKo79Gl7h75lE4d3
 4S6IS68AVJoh72X7ZBVN9RIHNC6e+cws1xYCuTV3Jz8dP7D327HoN7C9ODlD4UMf23nRGS5TYgq
 rSi9ZeodB0Ub41DzhPwo3D7SZrbdRRavvWwbPBZFptDwN98Cnh/aRBxV3BSZDAGC8zxFEfBgnrE
 gbkjtCjtB7GQ7zvAz7Wp7hxEz0v0RCHTuyNY8Nrv7wrTg0LOdcWuy76VR9X1vvtHg7l8+TMDnCo
 whLKQYfeu+4u9N9D0stAbmM20OLarWZse2TkxaZEcJOWPzS82cICO3KN6iII1RxPQ2JudcO3sNs
 RJb9fxGXn44Og2zKsPzl1yO3/7s+soa74zSUD8dD3FNBcV56jRreXckkPeBdak3oaBuROzBBJOe
 vGr/g/5TGLtMwzU27oqx3Yy82S75JezIVQnMpySK/1cQ66A2z3shjRIikil00eJlJnR1BhLbTuY
 9BQDYMs823jznAsk7qKwrYGmIc4A7avKmhWOxDo9fj78MBPft28=
X-Received: by 2002:a05:600c:a4b:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-49804d284aamr19860305e9.19.1785437349818; 
 Thu, 30 Jul 2026 11:49:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980576f068sm4345645e9.3.2026.07.30.11.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:49:09 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 18:49:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: be6c6a3d90fa90273df9a7097609ffd08b0298b5
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 18:49:07 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <26357eba4a1fa53fcadce256374732bbe0524b98-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpVoi-00049m-Hb
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
Content-Type: multipart/mixed; boundary="===============2521955754480028302=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2521955754480028302==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eDCKRoceHec="; charset=UTF-8

--eDCKRoceHec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 21: Code-Review-1

(2 comments)

File src/openvpn/multi=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/98aca297_0d5d3b01?usp=3Dem=
ail :
PS21, Line 26: #include "siphash=2Eh"
Unused?


File src/openvpn/siph=
ash=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/70617dc5_9=
993e60f?usp=3Demail :
PS21, Line 23:  *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA=2E
old header



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Chang=
e-Number: 1573
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul=
 2026 18:49:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--eDCKRoceHec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 21:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>2 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/98aca297_0d5d3b01?usp=3Demail">Patch Set #21, Line 26:</a> <code =
style=3D"font-family:monospace,monospace">#include &quot;siphash=2Eh&quot;<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Unused?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/7=
0617dc5_9993e60f?usp=3Demail">Patch Set #21, Line 23:</a> <code style=3D"fo=
nt-family:monospace,monospace"> *  51 Franklin Street, Fifth Floor, Boston,=
 MA 02110-1301 USA=2E</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">old header</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3De=
mail">change 1573</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 18:49:07 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--eDCKRoceHec=--


--===============2521955754480028302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2521955754480028302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2521955754480028302==--

