Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F941606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PHaHTnhg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O/yG5/gB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dGtH4Zv/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bV8jAJYx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KQSoOQ+hw4sMFYp7SLX5/Q/A0E6rbju+gDzGn6V17KU=; b=PHaHTnhgAIc3uOGpY1kqc3A3ny
	m2Ok0HP/ScSYTzRHYBzdKOHR/ve/uAd0UgM54t4IlrjEb28rT8WZcmylALXH7QlZJT8jtqaOEja9d
	EjcVBx/onsv5yUKhQuoz70lbpIqnhjxATKxEtgZzErM3rW4zwPCylD9Ie9ArDX5MI5Uo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrbn-000000004Ty-3zfm;
	Mon, 02 Nov 2026 12:57:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrbm-000000004Tr-19Sz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x+JxCiDqGgc+a4aJV8y0AU4J6YJdKbosi97GCc1tzWA=; b=O/yG5/gB7zA9ptYs5nhlfmMVMX
 IDVNV0nES8osHaO6S+43qUeQOA/TQlHHpRpd6EYXEm1C1kOeTtfzgDNXHQ+ekSGSjNTTwfVyQE++F
 4Xxt4BPEmXaXHbbRhMvGm/9e+zyp7oSNCMWG9t4NTG9EH0nbsrCcpG0AQ2mUJGh9o9UY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x+JxCiDqGgc+a4aJV8y0AU4J6YJdKbosi97GCc1tzWA=; b=dGtH4Zv/xYHe31xbv+Gck7HTcd
 KCAvj5tYsTQr+j6M9DyfPZzu23NDP3AOGBq/pNSYDmytDlZXU5y6lXt+XC+F3kkpRQgpS6f/NT9e6
 O+zEysrZSqKErW5H2WJjzAZdq3y6IXeeDNJQ6baDWQFNsB8iE3O09WM6S6BFe7LIGdus=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrbk-000000007hA-2lPR for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:57:54 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1619072f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624266; x=1794229066; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x+JxCiDqGgc+a4aJV8y0AU4J6YJdKbosi97GCc1tzWA=;
 b=bV8jAJYxdx1qcRUA5jTuKA/fchBENqTMQIm4+7hz94n8s38t7G6TwjMFpiGE4zQ/50
 z+T371Yl2JzcCdq1QdiEJnTwuxIQ4Uotz9+EfGSR0fyYEkaSPsuS3141Ylsd4HEXLD8j
 R6s9MaEiXWl6zgJgOWRvmPfdBEdl5SCE+BdVHW8EVUkTE7Eyw0PyF+re3jDN+qXK/hFL
 Ujc1rg0qHFsKyjlEELzar/Q/wa/tuNjohWWBikIzH6Zo/XzmTHmwoFffbyp3DJA1mcUg
 Cven5XKWS60fB7a9/RDGQNEAIzdGCCfRj6MHrTaK6kLsNcS3J6t3sh5sQWsHCaKjzHLH
 LtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624266; x=1794229066;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x+JxCiDqGgc+a4aJV8y0AU4J6YJdKbosi97GCc1tzWA=;
 b=27pBd9rZZLduaA/JS0X20yOw7LkJk8hrFbbXhc/AiwLhrMXM72itU9wKxDat6VshKw
 f13RoHQ+5JE9gki/0hrAq6otq44iwxd/TjzVg1NBfNZAT9IIvNEOMpXaGfI0PBWEKphl
 ZMZ0pVltaBaAJEa7jJbEwEIBpO9aNl+DHgBe09UU+IoXS5EuoKY45TUoWPRqqJPODdp7
 6jwzYwH8SVE8mU/4nzIA2Bt4gbiAsB/vJxZ7ziqkGEB+FrXGtHSd3lReJBZRkDFhOesA
 pe6C8FaFnSpdVBE0rqT282aGhpEPr15S9qpUfSDVT2GKbzyHkQeQ1+MKP3h8vCQlIjQR
 IFzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByf4ZQTV9cJb4THrPI6fbUataXOsJ530fzblrVnPeIqqwt9nuFPEr+mS/iZXja2tAJY8xMbjLO8pU7wTRdb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/xp9gH4CLGbrs34k80cqn/UEyouT7LrKE7gPtQi6LdPkx74hLY
 pqi2uR4xRcj75/P9Zx7G6vo+eo0Px+cM+QzyoD94yB0MDFnhSa2439xRggYYmaoA2ysZHvIk6JO
 phDm990ggMuXQXfmfqoKEgHZdJ2wdQPP3M0vlNipe6OZjVDR1Dg/i8s8gplomSIBx/2wJ9oyT/k
 t3pxEQng==
X-Gm-Gg: AYBFou0KxWQK51zxn4bbOg8oN5uJEDHVoZu/L7XGDSMk3HPZU1HPixptvknncp2+7Tc
 8GVJc5cRxr3FFSSnp0iiSLcUrtyJp/7UpUIGHaA6TmweAAXr+p8S62qIQ8Ja3F53KMG4ojpY9BX
 mQ2KKVN/nlV//wloialzsm5cBYjSAZDvZNmBhzvc/jP9/oF/X3orJYc4+kilk+DvAFWb1aPFnSN
 GsD7sZZEvbqyPmEJjg8Kro9f5rYN7w3nN2s19i3atvqan3PedibD7dfuBw0vhDg3SpPSsHgevqH
 E4sCcbsGCT0vEF07IWKGsO4mP1L5/w0GawpJwm7zqqvW16YfS+NxNoLqbImlMvrDat0uqIxOy5m
 Nry4IBtkUHY4K8W86OcvgSk4Lpbv24z441Y3qDzxpXE47ktlLgooIzEmpyzxsLInhBTeEH8uegw
 29wgu1N3NezLux5SypcpmquIMIUFIbp0GzwZpIK/F90RGQoKNi2+F++IabT4+E6BJO9Lw5VQpYd
 pxypmiqytFk5iHo1wGoY5NDw4eQp6g5n1z9++NC18d5EG36UTcvOui9+IQjjX3MaZZ74e68VL8x
 A6rscBzPHpA2fac5OUXyMoEO8Fzu4BHLwKRVFn43TZt2gEU/7bI7+F9iCp1SlkjXtHinI2QafJW
 vRxYj3MNdl/wSUCpUJen0LjpZNZSlAqgZm7AxA8FMZLcnMhVCW7kzLl6WRqJ29yWlFBrVoUmWiJ
 RVez94sS7Jbrnp9Q==
X-Received: by 2002:a05:6000:2085:b0:48e:7a41:d78e with SMTP id
 ffacd0b85a97d-48e7a41d798mr12382223f8f.19.1793624265887; 
 Mon, 02 Nov 2026 04:57:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22387261f8f.6.2026.11.02.04.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:57:45 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:57:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: 8191543f128ca4c29ac7f0806663132bead3d1ae
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:57:43 +0000
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d9a7a0dab46df8f59c758e34e49cb2e6060f016f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrbk-000000007hA-2lPR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9220461535699946044=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9220461535699946044==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UDXkochDvMY="; charset=UTF-8

--UDXkochDvMY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

S=
teffan Karger has posted comments on this change by Arne Schwabe=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail )

Change subject: C=
lean up weak key check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

File src/openvpn/cryp=
to=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080/comment/bcd1a988_2=
46b9b9b?usp=3Demail :
PS2, Line 1680:      * not a compressive check, but n=
o valid key should fail this check */
Comprehensive ?


https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2080/comment/6023c95d_195bfd26?usp=3Demail :
PS2, L=
ine 1689:         msg(M_FATAL, "One key in static key/generated key  is all=
 zero=2E");
Not sure we ever trigger this code in response to external inpu=
t, but in general we should better not do memcmp() on secret data, because =
we might somehow leak information through timing side channel=2E Use memcmp=
_constant_time() instead=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Number:=
 2080
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 12:57:43 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--UDXkochDvMY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Steffan Ka=
rger has posted comments on this change by Arne Schwabe=2E</p><p>Patch set =
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Chan=
ge</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2080/comment/bcd1a988_246b9b9b?usp=3Demail">Patch Set =
#2, Line 1680:</a> <code style=3D"font-family:monospace,monospace">     * n=
ot a compressive check, but no valid key should fail this check */</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Comprehensive ?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2080/comment/6023c95d_195bfd26?usp=3Demail">Patch Set #2, Line 16=
89:</a> <code style=3D"font-family:monospace,monospace">        msg(M_FATAL=
, &quot;One key in static key/generated key  is all zero=2E&quot;);</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Not sure we ever trigger this code in response to external input, but i=
n general we should better not do memcmp() on secret data, because we might=
 somehow leak information through timing side channel=2E Use memcmp_constan=
t_time() instead=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">change 2080</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic5cf5=
ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2080 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mo=
n, 02 Nov 2026 12:57:43 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes <=
/div>

</body></html>
--UDXkochDvMY=--


--===============9220461535699946044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9220461535699946044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9220461535699946044==--

