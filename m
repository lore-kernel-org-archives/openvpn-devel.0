Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A36606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dBt7UDZk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KX2B+CpW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BG4Bmlsx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OHlfudxf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1hhBtfhaol4oBEm1KjLXuSCNhaHeUYJxtz009Po6NBw=; b=dBt7UDZkSitcpakdd18uory7du
	0wUmw8YrsGeRXtr8g7aSkwl+3yqSs1d885WR2r40JmSF8rMuv9OUaKGBGpkWmMJgPENXwRJ3icKAq
	dN90KvTdFK7PvM4pRq/5zci7aW95xh7v0DlfTHIN0KKAOIb0/L37Hr9HoWiG+pU6Er2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUwlD-000000006Qm-3iV9;
	Sun, 22 Nov 2026 01:52:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUwlC-000000006Qg-2hK1
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c4+88nCl7slMXQ331j5rnPBjo9zV0d1yDd9WK4DH3VE=; b=KX2B+CpWjsxES9Qn8uLhKJc2/Q
 L9zqZFyxqOO6mlqT9iWzSfRab9fp+I4UEJFkxFvR3qw00wt50q0OIqBolARxfKFpGscpmc/bQVB+d
 q4Gmbi4e9JIwiLGpTDMQfkEv+8lc1PF80vsUoqX+AUtLSu1gf/fm+5S6C2pq5bYe+jbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c4+88nCl7slMXQ331j5rnPBjo9zV0d1yDd9WK4DH3VE=; b=BG4BmlsxkMvjxrduw7GWd3OQYU
 KhkvW1FhLjrAmlaDRvMDJuGAl6YjGXKJZbON5266NY9y6hlD4RjDs51rIk1ZIbwKDpp29T4VyNDsZ
 M+MWqHS3lGe0rJvLtDHn/oTJjY7i+qM01tEyFP+67zvSgeWLUuXEzbILn0grpUCqOWQU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUwlB-000000002u5-412W for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:52:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so18100185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795312367; x=1795917167; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c4+88nCl7slMXQ331j5rnPBjo9zV0d1yDd9WK4DH3VE=;
 b=OHlfudxfArWjtGAYmGnNyC+1X/7mnPSkXc9e4Ydf5FPCHknZ7IXdKAZDkIiQL10Nja
 hRYgR7uq8q+M35F4u8kzecDAF5RdtiM3iHKbjm5Lyrvvc5BHxRpw4oWyp0aHlA9WQ8Qz
 5vG3nRhcHXYB/UR7/Kgj1u3NRvjUQtctApQ+uABnVlXhWuKH3S+YzaFuBfo5HPvYxw+Q
 6KFDdWK7NAJfwQFBgseQHlIc/MiPcTSYO+fwMWnZWGfYyKxKnE+VODPB6v1p+F9E6GIy
 PGVjVhna0ma0MndpjA1Q85XPMM+eTcXkYrQ5dt+OFQaSrSFLctuTzzDPgS1U8cTsKlxC
 dNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795312367; x=1795917167;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c4+88nCl7slMXQ331j5rnPBjo9zV0d1yDd9WK4DH3VE=;
 b=25PqRjydb6vC9GlmAd5bB61a5hsOeyJKJlEhuzRVwD/WAvMO9ekw7xjEbSwO+wr1rL
 dZnVtwv2fhamq4FciYRMMobj3OzvVr4AGdxb7768pJSNFiw/QFOggSXyYkxkKQPEGkzf
 mPJ4NhrnPl+VTJ5NVVFb/2en48XSoW1ZMNHCwN98DyyJ9hfH3pBoCWVj2w3+Cc9kHL9S
 eoAz9kU2UIXydyINLGeR9JOcek0sets7peU2mwk76MYbm0+WnSqdx4Lv4bPmpo+Hl7wD
 OwDUT7pxo80FUCeNcASpkN3x0JyqVUbAqW9IHuhRko/TWmhRX5HvjE6qwEWhRO4SAi1m
 aGpg==
X-Forwarded-Encrypted: i=1;
 AL+hErFJOJ5FOU5IzM4jvtTEjD5yZGO4tuqRsjtgYCrvq0JmR4kTpJklFkkbKfPg/Aj5pk8KRTB7rjr9476wk+DZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/EjimX5qghu1Gh/hNf0omR2zL/24e7L4yD9MXHE6n4epdALAkA
 ITB52m/PQCGCY0LvpOroKpoJgibyYfM9Z5pC1FV02QzxT0WepG7b+pvSsNCy0gUw/lhmG3Ga5ZG
 0YNjnCkU9oX2unoQoEpo7dc1iGB4Xqs5KBkP2f17647xcW3IiMbpZMO05dhVAjFnp5kPXlk+U3N
 HvxzYngw==
X-Gm-Gg: AZFdTZf1eOdViZr1krPCtPhuUwioV2YSO8LJPcp5NVP6Yak48yCSq7/nEZmnj3J9GIc
 uJKFiZWLNz9t1nk7ivLkC7HiebX41fN1MgbObaj3jGC81C4tOtgZrdxWdZ4lBo+7pxB7mBoMzll
 mNNjijKYhmBqvNc2j4mhy25A9ZXN+cT70c1rLLYzNmlS+HgtcyzMCygZdemA83h0ObRwRg+nLIv
 4LiNlQyO9yJ3eGYhpyEnsSCvUSW+bYSrQPSaDwY07YLIbaTebO01X/IBhBXydi5Tu+AY0s3VG3G
 Se0QMXcKiZLCaRglebOkcaehcEavqL1XvdQF4kIHquemky/f5wbyKKsp1cKlQDXH8M+PNl73wvq
 fD3deoWDefnP11pIx4agBi4VHByzlMho1g+4+tET/htIcW6v7RVuK4blB59kPysx+SUfeWi9bw4
 YY8jczr1B8OrT6EZPNGbF6TMBN73WdYES5XzXDEgF2DIuPkpcPQQHm0JpCfysczXmpwA1xVBIwc
 W1aFrxEsN9OYExX+oDSDMDGuXPzULGuQln3tvNt9AEqANCTMqF2TQcjvvaKhLdD++vyGAvDt+Vo
 /WGkr3OWZyqNIpUn/sID5NGxqC+8ver9aCTdWg+lA7nbCdiQg9Azbl+ZiC0E4/kCFWFWm6GQJa6
 BtgIj5YfMurInBPFlwzysA79FYbk6pbzdMXkT34WxmfXzIPdk0XnwZDa9V/uqmgzNvtNDnmlxeJ
 Ly+iTiDXN+aZGArWQ=
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id
 5b1f17b1804b1-4bb887e265fmr156102305e9.3.1795312367266; 
 Sat, 21 Nov 2026 17:52:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f0f1csm75562805e9.0.2026.11.21.17.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 17:52:46 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 01:52:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
X-Gerrit-Change-Number: 2234
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2234?usp=email>
X-Gerrit-Commit: a95dff7ba064193f081a2b93028421a3f890a3e0
X-Gerrit-Comment-Date: Sun, 22 Nov 2026 01:52:45 +0000
In-Reply-To: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLkkxZDM2OTk2MjE4YzNjNjFmMWYxNmUyYzk3ZjkyMmFmYTY2ZGY2YjY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcffea23b4dcf4e7ca9b27ff8978055d0a9a8f43-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUwlB-000000002u5-412W
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 room for the DHCPv6 name server separator
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8651173382327784265=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8651173382327784265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Op/XiqNtu7A="; charset=UTF-8

--Op/XiqNtu7A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail )

Change subject: open=
vpnserv: check room for the DHCPv6 name server separator
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Com=
mit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234/comment/97124=
784_04d2a399?usp=3Demail :
PS1, Line 16: separator is added=2E
> The commit=
 message doesn't seem to describe the change?
Forgot to update the message =
during rebasing on top of your changes=2E



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
Gerrit=
-Change-Number: 2234
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 22 Nov 2026 01:52=
:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--Op/XiqNtu7A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2234/comment/97124784_04d2a399?usp=3Demail">Patch Set #1, Line 16:</a> =
<code style=3D"font-family:monospace,monospace">separator is added=2E</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">The commit message doesn&#39;t seem to describe the change=
?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Forgot to update the message during rebasing on top of y=
our changes=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">change 2234</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d36996218c3c=
61f1f16e2c97f922afa66df6b66 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2234 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eei=
gentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun=
, 22 Nov 2026 01:52:45 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Op/XiqNtu7A=--


--===============8651173382327784265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8651173382327784265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8651173382327784265==--

