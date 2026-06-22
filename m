Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF1CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1GkN4rZHT4PHIO9dJonI0iquR9TAIRG00OTJ4Oo3b0=; b=CssQoQuDQTZEQ3tY/qhKfmp5Ti
	NaF1gM0od0YsxZY2qs5IJ8lF/aurQon1L665Grv2WhcN7NB5y/NleTFdZKmFzGVsO/1MuCKyqNDI8
	gYZHjD+1jq4JvkSTk7DbbtjXWulPoE5GPPa/M5mLQkMJsydIH/+ejQhS2oDSkT/AsFpI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgwR-0003oy-15;
	Mon, 22 Jun 2026 15:52:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgwQ-0003or-1T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gHCwLzUj6VJC4g7B+tD0lGWpELm9ATcsCXfzXiuX7Fc=; b=YZAiDkQYpq/OWKs7ieNMDbe5MH
 MaTGOmW4ws48tNxqnlDpY6K86z06x1hbldKOxEJhxvZvDzF37gg5IaUPpREtgNrsSDcOpQ7b6CsJc
 2M+PVv1iEm8c7wz+16oqaj6v+EjnpuAdmaBsC409qEjQ8I6RKsIHplKbLMWrP2zEexaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gHCwLzUj6VJC4g7B+tD0lGWpELm9ATcsCXfzXiuX7Fc=; b=j
 0IgKIdi0uEuZDJzEg2Ohoj/Z/Gp9NKtcywGzcthu/IqTEZ8BcboFx67X5PbCd1u2pf5VcY0oQeRvP
 SGJGKTQoKSYwkjukC7Eiw7bh4alsKrvviZhd0qw/7zyDvXGWEvUxWIEVmcl1DUlqmtdQLmG/OFPDc
 40CEjvu73PvDCxLg=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgwL-0000J7-BC for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:52:03 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-464192ab2e1so2866911f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782143515; x=1782748315; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gHCwLzUj6VJC4g7B+tD0lGWpELm9ATcsCXfzXiuX7Fc=;
 b=eg8M31xpC64mUkpSpJQDlPBwW6e/DnBHgm9Xrf1MNVrUHSCNkwDQdHN6k1V/0K0L68
 4JW67+ClAjP/ZbZZ6lgoXA6oOhCGjEc0xVGdeCvNJJVzygKvrd+E6S9xwpvOgjGMm2jW
 ARms37tPpJ3cjB+WI1LBRiCo7jO0MKFYLyBNBBuaJrbZ8AtqY9/auzdLvN6OpbyZuzbQ
 EUc/EXyIfxKaCIFOYInYYioEVnnXhFitIy5NVZ9aKOBULdl3+BQ+UD5K9AWvbkmIZlwU
 RReN0HlWg+trquLWsTXqiQifCysDykHM1kLvUBylw7N1bWGP0F/OY13IRFww351J9t2v
 D+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782143515; x=1782748315;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHCwLzUj6VJC4g7B+tD0lGWpELm9ATcsCXfzXiuX7Fc=;
 b=hKeUXOM0sc3jRUP59IDZ4pGIULi/ln8Nj+m4mXzuyJWoH3K6PWFPEGufvQ5idBNSW4
 hWpwWwiG8NJenEpZASQjbbzKRzibIswELO46BKpiM+hj9eGtIadH+Cth6zBVhbeoaOc7
 xVX5r/TKIqAJb2yd/6gxChMUhqBWZVvFtmCWxcK+jOt3ha7OXaIcsKpVJmJpJrovR3q3
 yAwMXbY0CdXtewDKkQlIb83m2sccxJ7HNK3fgN6G6FEHHCUcZlWxp64SueCMspBO55Cr
 lae2h2L0AGWng2StSl7BuFw60UU0F20YZIz3wqJ6+qS2bWlllo7slYHz+4FExU0UPnJ1
 9xOg==
X-Gm-Message-State: AOJu0YzamXIuxiUCzNa44Ymb0h1SaEhfQDBTet/a6kDk0RwWYjqTgJkk
 f+eDZ+COUzv5JueTkpge8gWGxFUV5NTV9B+3ctjCMr/d8O/qaI6oqAHrVKrS6IRA1paap1XehHm
 xRN8qq2XKvscU9pq8ExDPbDMhOKOkctAB5HcuqzNa1FCKxjXFJASyEG8NhCrgKL/goW2z
X-Gm-Gg: AfdE7cnIUIFaacnQvF3/sGIpQLpL/OTZR70fejJrqzOOJws/ElcLJGuke8IB+cV9XEI
 wmGfsJnbdWfcX0l8FHPNEHqSkaYLfmD7qkHGuf0a117oF7grm7ESgl1FBCvzobCG8Oc9YmosOi3
 JbEpPl8NoRpAplidE/NdEkvMc3XM58mJfB7LKUyzzFRiB2XuIzcD/Nfj5nNlc0nqOcMuRu+wi52
 IK0YJms44ZrnaxIzR6qby4pz3Xq9SXaJ/TkIEcCRRdFFuVPsE3xvfnKHByf6hHe5rVVEia4A7Sc
 OxCiW81OKt6e/IwoRKUQzZ2RZCuIt6zR/5Yc1Ep+bjFPD6eh2tJfBcYcyNW/0CXrpuX8XT/3R5U
 QCcyx6HC3h1/mVVWY+fR9iZ1cNvnbryyQV3cTpAfTs/A61JgpOqRBs7ga8iuKjwtYOiS6FgWfYZ
 60NubSOsDV3tpQBsCjm0VolaBGdzYKdSRAUcn5AOkeIjoN43ljPndwLsAzvnJQnkGyam3G8SJcb
 IlxjiJ8W5G9JbJZCtWe1HE5HtCPUeEPImpCRVvbLgz6vmmzUYNEFblELFemxLl3pkn6dTGLrK3k
 GBU=
X-Received: by 2002:a5d:6885:0:b0:452:c9f:4b91 with SMTP id
 ffacd0b85a97d-464fff65dc2mr17546634f8f.4.1782143513610; 
 Mon, 22 Jun 2026 08:51:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e93sm29635722f8f.7.2026.06.22.08.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:51:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:51:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 465e1097541975a86ae6ba928f9ebf4be0755c6a
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:51:52 +0000
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb4f9dd4004d2aa21746a21e31d8c0f169c34b62-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgwL-0000J7-BC
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move incoming data
 processing in its own method
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
Content-Type: multipart/mixed; boundary="===============5307887607168603014=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5307887607168603014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PO6XG+LAAYQ="; charset=UTF-8

--PO6XG+LAAYQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1722?usp=3Demail )

Change subject: Move incoming data processing=
 in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/4c8bb6d4_97d5=
324f?usp=3Demail :
PS2, Line 3339: multi_process_incoming_link_data(struct =
multi_context *m, bool floated, struct link_socket *sock)
should have docum=
entation


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/6cad13b1_=
fc9c2405?usp=3Demail :
PS2, Line 3346:     lsi =3D &sock->info;
any reason =
not to combine that with the declaration above?



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
Gerr=
it-Change-Number: 1722
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon,=
 22 Jun 2026 15:51:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--PO6XG+LAAYQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722=
/comment/4c8bb6d4_97d5324f?usp=3Demail">Patch Set #2, Line 3339:</a> <code =
style=3D"font-family:monospace,monospace">multi_process_incoming_link_data(=
struct multi_context *m, bool floated, struct link_socket *sock)</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>should have documentation</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1722/comment/6cad13b1_fc9c2405?usp=3Demail">Patch Set #2=
, Line 3346:</a> <code style=3D"font-family:monospace,monospace">    lsi =
=3D &amp;sock-&gt;info;</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">any reason not to combine that with the =
declaration above?</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">change 1722</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f10d9140734=
7faf32397535c95e2d80a1575bd5 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1722 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 22 Jun 2026 15:51:52 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: Yes </div>

</body></html>
--PO6XG+LAAYQ=--


--===============5307887607168603014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5307887607168603014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5307887607168603014==--

