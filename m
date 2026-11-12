Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F1606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gY7JhWIA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M3wpg1VT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IvEtXfUU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MUfdWC9p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6HZ1F1N37YZdT+C/xNNyQErRUGwggRTiwKgAjkuse2A=; b=gY7JhWIApJjV2pgNWSkOIlQajA
	X0TUUAfONmlZ9VH3exvlbX0ONXQ6gPJ+4zUTn+ATC8Sn+xTHBBTqKKleNrAfWcA1ki+vpL7JdisW8
	XYKzyD8zSAqKCFO9ZO7HRXci1UerSmWkI6OIenlkLLy+HWHQDmpmWJrouYEIocZ1yOig=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRaz8-000000005Dq-0B37;
	Thu, 12 Nov 2026 20:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRaz6-000000005Dj-08nV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jcXHe6PH6qTehvFtKzDFu6LurQRSmOXFGg9omgTLLcM=; b=M3wpg1VTuHelY9WlqmRJgn0CB8
 UGo/MrAWwYRV4+Xn7paQErNRUwC3PZVcSwUMaulB4+OSzH7gMJNeSdT8rt7DEhFm5YQTau1xds0P0
 nOtGXTv2tGhUBteZShC5dVQoimd2ioxUo5jXYQPANjAo6+So9VSvh/Q6Zk670aY6Ek8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jcXHe6PH6qTehvFtKzDFu6LurQRSmOXFGg9omgTLLcM=; b=IvEtXfUUGrnpitrqKARdRdNapY
 ynRnyRsZTewDWri6rdUbqA9VWU9dy7fixgz93P/YkZzFJ4GaEMEc2f3tnPVLPrkupxgcms8kdq7ng
 a3N3Lei42uiyxJ9Hc0fAlJRb1P1Pt7ol9XJjFXoAMbMuhvf6TDVbsWB+9MAnGdh7GRSw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRaz4-000000007Qq-1aXp for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:01:23 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so80592f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794513676; x=1795118476; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jcXHe6PH6qTehvFtKzDFu6LurQRSmOXFGg9omgTLLcM=;
 b=MUfdWC9pB/EoEd/3PD5Hq0RbdfDNzsMasXghB8dmoojrXvANX8x8Hy4/DNFznl9t95
 W9I5HIvqZSTZjR15UT3NDXehGN5bmtpxzmwDXphS2bGieUs8JjtL2Tlm71ma3VD+A0ZN
 LZKTlPh5nG6uvTKRl59hJSN91efgGAIq8vygslz8V37ECV6GF5ROOQ9ahtglquL5vVhD
 taPIMBLFkyPpXKAClTmAby5h2emYwF5XCN11jNEVJbgarNG/DRP37JogPR5zf0znIpcB
 ozO+ZEpnvcvA1NGzrsjLsn9GekjsN1U+azQt2S1QeWLRZw4VeduzcKLojOZxuxOWg0JT
 kLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794513676; x=1795118476;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jcXHe6PH6qTehvFtKzDFu6LurQRSmOXFGg9omgTLLcM=;
 b=cdsv/C2aiwm7FmFxuhUaHpB0sPJs3lkcgazI4r9AkR2TfFyfkt+r5nn/F7wtqePdvi
 4adoLD8xN36ZMTNdYFKAeffNB6XJgp42PBoEAUpN0BLigwJyDNiFsIdsvLIV6HWf0Cmo
 Zm4qZVCD8tKiukrL7reuSLhjE1daeFnEocB89R/lyMCy/KcQz3Hir8uvErd69IWhwZey
 OsUHYF6a+vH+817Ox8NWlDrnIY0K92hVjoRmjRyn1XrExgGSnoPF71E+8F1jP+uhBq/v
 NY9nbSsmG4bDJu7voYZQIlWKwa/ELc/8KsKL+WaZ740r7az/DuSNEPNNeBPYIC4dnUxD
 MnOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGrCPdUzDsRiCdACFQ4AAG3+l8QqyyQx3RQSkeF/pmjobVwD7N8f1uDntfGQwrqE8eBqVtkrEDz4+MnS+jW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UhlJf+rqHK5Pii5UsXgIHXaqw4HCiJLqsqSq/pmCzbrBMCQV+
 Uh83cEg34gsT/Ytmt/C+FTIfq3du0FlTxkZW26rJUb/Ic24cpW7GwWvbgHy3gkMDT3/Pu7vEnDx
 bAHmI52clBgaNTe2tZ/O71kdxjxpHvhH7b5xVShXHjdq6V4Ebiw7i4GR6WcarKVd5hEtkkiqCdQ
 R/lKrcHg==
X-Gm-Gg: AYBFou04VkQJY11iU6q68vV+aXYLMRinFop16NbuP1MMxyk+H4AeH2CUH/JhDVYtm12
 CLU0pLLZGs0JDstG96iczeRskelR38p+Jkgy9F5Kx9bnnbHADj/CnDwAbYXpaZ+n34UxvSL5Nus
 WXuyPCt/ZvH/gjewDh21GAK3hD9FNCIyIBxMOjL/079DOJ4UcgauKoZyKQRkuOf8NxvcWZL8MGu
 3/UMhvYHSDcyVz3hgWlfIDFOlJ6O0qufsLyIUbrbqHAQF9zp2ToJaByj075FAVFS70lFifK3ugn
 +7mU0at3yL/f1y6KP9uL/w233mS4mJ6AXPRI/o29ncvPCg5Igir6fQheHgFGsO8EZDu2ZW+3pd5
 6IckPoF3qndsh4X3snqyzfUEe5MEHUoyW6ROZ4oqYlX5e5Pt2Cgw8eZxgLrfUO7tkGyEPK64K2y
 OrnSBuHo+Oqs5QlIXIUup5ZnBzexrIXzm+f4i++s5dg2XgWK1dpDJwjjnfQkv7iop6rW6fetZI4
 enh371vtwV5zXjKJZBqOKwMMax9sjy+KI4jnyBPCimU3bBQs22UOmZHn4lwiW2nVTbYOaFyGqh9
 FUt2YqOgbBVvdZalcEBo5c34n8aiJXNq9uV4i3KqBhqX8IgD4TaR0vK7t//+MvBLQecrXb47Ysp
 ikWFmrdjTSPooSLrlNcpUXj9LXaJdmPmPGwYwQaNfN8DAPcDYf4oCqz4+RYb+d/i6iHiChsEbsr
 2uEK+AvIrHEd/o1lQ=
X-Received: by 2002:a05:6000:2c01:b0:499:1c0d:4568 with SMTP id
 ffacd0b85a97d-49c741b14a0mr983424f8f.48.1794513675522; 
 Thu, 12 Nov 2026 12:01:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm961822f8f.35.2026.11.12.12.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:01:15 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 20:01:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 94d1c3ad8e783a6f7831b2d676f80a276bfc45b3
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 20:01:13 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b28d51de9685744a6d7dd0c1c2bd0615f0c5d37-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRaz4-000000007Qq-1aXp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2589887909571617679=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2589887909571617679==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GutJL7Gtwns="; charset=UTF-8

--GutJL7Gtwns=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Frank Lichtenheld=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change su=
bject: networking_sitnl: Reduce boilerplate code for parameter checks
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f5ca=
53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-Patch=
Set: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Thu, 12 Nov 2026 20:01:13 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: Yes

--GutJL7Gtwns=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Frank Lichtenheld=2E</p><p>Pa=
tch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3D=
email">change 2177</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 20=
:01:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--GutJL7Gtwns=--


--===============2589887909571617679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2589887909571617679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2589887909571617679==--

