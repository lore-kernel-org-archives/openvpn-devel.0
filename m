Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6C5CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4J+PhUI834jpH2fV21lyrtAWhKRHr1nhLZY9MMVvbQ=; b=JcJwrfavgPkNqfhnSF1T/BzChT
	YyL7AvMwA5ZAFMEJ5rrbs8HuzQl1AxhfEbGARWxabYy/j9rcgQH0GI18NhEV8/D8yO0VzJgtsUdy0
	1vgSJ5swzKBI3fbbMwmMplpuwiqlYaW8XSZNY5tMacfrXXC03veP6UP6n12GDN0Z47+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQVy-0006ar-M7;
	Sun, 18 Oct 2026 13:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQVx-0006ah-N9
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+bxLd7PgoHIHZWnxlqPwv+HQbbg9N7tTsRmfJAaZ09E=; b=Zfv8pkWU9x9i6VboV9TRq72ePH
 58TicIBj1F54H52QBlz42lljzBHgnsjLo+7ZlMdl3PHDIdltbGjN/9KLcAOfmG+PbbUa1haW2Wcss
 bym5VJFGlhlPl8QSU/qjwBmdbWAlgnKSPb/oQ4F7gUyShisumozb0tomK1REMX9UtmM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+bxLd7PgoHIHZWnxlqPwv+HQbbg9N7tTsRmfJAaZ09E=; b=S
 xyPrVWzzxy9jZW1wRYqVYakQ8PIRy53b0nHdQ9Y6oZNSvY6cTHBF0xBySKoGs+WX0Aw34WZniOIGU
 udmlidtHsrrf8PqFXGQXIcQALgOevqIatlH8AvWhxAyNZAc+0JILM7ATp+qospil2uSPVsrYjkgSm
 9ix5sxoAEzeP/iDc=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQVt-0006Vm-F4 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:01:25 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so8436515e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328475; x=1792933275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+bxLd7PgoHIHZWnxlqPwv+HQbbg9N7tTsRmfJAaZ09E=;
 b=Ko0X0fU3YwFEPaJ8mKko2U0yKommrFwX7wecgk5KxgFQMO52tFCmrEg9AIfkUU2T9R
 Hot4oGXjsJ+1XWlWq1GMI58qQewsToymkW9/Bn3AB50OUfCd/K/Hxt6O0OlkKEW+Kvik
 yyagCvHAejwvO1PLkXrAQC1ZE9uo1/AQdpXpVqr0xpTP6zUHMUy98tkgbBVuttvOdOcH
 V9J8SZYO+l6NeTudSAhmJnVHYxq925S0cuk27peeD9ayuQRZaB3eh3vuVmEn0x2hq6ej
 8Rj8cZiWaEHOe0bDgosqvVIMiPfhlAcEFVIz7GnHx4tG/gEloAvYVcU9G3hTbIO5uyu5
 BuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328475; x=1792933275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+bxLd7PgoHIHZWnxlqPwv+HQbbg9N7tTsRmfJAaZ09E=;
 b=EERAQxulcblCoMlhGyTiYTFh6yQL0sThe4C4c5e1xvowZS/Jsg3DwMzBJTYv49qnPK
 3VxktKo2Ixg4nWsTBdFYjRQ0BbHkZm7B+7i68IfHdrR7fcyniiVY3DQ0np28sbJNjz/X
 tx+bVxOKcpHhga585J0OevL3T/Xiptavj3CnJ+BMkah3DMyzq5LtsB/9XzKJod89dJaN
 nlfw3sDthVyEDIcJcWLlOmHm0bibNhzfW4PXNkfHfMurrPyg5AEtPRlCb560G+55nEdB
 vh03BLmuJM5gZhelScAd4GHucJTFK3c3lFHppXDj3MfXZIvup8sHu4WA2VKDFozE/yq4
 ipOA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEt84SoE7tO5/fBslwEexoHlSsnnRF4K19TbbqVHo9oWXhmcR8YsIfYqdDUj1X8sPC60tU3LfuLHfsjWyd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJrSb2J8cWXjTS9q2kQ1q+zwfgwcwPTvuEbb/DqSSw9PLtojvRc
 0Sf/d/LPjUTQCQXzq+LD9ZkCpwfeGMvf4d+VYmg7CqUiCm9VXByJgwKac+P6AVVXqk0v74/BHZ9
 BQux2KsTevM7RbGpi3xjFfGmfUwbVbACnBH+g+EHwCTstOz6jjpTCgAkMB7Nvbk75auYl
X-Gm-Gg: AYBFou0Woxwzt5jUScG2RXpLWXQx/Uer2FsBhwChshUf5JCeeEnDIBiGeezYOahSrB9
 ZZ5OJLZT1xxf1lRjSWsDmLqkGMPC9W0ChiCPvDoUply+fMn5d0dHk84FwDyX3mNeELf3DktFu4y
 9M+vhKC506n6JT+YlGihSbMW14NrYyxMb9L4W/divmuT3k5cVxmt7cyGBzizOj+SrF1q4mrxG5B
 E3H3IpqbtHOdBUN/9nYj6X4vVSRdAcVNMVOZsvX+KA3R87ju8CB4o8At3LMMl/vtGXwS7Wkfk30
 CBgJ4CMgkopFQnkRCcjypXPevoNY2yjKo/yalQMlaZOg/kJvqrENS7EMIS8lZljmChzXUNVRTYE
 /rd8F4jymt/ONKD2UDt8h6INS/TEZa+tV/yK1rMBuI73D8aVzBZB8qJtS3uVEJGwbAZFfk9B012
 LrwfyLwDmHNhUNsBWPkLVFihJJhgf3SbEL2v+CYDcBe0jgd68hfUNd9sndi0dQZZel7J/WWrmDH
 S7XGhkbNw0HJEgdKgSaZ/jyYmrwVpUGSh+8dwug3KcGBowpWskqAN/bT61FFL7aYXR+G2ENv73v
 anKrlVOoRbP/f7j8M64TB/zghfHWdAJ6LTxTjbAgthy2TLTohY0ec5hM01/0
X-Received: by 2002:a05:600c:1da1:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4a1d7614eefmr103248775e9.26.1792328474715; 
 Sun, 18 Oct 2026 06:01:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cbedb6f7sm218434905e9.2.2026.10.18.06.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:01:14 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:01:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 13:01:12 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ebe0faa02a6c723cc2c16326dd33b87064d0ba7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQVt-0006Vm-F4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8011897755214045127=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8011897755214045127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+iw2scq930="; charset=UTF-8

--2+iw2scq930=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

Stef=
fan Karger has posted comments on this change by Steffan Karger=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subject: ge=
n-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
>=
 I don't think we need to support LibreSSL for generating the sample certs=
=2E [=E2=80=A6]
It turns out LibreSSL doesn't support random serials at all=
=2E This pretending to be openssl-compatible, but not actually keeping up i=
s somewhat annoying=2E I think we should just ignore libressl here=2E



--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf=
47174e2aceb9d17d668
Gerrit-Change-Number: 2010
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 O=
ct 2026 13:01:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Repl=
y-To: Steffan Karger <steffan@karger=2Eme>

--2+iw2scq930=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>Steffan Karge=
r has posted comments on this change by Steffan Karger=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I don&#3=
9;t think we need to support LibreSSL for generating the sample certs=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">It turns out LibreSSL doesn&#39;t support rando=
m serials at all=2E This pretending to be openssl-compatible, but not actua=
lly keeping up is somewhat annoying=2E I think we should just ignore libres=
sl here=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b229=
5ffdf47174e2aceb9d17d668 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2010 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karge=
r=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 13=
:01:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--2+iw2scq930=--


--===============8011897755214045127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8011897755214045127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8011897755214045127==--

