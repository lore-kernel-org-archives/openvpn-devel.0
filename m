Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47618C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3k0igOLyFYea5qjPBmKqTU0wX7INGO0eqwwKYAorbs=; b=hIRyF6GhJ9x7NPsRASSjHfw5PH
	YpwDNjA2CDCQ7uQf8oAAoRysihI7PmwiMOwCw78uFfU2yejpx2KyxcBF3uuRDlVxsVvqQslhQts6B
	nas/DfEOfNn4w9SRxXipN820u8lnGnNEQlkJJudU/SK3Mp1opKww104+t9AEIyCasFSE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrdr3-0004u2-FR;
	Wed, 05 Aug 2026 15:48:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrdr1-0004tw-Uh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Sv/Qt/n/HnqmEk4XaUIrUKsCzJMg+fyphRv9Pon/7xM=; b=dZAdme6W0HbDBN6g6ygimnmTbX
 PoLiszOfUP0Ww1nOtFgBwynVPF2iykviEsqMFqVCncjRmlZZ7Nuo99uWhE5RGRWXF/K4UUazNoj/V
 tlldUABsZLqBolfI2jCHGJoXNyLUkQu2i/fdsu5rMsWYomctrFCooADArkPhpgYTq2KE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sv/Qt/n/HnqmEk4XaUIrUKsCzJMg+fyphRv9Pon/7xM=; b=f
 coQL8bYpimOSW2hJVs/mW86434A0A4zjVQF59hOtBc/5SYajxu5LDL36bOmfxkLfB3bfjKBELWhLQ
 hXeu6nryat4gN/Nzm/EPPGdY/neSROIaXS5OpNn4nCRhdRkBVwIzKpQ12SFy5PqWqTDT/yPB84hD8
 hkscLw1W8UUFwCSA=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrdr4-0003Th-6e for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:48:27 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so860057f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785944900; x=1786549700; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sv/Qt/n/HnqmEk4XaUIrUKsCzJMg+fyphRv9Pon/7xM=;
 b=Fzqn7kp2BmwFh5pF3+btvywSkjobrUzPBzKni7kIDyEdwvTM9/4pH+cmluF6chCdWv
 mWDV4Q8HB+cRkgZY+vylJPQdigLi77bXZgHZUtP4O8aKq/SWG4hH16Wv0pGcY9qI07+e
 7/ocFnPmGsUZyYbk4coK9RPbu2mSnufsdCY8pDPMDGKxgJm/WxA9kC4bY1gLZEm12N74
 pyUJZXxAIg/tSM31vdR6quPF/uLS2TblOIQKu6MyF1RgF66scvI7FWFBGHgYhiVEUj4B
 2krSN0Ed8vRWpgzrIcHAI26FySbS0XXgTMIIlWeD4siFaa9UF7R4DOYoT2+/UGBwldfs
 jcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944900; x=1786549700;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sv/Qt/n/HnqmEk4XaUIrUKsCzJMg+fyphRv9Pon/7xM=;
 b=LdDfOVvntu3mM6MW5cKlWpYqKkoYOPLyYjEoELo8xpdcBZkGsE9vwHOeFrj4R2Pim6
 G8sJdKWfwABnlr1InfBJCK4ny8W2deoBGyTZbnKwRu0YaNU/q/hkAsHVUTSYewVGWGMS
 aEYk3SddCC5CQSjBC79N2f1R+Rm24UeyqeqwuInaGe58p5hL8igrse1Ic5WqJqIqknOV
 FuyImCUCencv24R+fVzWP22sKkJDsQpXPzF3kGt6wUD5rzkQuUrTE5zFRARPDpLLjGg+
 cVzKRmuaw3HRXzpFOKNZ11HP35WrWYaKjOEKDj8jBgyX72S2jrqas3ZF8XGKUqpHBOzm
 mk4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqG/SYcHZRXoa3zK8oDI7iI9bESkx2SPIdbUeoAqcI89kWkCE6LdU62nREbeNyzxvz5JO7dt21pf+qFU877@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzn+qEquerZMRwW1it2J6tGht9q+E4lOdQGRVvUhIPYHa7ZJzXv
 5lRe7kIQ3fUimOXMqDhknPouGP6voaVtYLheGV9ND/yzgedy7Kc7wZywBDjXPksNtqdum4K3xEF
 VvglFIL0OFQUcMS8ju89oICBSPm5u4k2zB0FkGtfGJdxd2+lRp+1hoWtGkp0zMvGd07Z5
X-Gm-Gg: AR+sD11u5KdIlNIhwdFHvr32wCbWCDXguTc8C1xgfB/pf+ply0CcgwR0zmvgKiBNZCn
 jHx2Vz06X2QHpBtVxSOE/UnOlhhekdbYBORncO/1a9Rf9vyDoZnDDWjGU6wqxyUWgDLq8uDZF+I
 hF6StzhrGvWvOG6aWWFvvJUPquCfgw8oZgVBHWzt1ZoO7SuwpVA4Pvv7G6tHgPnifmdYrv6lOLK
 tcvJx2LE+1m76S+5/luyU0prrhJkAZRL85wB5PzljGT+jFEcG8qmIdOzobQnQWZIndXroiMqlU5
 aac/aAKacZSAK5h2c62DGQSNufmRvtsFpboKkUfIu8pxeapmAIgejDsz7Wpu3kBJaxcKMpNWfBj
 vvw7/8+bPXXQitTDTRDf0ASFO3OjUGOTRC1BRcYgoax2YBMsDrzkz5Lqbsp5VJiFD0sLLCFNwj9
 tZ/S3XtH2DAanOP+jXGn2StUsy1Kq1okeCOPp1WIqkE2GTzLGQrgOptY8xr+5iz+msSrbhjYi45
 ehTS6gRbx51DURxFdQCc7zt+NiZQSmc18yM0f6ShJBDRI5rFHu7TA6bit6WA54KOxD7HzdZHE5V
 Yc24qYJ4WvAjfU/iihZoFyOFklJHxNf5TXjfN+5a91iNEO5ZlxA=
X-Received: by 2002:a05:6000:2406:b0:47f:6efd:8421 with SMTP id
 ffacd0b85a97d-47fec4fa4e2mr14118388f8f.13.1785944899844; 
 Wed, 05 Aug 2026 08:48:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfda11csm9441022f8f.1.2026.08.05.08.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:48:19 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 15:48:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 15:48:17 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8a2cf7cb8cd9c3ee08c2ef84f26de7056742348-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrdr4-0003Th-6e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1049309170446518538=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1049309170446518538==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a0fwzNEzdHk="; charset=UTF-8

--a0fwzNEzdHk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


ordex has posted comments on this change by ordex=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exi=
t the process when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(3 comments)

File src/op=
envpn/ssl=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/9325=
bea6_55bf70b8?usp=3Demail :
PS2, Line 235: #define TLSMP_RESTART   4
> Sinc=
e you explicitly link that to DCO restart in forward=2E [=E2=80=A6]
I just =
wanted to keep DCO out of this lower level bits where this constant is used=
=2E Ideally there might be future users for this constant, requiring the sa=
me treatment=2E


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1835/comment/d424b9dc_f0774760?usp=3Demail :
PS2, Line 1402:   =
              "notifying userspace=2E Restarting the session",
> Nipick: Mi=
ssing punctuation at the end=2E
Acknowledged


File src/openvpn/ssl_common=
=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/488131ef_aa5a=
6fcb?usp=3Demail :
PS2, Line 202: };
> Since that is only returned by the s=
tatic method init_key_contexts inside ssl=2E [=E2=80=A6]
Oh!
Actually it is=
 returned also by `tls_session_generate_data_channel_keys()`, that is not d=
eclared static=2E But after a deeper look I can see this function is called=
 only in ssl=2Ec=2E=2E=2E=2E
So it could be made static as well and the enu=
m could indeed live in ssl=2Ec only=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-Chang=
e-Number: 1835
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 15:48:17 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>

--a0fwzNEzdHk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change=
</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1835/comment/9325bea6_55bf70b8?usp=3Demail">Patch Set #2=
, Line 235:</a> <code style=3D"font-family:monospace,monospace">#define TLS=
MP_RESTART   4</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Since you explicitly link that to DCO =
restart in forward=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I just wanted to keep DC=
O out of this lower level bits where this constant is used=2E Ideally there=
 might be future users for this constant, requiring the same treatment=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/s=
sl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/d424b9dc_f0774760?usp=3De=
mail">Patch Set #2, Line 1402:</a> <code style=3D"font-family:monospace,mon=
ospace">                &quot;notifying userspace=2E Restarting the session=
&quot;,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Nipick: Missing punctuation at the end=2E</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/183=
5/comment/488131ef_aa5a6fcb?usp=3Demail">Patch Set #2, Line 202:</a> <code =
style=3D"font-family:monospace,monospace">};</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Since th=
at is only returned by the static method init_key_contexts inside ssl=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Oh!<br>Actually it is returned also by `tls_ses=
sion_generate_data_channel_keys()`, that is not declared static=2E But afte=
r a deeper look I can see this function is called only in ssl=2Ec=2E=2E=2E=
=2E<br>So it could be made static as well and the enum could indeed live in=
 ssl=2Ec only=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1835</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I564edc6e0cc179=
c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05=
 Aug 2026 15:48:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--a0fwzNEzdHk=--


--===============1049309170446518538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1049309170446518538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1049309170446518538==--

