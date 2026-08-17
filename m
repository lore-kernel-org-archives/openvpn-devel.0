Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9604C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIHyC913HN+QRMPRRulR9+A+m5Fh5/Fb4sz78ovhynM=; b=esg7Ne9RF+EpfsEMBtMfe57O6A
	s+/+MhhsKgkIoDcRfp8EXit/syxv4DQQdi67fUObHPvZLMA5pr7wx2g7+T6czGqR8uynqxTyUUgrI
	gf/K33E4wVUgLYEmhPRdvRl5dMb765Vohi7CNChdMTUD/INxF9V5k6goMLQWoyYD15so=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwfH-0002jB-W2;
	Mon, 17 Aug 2026 12:42:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwfH-0002j3-6L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CllxpIdd/609z406ldNXEKm8OuQs+tPhW1H6xdj6UhE=; b=eO76KEPXrgsFeWtnA3c+oeA4Ml
 Q6LJ78MMV660i70RGUP7qAonh7A7xOf8i0Mj4cOpnaFy0Lzq7lp/R62AlgV3UxFg1LrDCXP9Ivk0n
 UDjXO7+t5PmwgQHtdBqTzqbDgyN2HLAeXPn1HlE1SROZBJcZFVoh9jIqkXt+1Ckql8nQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CllxpIdd/609z406ldNXEKm8OuQs+tPhW1H6xdj6UhE=; b=V
 WeXn7Kx+gaWoXU/kXhP7ikoKP024SPUo7iF/MtUwDZbKPUn24IWdwE8/rUB8Ijw2XEJ6qcLXC67Jq
 38628t7xrlCc21AAajSmhwfzlBicJWq9Js1y4TDmns74kL5WYd/M0X+p+ko5ik6PTmgON608/JCm8
 h7S7r966RHIHzdd0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwfC-0006nJ-Uy for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:42:04 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso42790625e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786970516; x=1787575316; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CllxpIdd/609z406ldNXEKm8OuQs+tPhW1H6xdj6UhE=;
 b=Bd1Xbwp0/eIV557ouK5dNadZuIjRV0VQZH1KT79MMxbzgjjuR1mad+n8n+V2NekrrC
 ok1UdXni7ZLpM2A6qrPXAzl67VPB++syue6njYC6nVxmUym2RIG5yZo981vfpJATjQHu
 QC3wEjAY/gJacQ10Km0NNDtYIMF5yY7Wl+KOsTlycWqSCupjRX5MloU0NzaxZsCM+eka
 6eexR4ZlkwH4RTqG/1eBdSvMtBv3ryFeLn1IeNJVi0Ejuvx5JWlm6laSWp+LZgd0Tqi9
 c/0mz9FxLO8O758QwoHr2r6+2CS96qwhB8BXdlUjPU4n94zmsHxWP1kQUywhGX9PQdNq
 Jctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970516; x=1787575316;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CllxpIdd/609z406ldNXEKm8OuQs+tPhW1H6xdj6UhE=;
 b=pXVN/krdY33fBEPg+MBRFldVh3wfxE5M7FtXPTI2SofHGwMDQYHCV7jhFHQhmNauoU
 Hv/g86NpL956mwgYkUOsCKVJI5+9eMouki8J4/NmOzATTI8vZnwg74ZnG1HEDmtwRdbs
 iXhOIGhCN4GBKGYhlM9EtBc3YeMLv/VRU+xz8dCLa5QL1PR9F/L99nMjwH4fyIgtSgk2
 YwCjnKeLiabP8mQXOfvjC47Rwy2RTYVPRmPepF0qzO6MqZFWVuPYn+arwh9dNCTTOhRL
 ZDMcyHVCLo00FK6uaUpFMIbvJOqaVXOhxvsH6fw4gRc/gDHwLJKov13u+YKdqqsQNHFM
 0SNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAOci3EDLdDLlOtyxWhlyNPWErhf9OOcgNjPtGkW1w9pMXyCmyu9D+EKAGBkJApMy58akdBtDr0Pg8axXh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyXNUyxpnV2l9SA5N0l/pT/dBKCHJHUR/3dU3+7lm0I0aDJpvzX
 shtT1DNuevSXUVznnmu+X/jjEFLN3ESTyIn7rGeMYOtKyWLmYr5lf0Wps07qs6Y7g23vG1mPkvP
 IijE5Gzp64LsSIZ1AoPD0AFSVsJo6Mko+nl/yhJ6Z0pC9QiL1+Y8r4cZ4kQVziS4oOUx+
X-Gm-Gg: AR+sD13lVd7ocBvVrOUxmL2nn+8YYc++lu0qRLL8vFEacsFuieZdA2bcNf6Wfigayy7
 XEGlLjGcRtxWBXa/LnRFlLeEh6P/BC7t05KAXl8npKBLFjOf76UAzoeLAtXi2oP55WeN2oHv2Rd
 hV5I9yTHZKYdgYbkQt/cpD+THyZAiVrdUBRWoAVUz1c+fnE6Et4eK/mpsnp64T+XPoVcK1qGujM
 UFrwTlFwUccGfZXrBfKJZ9+cgLuE1iKx/H/Jh+9pD5iKTmUk+ESVPdsnVnYbyCKSOwt4ueyAhBp
 9airN0qWzfnhtIxUxGiSG/UsMa7gyMg6pzKNPV8nMiSVRY+TA6GmTVACPYuNFmZMinVt5ZL1XVN
 H1owjZfCJCA0x3H5Hkwr6mpO3GJ86yRzqYf53usPa6UoxKo1Q6zrWcd67nrnyPx6ebACYQLjBCz
 q7BarFuO1bO6hsw0QNLy+eygfjDK7xKz2+30gh1DuV/etvkbo7Sq7Ifu38t+bc5K8A+8T7AAqs0
 PKK81C5o2Ys6a24zxOs5J9496EBfcFY8hxuNT/cIyEqk8ClIJrb+i9401yGA1Aa50zkmDmZe0rq
 PmsdXPFvq6TzEBA8GBVv2Fiy79B+NDqeHyUV+kbbdibkOFwnxi3GyrQc7E6VZg==
X-Received: by 2002:a05:600c:1546:b0:499:484a:98e7 with SMTP id
 5b1f17b1804b1-49987974700mr366189585e9.14.1786970515067; 
 Mon, 17 Aug 2026 05:41:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0876b8sm53327795e9.8.2026.08.17.05.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:41:54 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:41:52 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:41:52 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9b52eeb54ceb72ecb309b9666a3f2bdf3e60d20-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwfC-0006nJ-Uy
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4239704239237785724=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4239704239237785724==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G9MxdnsjoEg="; charset=UTF-8

--G9MxdnsjoEg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/9f=
5dae6e_7a41f8e1?usp=3Demail :
PS3, Line 29: #include "syshead=2Eh"
Looking =
at src/openvpn/lzo=2Ec, it unconditionally includes this header=2E comp-lz4=
=2Ec does too=2E

Not sure what the convention is here=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472=
b5149
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 12:41:52 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--G9MxdnsjoEg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1772/comment/9f5dae6e_7a41f8e1?usp=3Demail">Patch Set #3, Line =
29:</a> <code style=3D"font-family:monospace,monospace">#include &quot;sysh=
ead=2Eh&quot;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Looking at src/openvpn/lzo=2Ec, it unconditionally=
 includes this header=2E comp-lz4=2Ec does too=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure what the con=
vention is here=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61762374c141=
662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:41:52 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--G9MxdnsjoEg=--


--===============4239704239237785724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4239704239237785724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4239704239237785724==--

