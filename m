Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E3CC982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=of2rVeTciG1MSXWNbV3Cyt1D/3lySlMoPCgZpXaRYRo=; b=e4rSvDkQKrQKOzLvxCL7skTY1A
	6zLBYvsV1UDg6ntmR1r001q3pq9RMjBLM0L/VACv6LDV5vedYbTQX8s/x8lkgkQCuY5hjje1zs5eX
	qMHkjDUyDU92FdvKnTTTOvLLRoavuTAwDtGg+djTSNZgApFBLBcKrBvQh45AIIt1z/6E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8wnm-0005H6-KL;
	Tue, 22 Sep 2026 09:28:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8wna-0005GE-8W
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:28:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HXjGttyD0t9BAhG4axCOY5d2AYrQdlr4klL2MV+rtJk=; b=kr4n04DvkKhBPZCg4O6cn4q6Dq
 CVR+B76VevuyzVI/kIr0mXcjcs7Dn42tFjdxTwoYaSGD39sVXu849lGvsA5dvYLBo78aIPSAWpcYv
 2qlgaXp1Dyp2D6u3cwGKYvHqAhn66svWPQBp6yTxUVG8BoB6Hwa0MED0rjldaC5+r1r8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HXjGttyD0t9BAhG4axCOY5d2AYrQdlr4klL2MV+rtJk=; b=W
 7Vl8er7q5NMlGaMvZaowdrmA634zuYC9FC1efSmni3jSefTJY300rftuPzj/w8QU0nqvyP4P7XzvO
 yS22ZlLxONp0PDwc6OpSwhNTUBH4U4mj3+wPyxG9DYMH1Z0o1H4W41kFHk/C1AHc1D7NGx8vbDBK5
 OQs/CvMuMusQLyqA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8wnN-0008C9-Bm for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:28:14 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so28991405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790069287; x=1790674087; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HXjGttyD0t9BAhG4axCOY5d2AYrQdlr4klL2MV+rtJk=;
 b=JK1EtJm2p+YJtPRfY8YMFMmcSGcS8ozdszMhGuXbM0sNm504JSefBBCXW271Tfsnka
 qBvllYwk8+k5GH7pBcHXHeKgMa7ZcVEX9ZnlhFpq6CvlKoV7dwaoHY8EvX1dvY4aQinG
 Bpgog6nAuGIckFzh0Ck7waZK0ESWKbl3FoLaatbO4hhbG9grd4uMWk/829cBRLWk8LwR
 Ti1PUB32INaLAzp2gAvUEPQhKAUcPfAsYbOxVr0bzn4fIqEkAyZq348o210eE3Ehcb5P
 Xqx+ynhym3KLWDulJ2MCBXtqAETOlU5rOzunwnGvXS1z5F08vH0NsphZ/VejY1rn8xQ9
 ca5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069287; x=1790674087;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HXjGttyD0t9BAhG4axCOY5d2AYrQdlr4klL2MV+rtJk=;
 b=HqzRkSlZBJ9Hm8F8UuJTtmtMUD8PNduVAILEzIxuBJiPdy5paypgqAnhNKRIkUQDAD
 B+3TmeB5BGVMox57AOOqQTTgrG8io+Ee6OD71gnYbfgGU+O3yC7pYrvEsdqvjOIIor3g
 5LrRcwCpQzsQe0XWQdrSlUKPRrZ6tsffT/wFg4PRNeceetFe2KQzk9q3l8nlcHxVprzU
 AaY5nJ/POo8ZaYO5e0d+FNk1WXRYwtkyE4ak0weWvUk2K4MpQs4D0n0x4gZOPgUvlruI
 Wy14axNWoyw9H+4ozZg0ORkf9HBTYfOLix3yC3oO9hS9JV8JI2uPpoh1wS8C3OioeeHo
 yZxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6MvEVk9iHEC1xhgpkCFdQxuw8T1KfSnqrxCF3h1299VNZo/UL09vYXalR3Vf+Wg46AoSbwzSwnmBC79Gi@lists.sourceforge.net
X-Gm-Message-State: AFuF++leiazoFGHRgaE5Ww1b97YChIuyWBIZe/BdPQQkHxx5Y+pGWl89
 jsibFcHWb0j1OoGtjf+6uV3Obfrn0v53GhSbTXbeh2Z2WSxgoWmy+THrnh8OROg4+RRyMu46f0+
 uyLG5jyWMSm5qYpVmKEDjvi0VybbsZW0vbdLvFu9Cf1VhFWw/raPC5WU/rKUu+txZE0MY
X-Gm-Gg: AYBFou1bG7z6Kr7Dud+/pt1OudUrPtOuvaK8Ia20HnHBssXeR+1hRgRRrhSzoSKimm4
 O5zIRxKzoo0hlrXibQA9fe6A9tMkMq2YJnB5gpZaYzdWUpyT+ZsvagCH7llAlgBek3glfFO62EM
 qio00uCmXIHfwNEOG793xDV6Qhrxj4Au4it1TK6fO0ugxtsmYr9lNR8DZ0UMK9DZ8eS2kdvi28Q
 AsZr226/p5x/NSwVPrV6og9DIYXbi6pLL1ySGKOIWpAA+pVFBhCmB1yI5iEySHdeRUeH3otOb7g
 Tt4brDVrrz9JZWfSv/+kI7f9JAqmeTA3XvYtNmhUBJ5OiCS37tFARiumRijlc1DLB1KnT+ffp3j
 EhcfBXi8ABWr8TyLTT7SwLwMBxKGPFZ73QepEMH3i3s1v+iPxZtbrePXqBQGGsHviyutARm7j87
 wI2TqFzIGxU0LQZ5pKY7i01h+KIxusehlDZCIbad6gOG3q57jxYng1Es+TXFhPI3ETxPOi/eQw/
 SFPGaQRZe011+Y2vd50BoAkM7/kaxDwVzH5GHuIl05VuoK1RcI8HFbHAPFGrf5pdSb10OUjWpkV
 nXYtW/Wz+vP2mvumDARGeOn8FiM6z0QampnpRwyjFOLDY+bk738jbdjDzPJo
X-Received: by 2002:a05:600c:8b81:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49fc568125bmr166774715e9.7.1790069286783; 
 Tue, 22 Sep 2026 02:28:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab0c240sm25718245e9.4.2026.09.22.02.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:28:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 09:28:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 8ae8cf42f776f9988efc51209d66efba08eac01f
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 09:28:04 +0000
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <026cc53a1a7a7600529049d115e4af71b5fd8a9e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8wnN-0008C9-Bm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update September 2026
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3266846520727977660=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3266846520727977660==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R4Oscmnw6nE="; charset=UTF-8

--R4Oscmnw6nE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1922?usp=3Demail )

Change subject: GHA: Maintenance =
update September 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(2 comments)

File =2Egithub/workflows/build=2Eya=
ml:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922/comment/3499181c_18b638=
e7?usp=3Demail :
PS1, Line 50:       - uses: lukka/get-cmake@591817e96fcad4=
3505fb4eae36172462abb3a42e # v4=2E3=2E3
> I'm definitely not an expert in t=
his, but should this be bumped to 4=2E4=2E [=E2=80=A6]
Done


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922/comment/9d56841e_ff91c2cd?usp=3Demail :
P=
S1, Line 293:       - uses: lukka/get-cmake@591817e96fcad43505fb4eae3617246=
2abb3a42e # v4=2E3=2E3
> 4=2E4=2E [=E2=80=A6]
Done



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
G=
errit-Change-Number: 1922
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Tue, 22 Sep 2026 09:28:04 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--R4Oscmnw6nE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File =2Egithub/workflows/build=2Eyaml:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1922/comment/3499181c_18b638e7?usp=3Demail">Patch Set #1, Line 5=
0:</a> <code style=3D"font-family:monospace,monospace">      - uses: lukka/=
get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">I&#39;m definitely not an expert in this, but should this be bum=
ped to 4=2E4=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922/comment/9d56841e_ff91c2cd?usp=
=3Demail">Patch Set #1, Line 293:</a> <code style=3D"font-family:monospace,=
monospace">      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462ab=
b3a42e # v4=2E3=2E3</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">4=2E4=2E [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">change 1922</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I983d67e1c90bea460f531=
f11d4c58d33a351d81b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Tue, 22 Sep 2026 09:28:04 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--R4Oscmnw6nE=--


--===============3266846520727977660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3266846520727977660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3266846520727977660==--

