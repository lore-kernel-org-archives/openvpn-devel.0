Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2170CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxZIOhqjrFjLdL5MPrX5tT3Mvx5SJEdNkvjj256FpII=; b=m/rCVlVSIRkuInNOwnEOwqoqC+
	bB0e4+wH12cmfYjTS6u8vMXdT66rbmG2hWQCMRm1ZwBxJdHpCBcV2RNjTh3Ng7y90tA9G4JI5sM1I
	TEDVlv4dlB7P9SxKqnzY/+Amx7eshEoynsd3ZCLp3hFty1/9uU3xV4HN3P8S0xU7L0gw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbh39-0008RZ-3y;
	Mon, 22 Jun 2026 15:59:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbh2w-0008R8-9O
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cszgzuvsz+cAOxyJAJjh4X6+24GZDSHKYT7EsEC+hAw=; b=MdN9Cxq0fowJp6Qu9KXmnczfNM
 vwUvoLXB4LCWQb3VzVxk6tjDKCPipSy48xM275ztRDYw2Sg4CV1qzVMV9cn77nmaVTluG9I4WZykK
 GHVD2oqyjFieTfQmq3FbBWd1GNePHL1uCB53dyU5BTs0Au2abAZAJzE4yV9rKDRdAHmw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cszgzuvsz+cAOxyJAJjh4X6+24GZDSHKYT7EsEC+hAw=; b=K
 eXSxLoshgjyUJAqG0nJYK66a9cfLMUXyUIMdyzJRrtccP2wZkVglsURw00TVKlbUpOrl/B2eTapCL
 U/+SSECEtzD+uG5mBFDEn4tbYDkegBLIpLlrk6XtaQbEeipwsczRii4NIjVUydSFeeZT8cS5uA470
 igm4vNOKEj1/uFVM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbh2v-0000ZK-6J for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:58:50 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso30090365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782143918; x=1782748718; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cszgzuvsz+cAOxyJAJjh4X6+24GZDSHKYT7EsEC+hAw=;
 b=Si6fQw1E01M3wEK63V5Gbj7A4ZUuOria3z5gIgaowtzckLXZegDg80/3Li3Qq7LCBS
 /WiIoCTiZd60fclkIEZ4AYI+L8Ci8vSeuI3tqVHkuj5E7wMfmaLAsEMuwOFQ309o2XH8
 foEou8wz+/sq0RpH3atdX/cazQtDDIl19CXxwYGz1IjRNKfMKILRJMzRA3Zh/10NB/z/
 FnBrmMVNGHZamfxvu1dZoIvA0JhJuUbizzqcLDTqhqJ/omScL44Q0oRr62qHod0ZM/m6
 hAFjebCSPoPAz1UeAYtrd2BXdbOuxUBpmCnJsNoQLcGTpKrFW0zFPXYZ5JDgMftCph4q
 EYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782143918; x=1782748718;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cszgzuvsz+cAOxyJAJjh4X6+24GZDSHKYT7EsEC+hAw=;
 b=MDaeqanVwMmtEMnR07X+VwNHDOVsBjVpC1bht4qgnP23m7CN+4hubtAunO+LR5vB3M
 UBd/5qoOKEYCoOLif5kP0Y+cJQN+Zq39KvXqcQqVdgApqVBhI7jADjCVYtTVh3mZkP8V
 wjXMFsLlZsgXD5sEXAjZRpVWyB8A9uJ0gzMj7oF1E4VaPuRSRlgCid6UOndOAoVgnpI9
 tX1Wb0dO9m/Xkm9x4AROzfoxOclUcelJE6SVzUetUscqbz8qaNBD7YCf2p0gVRkF8dQZ
 3ClPOv8jVUNj53r8omR+0/Z8H+C0Cc5c5EA64/UUurelf6AQ+zcqeKDOkLGTdT0+Y+zS
 2aKA==
X-Gm-Message-State: AOJu0Yzt4CbZG2XQWvT3M9/zlpsTnnFOYUhNZglcrIxAF8luw29OaIit
 f6eFds6WamxJfP4Al8vhqaPYioDiCjFagIzA8cJj9pGB5X0qXmHAeh3DfCmpnZ7x3qI3IL6LVh6
 Nj83xWJSzTH9IlQ+jcwL1SvNIESEcOYHs5uit18R7B2P2JiMn71RWEisOJapxQR3jJR3Ju4ns8q
 sGinGJcg==
X-Gm-Gg: AfdE7cm0v33ZIJO4bMvdOV9MS3TzB79fm1EGQUUldUycVzscRMc4qNOFpCUAMwJyM55
 VKdW8x1sDat5JoQd1DK2it+CLKTUwePNKc3q+o2rPWck1009lO0nCMnJ/bNQBR5A+JLxT2fth/u
 Eh6GvMXs7L6bEncwo7qAl1VBx/Q3DYMKlfzAQa6AWQFvA8owc+tbIZZRi2A3D+ZQHp5RRc6aHzz
 4BYMTywHcAq0LzK9+BroPxDl9/3JxwNJn0/hvW7kZSXI1fEljYSvq9+eaKxt5xrDEIqqRgEeVdb
 xvNRffuAiGvM1takQekAygql6OYJKbyD/GRpXYdkUZqPdxnDNtEOz6/rp6okfQBj2LzXm/jAYb7
 xzxOLGwKlOg/ScM8PdS2BySGM9M/KrJiFujkuVbNa7KY69K7/qUrtZ6sQv/vmVEj20A+CsaXsrI
 FOeWzdv6DOdTtzKDr5zAWEUVkHi8jdAK0+lGrCT2ZynrmkdguIe8vVnPTezz36ChW+wvku6Hg7C
 nYshUgwXurWaSGIXXfpuweYdS2ereJP85LEzH1wjabdQg3cbeibEtmyRbG7j0b6mgkkx7dkhR2q
 8l0=
X-Received: by 2002:a05:600c:8b4c:b0:490:be1e:6ce6 with SMTP id
 5b1f17b1804b1-4924908ab39mr168932525e9.9.1782143916938; 
 Mon, 22 Jun 2026 08:58:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57b8asm27911592f8f.26.2026.06.22.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:58:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:58:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: c257cc89966792bed1d61c4c2c098d8ac8e09afe
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:58:35 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <266ea752f4a272bb270896607c65d2aeeaf6ff47-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbh2v-0000ZK-6J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============4340018167500610033=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4340018167500610033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DPC80/kl39g="; charset=UTF-8

--DPC80/kl39g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review-1

(3 comments)

File src/openvpn/mudp=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/ea313ee4_ec462b6=
9?usp=3Demail :
PS2, Line 264:  * @return      instance matching the NULL o=
therwise
missing word after "the"


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1725/comment/a0104c6b_d07b695e?usp=3Demail :
PS2, Line 267: multi_get_in=
stance_real_udp_real(struct multi_context *m, struct mroute_addr *real)
why=
 the doubled "real" in the name?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1725/comment/33ed15bb_ff5fbcae?usp=3Demail :
PS2, Line 298:         const=
 uint64_t hv =3D hash_value(hash, &real);
why is it better to call this up =
to three times instead of once?



-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number=
: 1725
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:=
58:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--DPC80/kl39g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>3 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/=
comment/ea313ee4_ec462b69?usp=3Demail">Patch Set #2, Line 264:</a> <code st=
yle=3D"font-family:monospace,monospace"> * @return      instance matching t=
he NULL otherwise</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">missing word after &quot;the&quot;</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/a0104c6b=
_d07b695e?usp=3Demail">Patch Set #2, Line 267:</a> <code style=3D"font-fami=
ly:monospace,monospace">multi_get_instance_real_udp_real(struct multi_conte=
xt *m, struct mroute_addr *real)</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">why the doubled &quot;real&quot=
; in the name?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1725/comment/33ed15bb_ff5fbcae?usp=3Demail">Patch Set #2, Line 298:</a=
> <code style=3D"font-family:monospace,monospace">        const uint64_t hv=
 =3D hash_value(hash, &amp;real);</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">why is it better to call this =
up to three times instead of once?</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">cha=
nge 1725</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Mon, 22 Jun 2026 15:58:35 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--DPC80/kl39g=--


--===============4340018167500610033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4340018167500610033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4340018167500610033==--

