Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5AF606A329
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VspAgr7B/zeCrnDO5Ve2euA+Xu0VmhLvGeW0UoPUhYc=; b=cy7e66ZOW9xWRCu1v532ZKKcPC
	P1YeHCp3w4zeBEf2XCCsNTD0umYzUqfZ3FBk4hRA6hEa8WsdafY5SODXChP+uCU63qkZwJRMmG0db
	ee4wIa5qkWnRt2J2We0VwJHQCLJokFmZLzOCgw/nzd1nfSjOLyIArxhq4X6i1MZ3EakM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdpz-000000003ui-4Ak1;
	Wed, 04 Nov 2026 16:27:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdpg-000000003uN-23xb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Pu+iJ0OUFe7XFrY5gq41eFD/D5xPHtyL6pLCAW2Upc=; b=RGMaRHI0zAiR0vSKHAkwOUlNNm
 a50Y6W86C7TGDlm2ngqN7ubMBvCIiS5bl/XyvdXX1vdVm/bl/T6OIeiBWc6OVnCh6Hi2zwA+KCeS1
 mk3p0rh81vqaANcb1JYyZwsK9AvKHFRlFS4xX3NYQFQmgP2IzA/3O0p3TIiY1xWbEOkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Pu+iJ0OUFe7XFrY5gq41eFD/D5xPHtyL6pLCAW2Upc=; b=TE5+OASd5IMDA1MCBlCgnqorBa
 ujf4OMTw0rW51M0GPpnXedH0EWLefkHLSwMIxDyIx0a2ZYRchhsfAAyZvfKvk3peUZurfUFh8VcfQ
 eiwwToXLdOEdR6vni5JWjBcM5sV62V1wZ4lGGbQ06YpWkWrOfr4zn/36Jb+Qq1iuWaJc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdpW-000000000YY-3Uy4 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:27:20 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso628004f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809632; x=1794414432; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Pu+iJ0OUFe7XFrY5gq41eFD/D5xPHtyL6pLCAW2Upc=;
 b=dm9PSnlnGOdQ9ij/NJc6VrEdacTWhC0szwKjdkioPYOU4TAlxF5RE9/i5qUWYh922l
 wzgofqokTHoMaHC+m5fTGCGNsXlOej0G7rSq5QvWkknS5q2kmppV9wNXtvNr4jDiiMhQ
 gOE1fmu2SUQoFS/F6i7u+MMmGEqigeEWgPkBQJf+1tK7JZM/pFBZ2QUGd4gqaiqkIVSK
 rZoXO0h3wLHqqP9PHbPhKFdP5UZiG78OATHFpLktKCiyCeiLN2hC55uEyg5fkBFKWNvU
 yTVPCETtBH6Nm6l65/ztvD9wgY1eleKuhrxqHWj/guxBes1gNId0HgfRXwPl7g51HRak
 Me5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809632; x=1794414432;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2Pu+iJ0OUFe7XFrY5gq41eFD/D5xPHtyL6pLCAW2Upc=;
 b=e43CWgNWeNZzyH/1vHmz66jDJhmo7GVwTT3T2fFu9Zgtgtt4Iq9Ov7VXl2sE5DgFBF
 yDyDPmYsR8orDSJebVNGYBoxLKkvY6EBDgJ7UJ0JJGwGZDs74bGiuOSfQnrlCmMrK0Yy
 9S5aYYYCsvAB/r4LyBSe34AYF4n/E/jqEnV9daYztVqobBu/T9gJD8po9w12s7YljGZx
 1L/ehyOLBncZsoyNND4vg8SrnACYCxb9IU/fawv5KrLh2mfbeTg/eixWC31ZWc/0nQsT
 WQi4DaT9VQ58l0DkNEGZrafWW2+q8SnaJ3fOBOEhBicbY4H3ew9xycJJowNFtDngFG7o
 Mlgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdEcIGcyguD6CiltkkzfRMhu8mdbALtV33+ICZcnR4pAZlUnPoxq27Jvten/quZmxSvzt9h3jSiQtX5OBf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+L2TYcWkBJdxx81Czc23CrmqOFUvFHaDjP0lNxlehk5MFIxKQn
 9lvP6TvER0s0wiHA9RE8P6YP7jomI9RDg0UTblVDLnZFXgsZsOFEGh4I+rPNgU4b4VjMXiANDKu
 8d+DQkDIR/b+xoc2JXnoAY00YnaWj0OVDcngXfX4ZlcuxZ72jLA/V64DkIuwNH7td8g5mvxl7qL
 c1uyBMlA==
X-Gm-Gg: AYBFou16bgpIF8bjg9n5bs5kO/qejlokKTL72rtDvCA24516RftntvNnoGg6Uzor9Wn
 4lS7+OVuh+c3Z7kA4yCNseIH7B7Oyd3zoB03snUrjDfXeHMnZIt0GVlVuUDB3eZtl4CNWpf0Los
 4zM0jBsvfhoowhb7ckGB2k1sKGpwuRSNsihg92iajQ/sU6xU2sBqgyLU1DPGoufRamIe/b1n5zy
 7QRQ+HL3Akeik70XLw4M7pqjIpCl7Ayg7CQKSMhRZTpDzh54197nA9N2CzyS40bMCmZuTeLFNzM
 GEpTg5Q8Vxlvk6u909pfU7A4l6Q+jMyw9gALx0KyUMRr1H0crr+YjEXPKLN39O8pwZF+HjMJZxS
 8Kljc4gQ0wnbNTZ5eTJrz+cgJ61yPqR/eK3W/zEUK/dT2j0tpbSjMywui8Upcyu3ADKtxZm58Rh
 Tm9ESf8f9JDVvrIPqDIRDtAtoO4SoHJzQWycc725hpS6An5teuWktRhmoSM55EYOiiAayM3EwgW
 tr2htSG7nTzCF40OIwnL+0n86ldMPMuqWP4q/2PEjTVL5VOcjm3BaDLoWpAOowIYJ22mwKTzb0y
 7UYDDwO9+lJkEbLkHHrJ5giHfzDkiTRnKhIRZsssT7bV1+UZzjI+PI5LMpWqOogzVq+NC1jtKcZ
 9fc2EgsGRaCf7RoJfeChHNnuyU1aUeI+BBvA4gyTRe3irCY0QDg7eWnNwYG7b+8MOD/x68Qr/I1
 7RllNOJV/u8fypwg==
X-Received: by 2002:adf:ec49:0:b0:48a:f404:695e with SMTP id
 ffacd0b85a97d-48e6e4fa651mr30272182f8f.50.1793809631841; 
 Wed, 04 Nov 2026 08:27:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea181085sm4847263f8f.1.2026.11.04.08.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:10 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:27:10 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7008e9dfc229db3fc94051e6011d798b6a55b861-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdpW-000000000YY-3Uy4
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6846014780230313076=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6846014780230313076==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2oT/lS2IETQ="; charset=UTF-8

--2oT/lS2IETQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5: Code-Review-1

(1 comment)

Patchset:

PS5: 
Giving it +1 s=
ince Arne is also now reviewing it=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Chan=
ge-Number: 1965
Gerrit-PatchSet: 5
Gerrit-Owner: Lev Stipakov <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipak=
ov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comme=
nt-Date: Wed, 04 Nov 2026 16:27:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: Yes

--2oT/lS2IETQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1965?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a>=
 </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Giving it +1 since Arne is also now reviewing it=2E</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Wed, 04 Nov 2026 16:27:10 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--2oT/lS2IETQ=--


--===============6846014780230313076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6846014780230313076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6846014780230313076==--

