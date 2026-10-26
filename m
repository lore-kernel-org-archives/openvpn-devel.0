Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB1606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gOt3W6ZI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N8BZXeqm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=STielyQV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XX33S1p7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=anCim+LRRh1A+rJmObg8g+lm2t7h2pEzyATBNc9gblE=; b=gOt3W6ZIIgr7QH0jZedVd8JLE7
	RfBIEJc0R/3l5jLoQzVeF9Z1cJhIsfx1R/rSjqt4QxOldw0ZkMKcvMSkOYbTuSj97OJg/4XrBVFGM
	v8rWd10quNZoZ1CZnLfhL4e22NK8d8vx9Kk8fafM+3yUWpxwVO3NHSFVlgnHTmbcJm3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLAwG-000000001eD-3jEv;
	Mon, 26 Oct 2026 02:59:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLAwF-000000001e7-2nO1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 02:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpv5jiEg1Yp4l/WMC6wa4yKbcu9UFcwnXfhDqIFw1aM=; b=N8BZXeqmypO9cGz4Pm4aaGjq9L
 iuPFkduMzfB0tLFoYUWB0y7AN8r9EWwDB7Ial92C/vRXBu8MiBqU1k/DbjevsXgBLmjrWYERJwypl
 flajVioIgKLZgSxtNmA0vubFLiqm8cn5g/bAN3wxlJ+7msXC+nfj+VY4D/cm5JJqm3QQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpv5jiEg1Yp4l/WMC6wa4yKbcu9UFcwnXfhDqIFw1aM=; b=STielyQVDh0fdSsJsJ2q0M+Y0i
 AFLIoTnuJWkZFX1woS9vd9R8AVPe6Pa7aSybmGsGRs9lOkvcOo39/PxSMs17A0yEpJWnNBRYLLcR0
 D9X0MSY9Sn2tsC9FHYHBKd6qO4HKN4fAW8CRG8p7+90A7akbCr9Ou+DoHuu9V+CyRxXU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLAwE-000000008Qb-1BS9 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 02:59:55 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2309787f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792983588; x=1793588388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vpv5jiEg1Yp4l/WMC6wa4yKbcu9UFcwnXfhDqIFw1aM=;
 b=XX33S1p732cIMrL9NQkDYvkICULD288jXiRuQ9Odg0fpxMjkOUkEvAKlyZ7YsL7U7u
 OsKva1D4cNQexxvzuxOPNhN/F6UukIPleW5U1674tD2TGB7l7ji0/wvXVsoo7829jB4F
 rfHLJFqF+j8IQz17cAjonky+oKmnSamude9HCQmpRjZDjhAWYHBZ2SOlL30ApqNiGtGl
 UCN0hGogbM+UQabWnpu0t2kW5DfB83GtRNEbNMR0Z1bhR3L2lVDZRpXo6o+uQHQTdCbD
 mvvfRHcyRGvglX4vHv9BQ7UOtFcA63AVvgFYgxOL32BMZSnjgyduJrNxVVAdFMPJv+cj
 LvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792983588; x=1793588388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vpv5jiEg1Yp4l/WMC6wa4yKbcu9UFcwnXfhDqIFw1aM=;
 b=kntfu+U8/+UHcoAiYMKTJJWX1ohwnffRn4Y4p2fMCEc6FxUe1HeEi5+qz6ITwZty/e
 hkRvJ72+b19xcNAD6lsQEzDJncz/Z0FkZc8rpPTLxS+WTYSQH8bbLrr6MtUraPDPc4/2
 0/10voGYrHFatb8mqiuYSlEz1OmYHOl4/sHwRA22PY4RG78DwakEuqtRfLakHJcUOuFy
 1BW1Rqk4k45IgMDsT9G0p+RFY04jH1tYFO/1fcFuZKfFlwFOZRUbFV3RSOCUlmk9akmk
 6hswQmQzXfftQl/60b/sgMNu1ytieV3P5OxCJsE9ZW4Uu/yTXeBwXhc9NnG4dyPywKJl
 yHfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5oBD1OWd0M7s2vhhSnCX3OHhAmcootLp/302BpQ7UC1ErqH6oWzSPuvW1ZIFYMxYt3LZL6fBpNpMm4WZI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLdsct6JbYYNTcYSWp7GwwGwX6Lv0cpn49eYM41Qepu4WxSOlz3
 Me/RUUY9KgbR8U1pA0DRmobrqIlki+BO6bb/9IZUzNCRPy0V+/aBtBG61sg9RIlg1k2YMpLLeq/
 cw28hRbiwthgwo3wDBU77n+2/gfzUBJTq4P2ZzRjWWdPFGKW5Uf5oJNGgj/fui5yDDA7J
X-Gm-Gg: AYBFou2RDXElfZGott+jMOB6Wzr073iRm8iCccbhpoCqJQXOj2KkQ0K7+xsG9/UMlSy
 WHJOsZFD4uM5XJkF5rwuW+n/swa3BL+/e8lo/2nV8BrvbveyxVChMVmuQKCGrLvAaTfU2C11/om
 mKHI0ZZgpVckQ+arrSoUXgyRIz08UqDHgjdhqtSERJbgfq6OwIAN0WH0WXGHFjmsCgQjlTSFRlo
 ZYX7SJQ2ZZ6a/9vZH+IFOruR/lvBJ7d5D2ePlznS8YOhfmm2IcpwKS5vYrcn6d12Fmz43Js9NAb
 aVAS/xq39sKNNxYebL4sp7KCpCIbtVjIZRFGsK6g1ZQ1f7zmIa8gBiDYjLpeF0BYaILYtdU2v5V
 9001TknNQwBwwaDizXZkAyIqAyVZGvBmy4fJHLd5jAxjD+QJ2kgFxkVbJaXSExScOd/OlpnviYr
 cwfjO/U4euQQwxTl089ynfWgKC3FuM0KK9uwN/JATbRDyykFZI17b+CJ7bgrfJeAiGa9a679Ylh
 Ze+uFLbF94HoFyOQgsiBnlRVyZAbPAdk4EqrLH28UJXI/u4ZXotdEe7dOEWhSGjvQlmvGJX/JGH
 H9SbF7g2Lm2YIXm3oAnmfYIxX9B+5yd1rRh2dkad9aKM4bLi4LcDPKtRnwldpOTna0ooVnVqD6I
 KOrygKAnH5Po2WpEHVP8VpDcSrACF4O6FhiKVmFpoiA==
X-Received: by 2002:adf:e198:0:b0:48e:4300:c70e with SMTP id
 ffacd0b85a97d-48e4300c8b2mr12119252f8f.46.1792983587489; 
 Sun, 25 Oct 2026 19:59:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3da7sm14398788f8f.20.2026.10.25.19.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 19:59:47 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 02:59:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: ba8d6bec6cc54fe12ed373e0f52d46fc526763d1
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 02:59:44 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b7fc9fef33504d5b8a84566a6e9ee755a633328-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLAwE-000000008Qb-1BS9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3441523263181897777=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3441523263181897777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="biXxOhdWxGE="; charset=UTF-8

--biXxOhdWxGE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

chugly has posted comments on this change by chugly=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

Rebased onto current master=
=2E Two changes needed: a trivial Makefile=2Eam conflict with the strlcpy c=
ompat change, and a stub for openvpn_getaddrinfo, since c83d2f22 moved it i=
nto resolve=2Ec and route=2Ec still references it=2E Otherwise unchanged fr=
om PS5=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
946?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55=
a7efefd31839b00ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSe=
t: 6
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct=
 2026 02:59:44 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--biXxOhdWxGE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>chugly has posted comments on this change by chugly=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Reba=
sed onto current master=2E Two changes needed: a trivial Makefile=2Eam conf=
lict with the strlcpy compat change, and a stub for openvpn_getaddrinfo, si=
nce c83d2f22 moved it into resolve=2Ec and route=2Ec still references it=2E=
 Otherwise unchanged from PS5=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><ul style=3D"list-s=
tyle: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839=
b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 02:59:44 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--biXxOhdWxGE=--


--===============3441523263181897777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3441523263181897777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3441523263181897777==--

