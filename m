Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2133C79FB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TtZMC1oaEFDQZ63NO/qcQ3Oka/HNoRiH/DW8wfRul14=; b=YCGWnH/UdF/FvqGOK6BG8Pqwd4
	Vm2IhFiOhAvIgxHugSoleIzKwGIyL8XO29rzaarvubDjJ6fzLs78S9OLPfspppf99JCXH7p4sbagP
	bJjuEoOvpHYq898YElWklPr4ABdbZF4VmUjKOyxjJRdad9mKqRzdoa0Rg/xnlMMZg4sI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4ZDt-0000Ca-J3;
	Thu, 10 Sep 2026 07:29:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4ZDh-0000CO-Hh
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DTLts7w+ssWSP1F79sNtyvyk0DES+OQ5gzBNBY8yVpg=; b=QCfgave1vjMybHx27koLnYdg03
 lYJNr9AUa3lKmwH5K4NiuIKAV/25DCPuQwM6kkJ8wHd21a9PgSbKkuICrTkh1t3itCmGO+5Gb4bog
 H1sLyyFNeaehaST1K3PSX1oU8kPLQvU1wMOEgzvIdrtdZg5vERhu/TNUWvfYjfiCQuG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DTLts7w+ssWSP1F79sNtyvyk0DES+OQ5gzBNBY8yVpg=; b=b
 7OHIJ9LT6U5XHOfCoyvZrHCNWLrvOCxP6Qt13F23zHrAUma/C4NvAU8H11rTHpl1Jcv7Qy6oQ0NT4
 u0/GVCuYTkXqFMq8AFua1C3FrKGIRJGH//rhyrkUTKx01uGynlL8JJTwlaRX+5FOwEhuWCN3ImA0V
 IwPX57aK6hoRK+Mg=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4ZDg-0005tl-2z for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:29:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so10843585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789025349; x=1789630149; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DTLts7w+ssWSP1F79sNtyvyk0DES+OQ5gzBNBY8yVpg=;
 b=aSNa6CkKqM3jgILqL5ieC5EqkMQ0En30rWw/EuLE513sU9hkwvxbKMln+4fIe912u+
 B78ain34GPCENfBRNKDH1NGez8RplKaYJg690i8nbT7N+M9feHVM+K8/nUi8QCsEC+dA
 O4xUILaNhiBUTajlSF/h4JD/lYGU8pGR/KP04Umr2FWFaXShrjXNXMptY+JfwU8GXcyB
 E9nfmWxr4QqGXsUrWdivJdMKGBhh3F+zCpqruiDqTwvqvI3wr6J15Z6yZZ19Dil2dueB
 zkceFaVVlHmm+QSn4pTq0aVllI7Ysch+IQgpIXN7nyWkvaCXK1TqMiP6WRLna3ArzIJ1
 AVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025349; x=1789630149;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DTLts7w+ssWSP1F79sNtyvyk0DES+OQ5gzBNBY8yVpg=;
 b=doVi3Q3TK4VJx7dHs81n/nl6mA5yOsDIgiT6YaAZ65M0hWsaWNmQTXud/eQuBttlYE
 /eDTKRbpyIq8pl/Qfh74aKtQsrq+jwHMcyOjx+AdFPBNChfD7LYEAJn1fhhZ4JC+PXL5
 rwHUsa+yGo9NkJPjF+UlaOz/TcOCVacA8mwXsu9BxzGKKd1O2l2aHl6lcwvuNYea9vkO
 UvAZk3/OF7BGfXMfyxa31ca/iDborNvcheCfBBfeHX4UZ3sUVFtbC5fjNIIkVdYYXs9M
 0GwiAR3EEp759MW1Go6UkqUOsBfOcFBrc3XehYzZTeZZ4bWpKSWnhbFKLnPpcT6FZaF5
 erPw==
X-Gm-Message-State: AFuF++misBWQvDUpnF2Q7hjUZrhogRG1KWBmKPxNcvLagIIGdBgrMf2c
 QluQCuRBM/NJf5ViPWj5e6F2wtabP+ZQ2YvZ+dF/fPN9VZ4OTJRku3wmH7xD9rrzwSid31m1sLN
 Q519wyPe0+Q3emrav9m9AN2YyJX50OVgCk7R905TpXA2dzD3JtGpwGRK8gI+Knt0itxaH
X-Gm-Gg: AYBFou1X/UFi7llJakhtSP5HUmpypoYuMSn6EFWsXOxFJ5iEJrRWwB5FFPwfga4JgCE
 drBcVIUATZJZOwREHqEow0bvAAbNRsKhqOy9q3KtomY1MpFCJYI3Oo4yQ76VCJxaydq/tZi98zB
 fcaZgqd8xVVQpLaN4MIaX+echsvickCIMmvfkGn76r9znIAi8t4K8kI0rxKzBQrWrxcJO0fdnxl
 g9NAj24cBnUOqtQjc6zTVJz190my0l9mBtReaP0gQ7UUlZVEcWwydQFSbJ3k+Uwoea5/b2NId9A
 yFCTSkWu/AAcOudvLb8jue9lDFAAct5Gsl33wgaguzJTdTEYPZazabpW/RkXY4QvSy2XHpQCdAe
 cB9iIGzaOt9tqfkiLqnP9nSdwl6x2P8p2VXKXWr1ZptwKsCUgmjuGOM2ornWG4GoXKN5fXPGTlk
 G2m5lh/3IzNDZbI460YBLFeszatTwWyHHchAUJj3oMXrakiM82tWWvRUQZpTEcH48RHURpbYqeD
 U/piaY3ygte/lILbvqGfVSdOG3CrezPJ25SiLp6WRTntYs4EXmu6lZdsFAzwGhATYAQU6H8L0Jn
 fHjzYVUBLSXvN21uHAscKVj9eQuH71TqwWm5H2BhCW0EGqEyjJTJhn7UHGl97w==
X-Received: by 2002:a05:600c:548f:b0:49d:2936:8ad1 with SMTP id
 5b1f17b1804b1-49d29368cc2mr18635125e9.1.1789025349499; 
 Thu, 10 Sep 2026 00:29:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c04ba2sm51769205e9.12.2026.09.10.00.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:29:09 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 07:29:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
X-Gerrit-Change-Number: 1908
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1908?usp=email>
X-Gerrit-Commit: 3466b14adee823daf09c0ac0eb0dc75631dc695e
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 07:29:07 +0000
In-Reply-To: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1Mjg1MDAwLklkOGFjOWM0OGE4Zjc1MWIwZGY5NWM2NDM2YWQzZmJmZjNjNGFlNGE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c5661894e8ccfe6a05f31fc63a1c119a8ce0c6f1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4ZDg-0005tl-2z
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Avoid unbounded
 reliable TLS timeout
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2470819768753036001=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2470819768753036001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ONEGI4o8VIU="; charset=UTF-8

--ONEGI4o8VIU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

razvanc has poste=
d comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1908?usp=3Demail )

Change subject: Avoid unbounded reliable TLS time=
out
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1908?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Cha=
nge-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Gerrit-Change-Number: 190=
8
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Thu, 10 Se=
p 2026 07:29:07 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ONEGI4o8VIU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 3:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail">change 1908</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8ac9=
c48a8f751b0df95c6436ad3fbff3c4ae4a6 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1908 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fill=
inger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Thu, 10 Sep 2026 07:29:07 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ONEGI4o8VIU=--


--===============2470819768753036001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2470819768753036001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2470819768753036001==--

