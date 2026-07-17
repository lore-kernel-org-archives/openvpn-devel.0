Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34628C4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bb2Hwv17/TziplpTZfSzNAvGYqwPeUQTOa0RkoEs1jI=; b=X1QB+Vs/axo0k2csZ2dqcNhk9W
	SqJPdrLRy3XUnMsZGW9E7eU1S/qFqYvIxgsuoL7NpfGv7WaH4nTUnG1xIpZR4hvIwZsSOgcDilS9W
	YZN4ai0vZWP+K3fyvvS3B6bLI1tYqdISAyKQRrL/jqLkuTmbEeqkospCtbpf2Vw8Ajz0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkkIi-0006KZ-A3;
	Fri, 17 Jul 2026 15:16:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkkIg-0006KS-W4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=14fpoNwMrhv0Q4XBiNRaUhT12JLihYJYIjIxJYTcZA4=; b=VuavgkIG+hnXOKpyRprST+vxVQ
 lBVYmS1MTI3YxhU9LBFk/f+OfoHfVAP6zbFbqEa2Z47EfRRaXp0SlhcqPD7GP7sx7DBVhoxtJthCQ
 w7gLo4HIxggCm2Kl+H+/7bpY/TyFG4sSBbbduMzwDv5iILppueaDhO5tD2+FgYvTEwMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=14fpoNwMrhv0Q4XBiNRaUhT12JLihYJYIjIxJYTcZA4=; b=C
 vSLehmrMZ/B84BpVysTSF32Ha1uBmxkH82YfF8FYV8+/UC5cUWgQrvpLEgHqJI+ude4sxbP5ofcc9
 ScrqqJFyKU6OEsNESAXtvHKFSKyQUiQJyGkIBLTmb/7w+ZTcn538yg4WsGcMEyLmflhyBhuz+XqrM
 64uMitdYefaK8w9s=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkkIg-0007CL-9F for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:16:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so4636760f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784301379; x=1784906179; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=14fpoNwMrhv0Q4XBiNRaUhT12JLihYJYIjIxJYTcZA4=;
 b=Y2RgXudEUTtMIgyVuWnrzP4LPVyJOrT1jqU4knw2fM52BtcCijHCXosjRHKso9JcOT
 T1fiyEF+2WozW9Txi6lvhRV8skXMzkdnFEB+fFfje616xSh3ImLanxF8hfoO4eY1gaGT
 pMvD8u8O6VXgNUFW0tG4beAOWdC1GUrgPohMYdFyswVOTX9JkkKW9xUtxudm/GwBXjmS
 0Kb5PkyR+aQU12RrMZAWUa+ko86F4N/ffB/rq9UNBcH8YgyDW1AxfXuPZZkljiFhLIM0
 PYvvLhWOeLSgWyh4Vd+P4tBUnk8tO0WEDwTYgPouGkmcoOLYSHLqr3pBYQHiRWiw1B4u
 ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784301379; x=1784906179;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=14fpoNwMrhv0Q4XBiNRaUhT12JLihYJYIjIxJYTcZA4=;
 b=fQ3jA11XstL3p4Ty7waozXkwckJcsPK1rZ9J+CZayO+unpZ6WHKzECHCkBvYER3Zwc
 bMz9NaGtyv/+CbURc8RHDx6hbpwZvPppV5+JsdRqQ32eUzIZUfh6L1kXnOx07LxooQvn
 +egkMXElh50Z+NmyqMh390XXrh5L37m0eNZYa6fC4LvRt9CKK1++0YxhzRWq/QLKsgKu
 xVAXqsL7aISZq3G2nIdHnQqpvVtuuhkWxrt7Wm15bNWBg3DtDxQ9sE4c5bMNDeltpMDF
 eUPCjDr7U1FrhLGELMQqfu0ZiC0t6Bo0bfYWMpcUqtlKnQrjsHhtv4SKtniYK/ue8DK2
 rUUA==
X-Gm-Message-State: AOJu0YwAKLUZcuoP7XX/4r41LXPSTSqpzKPjOPAIUSVduqvNIbTSx0rA
 lBaywB9YuVwAPm4XhXIE6pq8q8Cbo1MkVunZh/QPzm7/0Y7VHYz+qKxKLqN3imehDMkvcZ9Br9b
 X1FWgK0SRfftB3uH7IEYf63ZKRCLAWgFVQT+PavdXhv4hk9clDVe/NWVVLS1CXJ3WJuaf
X-Gm-Gg: AfdE7ckLihIvwZJ1zOGwuHq/NbNSBHPWgMEZIa8DdMENqmmYk5mflaeRpqunOXwj4s1
 Pe3iGK2Nn3AoA8Uqrh/Cqi5cA+r1Amxy3Hb6IzbciT2X5LSzVCTGI7lTl4/RlSXorFXXQxaXaqL
 PSEp1AlyH4++j823XyylDinOwiaP9aY9Veghs0C8Kb/7mr7Oal+KKvZAU62onkM+J50+vAxUk8C
 Hpc6Jjo27Qu6fbBF3jGU2UkbdMwTYcERY9vdRWO4PtQmsPtwHt03Ok5qq/HmHUwOmXXtSkYpvfo
 j31LIIPPM8i8wNsQ+g7kIzdVVUB8BfTwlfFc1sRMj+NaVdflGdW4d6Lcgefigurb5AEQcaFm98K
 2pxh0vh9iPwVCH2LmxzTZrn4HoOJS8wQm3npbc+hYkUGk98XkYi/ln/+Svk0SXcLMIMznquLdGQ
 pbzPKyYkUSOjf8eFhgVowbuUroOnbjncVQdlrQoJD6283+WjG28x/BABnYlFq5YqaUyTkD6fzbu
 lr4dC3saSzwfFCJmx+he8Tcl3UNdBDbnIufIj9tog3T7owiVovXAMdnvR+sCWeREzxc
X-Received: by 2002:a05:6000:40da:b0:46b:cab9:f697 with SMTP id
 ffacd0b85a97d-47f6230d154mr4681408f8f.24.1784301378499; 
 Fri, 17 Jul 2026 08:16:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eddd1csm4492134f8f.29.2026.07.17.08.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 08:16:18 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 15:16:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: d25ee55822a9d23aaa20648ed86b0d14607f3e0e
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 15:16:16 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8666ffec2f43e6c391ba2b82342e95fa2eb0aef1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkkIg-0007CL-9F
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
Content-Type: multipart/mixed; boundary="===============3464441219772216951=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3464441219772216951==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IjHcNa/IhLI="; charset=UTF-8

--IjHcNa/IhLI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 17:

(1 comment)

File src/openvpn/siphash=2Eh:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/78464d95_63bffb70?us=
p=3Demail :
PS17, Line 74:     if (siphash_cryptolib_available(ctx) && fals=
e)
&& false



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27ca=
a1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: =
17
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 15:16:16 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No

--IjHcNa/IhLI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/commen=
t/78464d95_63bffb70?usp=3Demail">Patch Set #17, Line 74:</a> <code style=3D=
"font-family:monospace,monospace">    if (siphash_cryptolib_available(ctx) =
&amp;&amp; false)</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">&amp;&amp; false</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3De=
mail">change 31</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Fri, 17 Jul 2026 15:16:16 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--IjHcNa/IhLI=--


--===============3464441219772216951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3464441219772216951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3464441219772216951==--

