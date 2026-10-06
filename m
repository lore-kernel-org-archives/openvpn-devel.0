Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC37CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqnpKieaQQDlv1dTrIuvsawEzRkN6Zu+m/3hTh/OIao=; b=IYnPnLRTSFwvD2gtvm/WtXC83h
	Jw/J373SIG8tPvYCxvs6ziM/cE1nlyfqKY660ELkGZM+Ctlh2Uq0szdJN++/KaPmVSH752BswWW8F
	GXMgGPQ+R1HYFLovFOcrP/0tCtaDKfpPKttvXOn6yIZm/MiWv2UIX6q+tr8JOVYqD1wM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDzJj-000594-PC;
	Tue, 06 Oct 2026 07:10:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDzJi-00058y-Sz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 07:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8HIeZIMh+2oonXZGXMMK0tqeLBwQbnWdZE0slyZ9N10=; b=DsJKiOkwBwUGDEqVFgj24uK3d+
 QLMk3dnCOhNgYl0FnQ5KjlKBiu9HAhQ0kU0Ghz6Oy10J2CcRgnnSLShllRgt2GzPMxqTWK7vbFw94
 ZisGyfW+lWcH9DNM/N6zjkMoW1J/GggiXwUy450pgflps5gbpZlvSPkB23RiQAdB1tkc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8HIeZIMh+2oonXZGXMMK0tqeLBwQbnWdZE0slyZ9N10=; b=K
 F+uepfWOQuSIRIKSlfpaOgTVgJBeAUUDLmsQr/XmW2fjVkyck45F1LAHOgzVQCCBdKST+jKv+QH1X
 reHi918RzwPLuMXsa0E3GDofjx1TnRWK7IZ+0LtfFSWebUkVtw/gqbQj2gWYDd/I3H3ATPyInxHNx
 5Lu38hTmoPn6hnng=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDzJh-0005iG-RZ for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 07:10:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so181281f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791270619; x=1791875419; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8HIeZIMh+2oonXZGXMMK0tqeLBwQbnWdZE0slyZ9N10=;
 b=JkAY8zea6i2HeGluZaFdvmhSISTEs/eLK0HT6RnyTeE7JSYPLJPdhMNWy1oEQdW01k
 bI5aN2hbSE6n+H+TeWjIxj4FfMp3ZP4tluWvpxocJPm2eJsqFAf+MyY2bKX8335UbXAB
 b2leBhWWRgB8rjk+vep3Y8DtAHMuFcUHm+I/jQINc7rwKCr6oWFcqDwlia1+2OZWmWe+
 Mn+bb+xqWjl5E8XmkjA0FMX4cG3w4QpzK+UyyQZbHm+RknY42k0CU8fTnDkXked8dFo7
 Fkboa+mI8SPXMzQ10fGBUg6Ocfbo93WNtO1thwWwIalKNXZYas0ex+B2R0psEppvETS2
 rT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791270619; x=1791875419;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8HIeZIMh+2oonXZGXMMK0tqeLBwQbnWdZE0slyZ9N10=;
 b=AsADbBbmC+BMgKRE/cmzE0JhhsUb1fyNOjWeiyBmrgL7aiQ7YTnSmBiUtTiAloPAYL
 J3vYFRhe8lvVb/vh6KeZf40FOTCvHdQepPPIxtakis4fb06iu0fgm1esCXNsKLTszpuL
 /WFP+5Xc1ZBtzmGqh9jxQffGJzbJSaArz/1OiX2m2LjxQjNEnkQcitu+sDzGTHtK0/18
 fqYug/qwKhLY+qmQ87ZhRjRi5zNOlb6Cz+QTOoHvDJPlEHHAAVGnT3CrAtatcSxPaDdk
 4iwf1OmzIGVTyBujLsrZjlF1jCYJDOyuCmqd7aDj5QT8t/Gi7M1jhVrrVCAPudH9f1p1
 VS5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUB8cq1OxedgwiRIYGk6OwvsyZaKFDQ9l6quuUb86gdq1DPhsbVe6q7UmwHTFoub5lmxJNErRdlvkptf1J@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK+8rtgRrNgX3k4bxzQKMlDeI4uaeGvXYi0oW5M+niPb5RKVtF8
 RaKyEzxtQWev8KCUebMm3qNW9LVVZzGCg9Il137c51vl5kxtglQabq4BHV1kqFWF2F9P4Ina5st
 zUTdTSBZ1Hm48Vb5KLTjFTctFSA40RCdl47o9bdRyld9zkvOs8+aA6+ji7zyEYtLeAf+9
X-Gm-Gg: AYBFou3Xq26feiCTqSWRb342POg6n+ZmqYbgCnstIrmXTnyrv6SIl43t6/9RnsgM4wq
 V/mg6ZCAbk9888tHm4J5WVea8EF6+bnjwc0xNUwH7oR5AnSusgLzqG9D3JWgBtxusHCoI2SpUYV
 3+0lY4pv2o2i3zw+sYuPVq5TYfLRxE8n3Vk0Aj5dychdDZJT3F1M1bvZKNrsVkWy/ymZ9IppAHh
 ywzsRJORqNTXxuryb6a4ApKT9YrZLCi2zvPrVZTrOUhDIE83M9YDR/Rzq6M1+hOUQTEQ/Zq7lbW
 VovEppZ2g7wPdu7mGNPY728a6UJfWcJ2nVBaeDNESFnnWRVMIzEVadlKw06KsnAcvOwnhRDLD9L
 adZ7BGH9NRGaMX/17JzuqcP5+SNCzpYTO2rfiCRNNWUfxYMcVkrHRleiJHUY8kkp+JsAd98TGs7
 YKWcuRcfSUhhyKLoFYS24sTNNEx/nsKfPtzFbtTekxomQFhIJV6uPSvNOQKGVNxKmfIGGGXyIxE
 8GPnT2lpekPDwdu8P+Mu6JY5ZC+9K+TK+/Pd19gZH3umisDKE15z/oldQ5U1skHeKF+djEQQYRZ
 9+1yRxpCTF6Kuyy/jqJE0GBi92zDhv2GSu6kjP7qIL8tE54zpQzU2TJUKhPxZG6vssm5gSM=
X-Received: by 2002:a5d:6f16:0:b0:48c:4649:b020 with SMTP id
 ffacd0b85a97d-48c6d15d186mr848421f8f.19.1791270617281; 
 Tue, 06 Oct 2026 00:10:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1203423f8f.55.2026.10.06.00.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 00:10:16 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 07:10:15 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 01ecff0a2f8a41597b0a2350ae48ad21162eaf12
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 07:10:15 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d81b3e73fcc9213bc5b30f09d01b36254f2435b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDzJh-0005iG-RZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4420061431462368308=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4420061431462368308==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CS5e87L7z8o="; charset=UTF-8

--CS5e87L7z8o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, chug=
ly=2E

R=C4=83zvan Cojocaru has posted comments on this change by chugly=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f0=
85574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 5
Gerrit-Owner: chugly=
 <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Tue, 06 Oct 2026 07:10:15 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--CS5e87L7z8o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, chugly=2E </p>
<p>R=
=C4=83zvan Cojocaru has posted comments on this change by chugly=2E</p><p>P=
atch set 5:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=
=3Demail">change 1946</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chug=
ly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Tue, 06 Oct 2026 07:10:15 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--CS5e87L7z8o=--


--===============4420061431462368308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4420061431462368308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4420061431462368308==--

