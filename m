Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23347606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hqkpdDMA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WfMnHeUJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VzKU75XB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UpLfTgZM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+E9X7G+ZPLuirJlEtXd94fGdvckBor5llRJ9t/67juk=; b=hqkpdDMAeDgYzHqdNemajQ3V5U
	IJCyTe/WrnLNYdt9T5Rg30s2J5ERyyGOgCgzBaxy7u+lVkppnwFLgh1Nb6NjQQ57a1pn5PF3N+AD/
	36QV62RNjXVO6xOags00B1f2LxOqG8UM58i7x2gQ76Z1W3wDEFFD8W5NyyKKM0UyU5dQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0OG-000000005fi-2ggl;
	Thu, 19 Nov 2026 11:33:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0OE-000000005fb-3oe7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oVVZK4ecx3bvqNtuISfsWeEeudNe+ZMorie3PNcVVP8=; b=WfMnHeUJUAcknramtJryuAGEc0
 a+3y4opY9He0qTeYh9H33b2NhE1rIM3V+eK7X4tYoe8BuJxOR5mD8kW0HgjLzQraOr/KaYZEAed9K
 Gf9c+87K0iUChH1SLlO4/D5Vnk+mbx+T/8Ds3N4YKnn1ENS8Sa7mGZ9hP1XC+btqHr2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oVVZK4ecx3bvqNtuISfsWeEeudNe+ZMorie3PNcVVP8=; b=VzKU75XBnWizM41S4J9nLmwUBO
 0BM3hNQ2blHj8alho04IsKviIyC4M5MmkIjGd/PnSY9OWb9dKxRNlHDOq4madjkNqQobdGmj5+7HQ
 CSY8DVbAQ61XoLl3GoyYCfHcxNleWioeWldHtgvKf5cC3Yagbsh5RnVUi7MM1c011PhQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0OD-000000007ND-22lb for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:33:18 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso1653581f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795087991; x=1795692791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oVVZK4ecx3bvqNtuISfsWeEeudNe+ZMorie3PNcVVP8=;
 b=UpLfTgZMUeloymCJzoZak/wLNusP4yI09luXYoSqPL7Bfcgdpv3BJet+tOzbr1LrYe
 wnZDN2ZZOPXV4xbq4YoQW6H9AM6oKGrTrW4o6aiTX6qUpHJOVED0pLG2bqWgmH+b7r7T
 0XFEs0boyLuJ+qIxMVpB/pKY2L57Hdea0M225pisMBUVRt52KYab1ei7kyEiRQnO+W5R
 TJj9yTvCTHMbxFFd/IP5ExlU7kFfixJ5tK5AGDQ6yqjbiUwUnLooLABwZQosLqXefEHw
 fiWzpbPqjAm1xjyBX3MAYIS93ok2CSmwamt8mqhbxdPYNf27vP+TG00pV+xNjaTAG/Ib
 KUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087991; x=1795692791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oVVZK4ecx3bvqNtuISfsWeEeudNe+ZMorie3PNcVVP8=;
 b=U6rTKCDiojiEVz3n7z0WtrYW+z1mJYzPceDtu39jVRniJMMDH0vDyzFGoSWOcuUXBm
 BrLAwsu9cVb9O32VT96mB3TrO1K70CUAI3eLE0gDEmzciLhHuF4fNYbv6KcfPaHg/lwz
 ps5BGEDWKAYleAlfZRxHq6VOfmXmfCrLDNwQs1h/4FGP8ieLbwOAZ4m3wVkQa7D4C1ir
 jgrpvs7DWhUjhz9r6f/UrRtnI8v6iAA9SUG44IVufDUJd8Rw3IHUZQohnDG0+/R5/tYO
 BGua5D9xTKyTaBBbtGTBFwvVhfiZZZfe4+tRDvsaKXYln1ieDoGCDrOhPW+FwV8e1Z1e
 e1wg==
X-Forwarded-Encrypted: i=1;
 AL+hErGwVB0LbPmkumvzf1ynug7e8BZPm+9N1DVYWEem6ALOwrOQ7/H+XEl41TklCIerx2Mi02YCCzLTc6wP/tJi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8PN282ywU4X7YlCpbhR3cc2/ORmdSmToUnbimI9PnmafFFIz+L
 m320qAa8M2zDGHamnmDxeE0VHnnIza7tMPjVyZ0WpMxamqNqUIWZD/C6qbI/2rsYb5/U3OlmFyX
 SelVtJr78LofTx5nbpyQxNMrG71QL5ebOz8Ez6ZtaKsCz6hmVmTiscG8Oeg3UDbtndJ5QFYhgla
 DSWrLp9w==
X-Gm-Gg: AZFdTZc6px3tZUmtPf/IQGXxGbfw2Jnhf91+5GOspn+624H7r3vt3CkPhpEXcHFpHIF
 NbPeKfuffKH8+skgE/4UQnitjlhkLHlIV4qcWScA2iulKvM1SpUTG79I3dnEKgdEfHHRFWJB7cx
 pwXXcTXzalR50o0pvpvcycFCxUzRePC54AFY70BieUwhR0ryUDuwyrUDCMFDInGUIQsrtPhO44Y
 bu8tQSG4vjXbpiRVeYBV1kEVfv1GNH6lHFxz6+6f+xOt8XBI9v9nZx/k/3yZnHd6ai4Xg245Y3q
 IeHRwov+nu1XitbcXU4cCXG+a+qXGIvxM12xrIh5TeSinxNAmJrWHNYI9eFTh2szNLhGn6C45Sw
 qQdPh4O7GcVGvWutm291bsk/zcW+yuWhwqBF5w2hdF5h8lVFpcCwKjkgEokQ34+Dm31P9+FOfhe
 D/Z7+nE/Iu74PO8b4aru4w7F7GKw9xVQJh4KgbLlpzmfSSyOTlAm6Xp4VvX9fIRh3p3bw+OXtQW
 /RnR54PehcwLs+DCMZBKVFdModpipBYdBjEH8bO8Vh9IH2jD0GkxxoH+x8BYi0znfwN2BlZQrXX
 +WvIulqbPQWJdEH5BEDr8yoDzPAlpQ8a3AyLzXy7ds7iiSqBhXdowHYaML+KHd9KtBZKkTaGJNq
 qxCPfuFINAeSABXIM7/VtyE498NWfKG3HpEWNDlk/9lkR2oocuZqEdLd2yuV00d2+k+hPjWEEMl
 9bzc7cqSZAeFdmI90=
X-Received: by 2002:a05:6000:184b:b0:48f:bcdf:6f7d with SMTP id
 ffacd0b85a97d-4a63b6fbd88mr12578363f8f.34.1795087990740; 
 Thu, 19 Nov 2026 03:33:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3c6sm9275277f8f.19.2026.11.19.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:33:10 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:33:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
X-Gerrit-Change-Number: 2223
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2223?usp=email>
X-Gerrit-Commit: 689abfb238b7b44de2431d3303448dd93d61c1ef
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:33:09 +0000
In-Reply-To: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
References: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc1NjAxMDAwLkkzZDVjYWFiMzIxMGI2NTU1MWUyZjJmZjhmNmUyZWRiNTAwMjJlNGJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3bae6807f0fe7ced948220e7d678a8780c1fdeb2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0OD-000000007ND-22lb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: sample-plugins: drop
 broken defer and log winbuild scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2810842862272656080=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2810842862272656080==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Irfp2IQIZ+g="; charset=UTF-8

--Irfp2IQIZ+g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail )

Change=
 subject: sample-plugins: drop broken defer and log winbuild scripts
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
23?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d5caab3=
210b65551e2f2ff8f6e2edb50022e4ba
Gerrit-Change-Number: 2223
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Thu, 19 Nov 2026 11:33:09 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--Irfp2IQIZ+g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=
=3Demail">change 2223</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2223?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2223 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 11:33:09 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Irfp2IQIZ+g=--


--===============2810842862272656080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2810842862272656080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2810842862272656080==--

