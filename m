Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6BC5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvH8eKkvZwey77b/xybYyhe2QTgEjAF/LXJnc2h4Q0A=; b=F20h1ZVQwApLYxVhmHB/fLs7Db
	jddt3GwtCEXkEouXAujc1IM5zVeD5aQouz8AaaJAgG5Y6kpX92HgCJbxRSY8yqUgxeFdaohjO+iS4
	F6rP6/aCF4N0OBYaOenO1aDV2kFKvPItW4xwp+1E+b3SqL7EMBZxvTe7bWlxRYOKgtzo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvvpX-0004Xx-DB;
	Mon, 17 Aug 2026 11:48:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvvpW-0004Xr-Vj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rBcTLo+P4zpboCaV41tREOeT+bU3mJn+WjuV9tjqIdY=; b=EqoOO0J1J2LaEpmMgoBAPc/ST8
 IUdOGeNSfQGTph9bt0RBGMCAMIJ/HCWhnAGC9YF5wa3sS/iUP0bh3Z/1ygxMJaxptiY4Smn1z5NGT
 UePLL0dR2B9t24OpgJ8+F8eUtREqc8oIr0htb6jJk9zAmmOqQcseoEIHQVGNCUaaEQ+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rBcTLo+P4zpboCaV41tREOeT+bU3mJn+WjuV9tjqIdY=; b=U
 Rp3eJ7L3PwvIRsyoWKkv8HX8U1EkP0by1UtlIU9GQDza+IWdwvJ15jE1nUZq3HNmN9c3vzNn+TaaN
 4Pky0LrjcbwKzggn2l+EaJ/A5pCuDJOXuqc0sXo8NaTz8xHCRIJau8l37lWlf4Uc68YR5aC6kEF2j
 z2TqOTYfKjJX8r8o=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvvpW-00048y-CQ for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:48:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so25227715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786967312; x=1787572112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rBcTLo+P4zpboCaV41tREOeT+bU3mJn+WjuV9tjqIdY=;
 b=exU7O73CotzC7yZRl/PanUNBBartKNbTHlk7s/SxJk7fTVzdaygd5V/J5xhYV/5T+b
 vr5+HtqXQxRa9BqfcjGhn2sJF+B4GiY506apM/KWdXsoHIKLotF48OSwvSuo8lzPJ081
 UmYtF9hf3kgHQNEHvJlwpaqP3XDU4U3aHJJbKuDCxq0pUn/ituzk7QdaSfI7tGVHkI3k
 yf+C/pVt92UDcFyteIc7mILBWsDPRD4gxZm0bDxlapfrcj2u3ONMn6qbR+GMCKz4ALis
 vrWARMA7ulNlVSMt/kl7t2xXCSyiSHsLLOTDmh4ALGgldnkGOT9RJJTlxu3UU9cKLxbV
 aqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786967312; x=1787572112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rBcTLo+P4zpboCaV41tREOeT+bU3mJn+WjuV9tjqIdY=;
 b=pONfn9EdgptT+WrXbkt8m64tbffZIfFjEPi64Wq2Q12I5NxDVkWOt4zl7GECXt/x/G
 JuThxerAHulPkQEJs/mUQ/lXgpJ/nAH/LB0+J+5g8QyjTCLqgel2w/G3jI0E29UL0aLz
 P5P0TV8IXbtz0J+FwU5Xz4kXL46i5CCRAtS2GDmTMPX0TjfWrgTd6QwTsK65HcmqwqfR
 +CCzAlwWT8eDCjin4U96Xbhiv1STpy6nUxPCIK2/L6uhwVp3hv0pJ9/x7gjzBpwhWFI7
 Mhf7MePdZwjBrLk6smHXxpzJwPj8WHc2ZtXdoRjZjqT454f/eLMgySaPzZpYxsZesvH+
 QnuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGjiyO/sqx8yrskn7YG9gucKptAe1WSDZTUyxkqpK0ThxUFHBvIpZrWVIJfdTjQduyEhWxbwYfPFIkM2vH@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy63BPJLx4y5mB2K4ik9yQah4rsraCXa/OiHxf7Ik7/P4GP3yB3
 3YscSiaurGX4lF/4keKNyz7WJum5E9rpjofaoDpRcLLubcXu8rYBN+cVatcAZUEHDW6zJ4o36M0
 7PZcDt34tQCEgt+pxTMzKk2ALclyyeJW2N0GUetN4oT/bO5Ydnc2fgeTYPnvuOnrjsibp
X-Gm-Gg: AR+sD13oHqsdMtcWSd3GKAF7kfTXq1NH4x6EiFvcMn2RduzXitj2vCFLAdipgh3C4Qi
 KrU3D4K14zLfjIK1Q/tuUD+8gzQt/wSwycevXzVXbPl/ZKLJqqeztG2xm5KVfaQzrRXs8RnmP2G
 JyYEbBeNmYs2JN8sSKDc9mO/mUR1vYnax22qBBmjt6I3qnbS2z+Rcz0i/tiNcUA5+rzzC+lHdUl
 Z4hjBhKxUxQVT7jBby2JUxq10z3DIWYZyFH64gy1L3t2wou3oXr2W7I4AND8dgtX4L9JsRslZ08
 Nq+PQwcTPR0xbw3WXw0D05WEnpGAXLXsZkMo85QnmPwLFA7I9HB1ErvyUbbXjDeizDitvqVoDts
 Es+fv3VLg9rZY7+K4B8Sso53Jm9k49qTHaWYVJILKWNaHJQicGXTc0LO14XlpWebJbTqIj+xwsI
 UYq/XOWjJRDOFeb/BUckuAQQ3lQsZzmFARgKIyQNZjYnwUF5uTwSogRFVdK5eGeUKDNDcwGBmAI
 8jq7eG+KhAjrkHDM5pveWLiBAHBKsH2JBir7NbO4BYlSXhfDKbKvXNGL88LoY/ln04F00UBccKh
 eOv4YMV45KHFyln5s/7fjALoYM2+68XCwZv1lHNnomRMspt5vaI=
X-Received: by 2002:a05:600c:6287:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-499878ccf00mr344862445e9.0.1786967311718; 
 Mon, 17 Aug 2026 04:48:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d20fdsm233870575e9.1.2026.08.17.04.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:48:31 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 11:48:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 793301a47dcc96dfdd667c31e923d1c416f069e0
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 11:48:29 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0472e03f235c4b7959d4916b1f76e8752ea54c9c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvvpW-00048y-CQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2011770540619584643=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2011770540619584643==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XxQCfkr2B8Q="; charset=UTF-8

--XxQCfkr2B8Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required=
 action returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review+2


-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e=
16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 9
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, =
17 Aug 2026 11:48:29 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--XxQCfkr2B8Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 9=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">chan=
ge 1826</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Mon, 17 Aug 2026 11:48:29 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: Yes </div>

</body></html>
--XxQCfkr2B8Q=--


--===============2011770540619584643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2011770540619584643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2011770540619584643==--

