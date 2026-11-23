Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE68606A337
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hKC/i1WB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GmJrJsNI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GGo66AVI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GhzwPd1G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=p4MSjIIEfi9Hg8D4DDk6G7LvFrE2sMp08ExbCg656WM=; b=hKC/i1WBc6r4buCQ0KPRK+s5Jz
	fy1ztebGI323V925hXtN8ld2FqnjyWivIh/1lm68xS6Bf27T5qrwJRq96Ejv2M25p27m0CgBNF2vU
	i8m86m5A7Mb4yqFmbVjk+88TGU+ggivXSyPqwgp10Naa+dqGyd9Dc0gireaTn4MRpnFs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUsK-000000004aQ-3Thf;
	Mon, 23 Nov 2026 14:18:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVUsJ-000000004aJ-0sfo
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4XAXmc5sbcsx06TpcJ/mzB1iuatgYp2SUPRSYzZj9s=; b=GmJrJsNIJRqxjsdrZCbS9xX3wY
 o0SyA9lBpnBPNnU9NmfrP0dfFsU/QNSmHrMYA/ewEJHetkiJVuWZFyXpXpnH6i2QLcSWfh2/IB1Rt
 DcY6LysRO3/1Qhi7Ji4l5+ixNmCXEyklpwldsSMQyOdtA9FqwcmKtceLeUCyHP/u/PX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4XAXmc5sbcsx06TpcJ/mzB1iuatgYp2SUPRSYzZj9s=; b=GGo66AVIrzuVq5eHtv0/e48dNs
 S1HtaiPYFWKP+89c3HOdL/YtexW73tttRE/KbnWPMJLZ6CVpm/Coh2aWlPHOZBFuqPb7tF2JAPifR
 KStUVt1s/YebsiohurPn5rxa1ojKN8PXKhTBKfEmgIUt4nPCIEqJvRzNacdC5/msGkJs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVUsH-000000004Xj-2VK8 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:18:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so2592395f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 06:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795443503; x=1796048303; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m4XAXmc5sbcsx06TpcJ/mzB1iuatgYp2SUPRSYzZj9s=;
 b=GhzwPd1GIyaxxAil4MhCThJDSE/j8NFDJLM1WWN4eaWctdZZ45GeWiB02H/0JEn5cm
 0kjlzizGJV2IznvQovBRRmlXC7oQC30Ag7m8RIHUaGQVaAoqeAiaReLfFGg1O6p5CxNU
 NR76MyzcqM9n6NvtIsqXVt2+WE6oUiOTwwAoqYjcYwr2sLfoepfWd8Rz8pkB7QZ6mO8t
 0jrxaFNaSwOompSaZgtR1P7maI62ZpoWCvWRTZPQGbSgFTKaR3nX1eNz07Hi4VgpWVRC
 U2IMcrl/iB+1AsyOZjJXlrvz6yx53qM/83S0BeKU2CbRuCoFS619KlNgWmEpJi0sRRMm
 Fseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795443503; x=1796048303;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m4XAXmc5sbcsx06TpcJ/mzB1iuatgYp2SUPRSYzZj9s=;
 b=v+jXePecZAVXbCG2E4B3MljxhKxcDNFbbCYs/TkttZJg+92ECCuK0n/KljUptt2LuK
 om3tOn3oIw8HROO2GluIxGftfdYA/42cux3xn0b32c2gH2bNh/SlM2af3XuNp7U9xOYu
 q8y+4JfteNDUqyrv3ER73J18VpscCp71FU0NKfjGEAwaVMdA25gh8wj2CEIX/3kHZ7Po
 Ztt+hHvat+X9kYjqnwS0aSB6lEcSmcrD+DFEZvoFigDAXrTC4RlPhlYwZMvuRSqvG+4l
 xy+LHgWrteGKB4SiCMAU8LjinIKGIdXJ8CF01HD+Bw3916/STcsn3QFQBFQ/diLo3NRs
 ENqA==
X-Forwarded-Encrypted: i=1;
 AL+hErFBjqhMAoeFYxjJQKt5C0MpjLJ8/FUmjUMagiCRlRV8uXEDJwkvwytWZNE7GwH87dEmSN5zDRVPpFIUmlJA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/d0q0KM+u9IvICzm8CPuwc23+earE6kcjOzi6GAIZYqPOp4vWD
 uXE+lVO4ISVI8E8azgVxh/FS/JNS2F0HT2vjO/r63xQdPBhFTMnGi/g+eag+YJsSjACx6Mm/Ryw
 EY9VRmAmTlAfkyPvGQQTdvbgXMGoYWvxXH0gbZSbbLk/g9IghLv9QZ6fC2sqLfVxmiEsf
X-Gm-Gg: AZFdTZcwZNEYSLAJagOxxJtXE9pqBw2ltYnS1EIqHHQgNWu6Hsr/3oyWVlFwh7uiftf
 +tReUwFY+R24CyEqUHZ9y7WVzMkc4Oqq1U+4pflT4WqJ76DkH2DHBLIXyRgUYYV/bvHhcCuDh8L
 ga35hPZgT/DYwRwX+GQTrQCAscOAqO1Jd0R9hqIcT5AgClD3TAlKkAVm7/tes4slVxPLdrr9jrb
 QJ3VvOl6MqVmc+y0rXOjMluIjj4rwtawwobQJlJT/vSVSXwPdxUNaAVbeojXlF9p+hpNIaimWQR
 n7X1ZBPRiR1Zj9qPJYylFR14QpLYS7fY0S+DZqBSSph2tiMiebO73PTWQx67z+XYydSiIbOznhO
 971ao0qIga9DLde6/aa/nC9b5nwlMzrCX0dAWDBEy6paXoFXpbI3KUIxQGm5aQo5fmtl3StxF7P
 rQkCNRI9YDzdIMr+Z7n7BFt6jhH1avb3UGlAAESzxWc++IWdF7ngDNu27tKZWsHLYSQQEDGthUo
 sBbzSysPm0zhi7oFt3/ovxhzttSLDlHVZXGTf/gr02KjaRetEqI5bHq1MjDIFBIP2YElSrz/uii
 +6Gx+wktZunJ9Z/JdIycpZZ8AoPbaGBBgtcCU1CAEJ1dFO921VicCY0LLkjOE8nl425DEkwyFTS
 q+ItfE1xYMiVIHZNVEPZS+tDEd43K/Kj8TorUz6nGujpqxsvEpDnySoreYw5djgR6B/py++obWh
 oI/QvI7z9bgtWJF/Y=
X-Received: by 2002:a05:6000:4310:b0:4a9:6c58:178a with SMTP id
 ffacd0b85a97d-4aa55bfeb43mr29597531f8f.12.1795443502854; 
 Mon, 23 Nov 2026 06:18:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm23260447f8f.29.2026.11.23.06.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:18:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 14:18:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
X-Gerrit-Change-Number: 2329
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2329?usp=email>
X-Gerrit-Commit: ddb3ebcb8555ed31532915f0053c3826e93244be
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 14:18:21 +0000
In-Reply-To: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
References: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQzMzk5MDAwLkliYWI1ZTMyOWQzODY2NTFiYTBkZDBlMmY0ZjliYzYxYzM1N2NkZWJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4073a2a6cf8e42736dccfd1be3bfcfedca636c1b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVUsH-000000004Xj-2VK8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop unused
 is_ip_packet_valid()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6969459308455725129=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6969459308455725129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GgNL1tAPflU="; charset=UTF-8

--GgNL1tAPflU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail )

Change=
 subject: tun: drop unused is_ip_packet_valid()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9b=
c61c357cdebb
Gerrit-Change-Number: 2329
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Em=
uc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, =
23 Nov 2026 14:18:21 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--GgNL1tAPflU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=
=3Demail">change 2329</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2329?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2329 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 14:18:21 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--GgNL1tAPflU=--


--===============6969459308455725129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6969459308455725129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6969459308455725129==--

