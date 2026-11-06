Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9D606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UdInq7kE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SvXLzXx7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZmG/in5q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YHs8Qkst
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+u9IXO/gi/APjPi/+NgZUp3o6vuOWE5u06UKv/12o1c=; b=UdInq7kE41AXj0AY07IRF0UYAA
	di1j2Ff62jHnztVWgKNain+nY1YJ/2FXAyguMIxfX/0XqCnQcf7Nt2x1srwzN4qbTLlEkJq45SXt8
	PODguXIfaV/DwJ11sVKnzCxC1IEIFPDBeIvbQ+tl58Fo17HKQGAlpRBsYYLQaejt1M2g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPGso-000000002S2-3y5J;
	Fri, 06 Nov 2026 10:09:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPGsn-000000002Rv-3xCj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 10:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zU4Ql5Xf08z6M8+cP09qcECfVvJJ063aADviwtVvWek=; b=SvXLzXx7Y2CM8ZO+7imdPl7YLd
 3G5e7EgaOAD4k2UrePOXOl64HgNKlXw88TBa371dGOMjqKXwcpt7fneBr6f7kk9ZWRywjT9QbLu7S
 Tbt01q2b6lq0bix0GpOeYrv9W7zq8vDXLBLLviC/Ec7DUF16MPp25qYW2UbKWXtD19wE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zU4Ql5Xf08z6M8+cP09qcECfVvJJ063aADviwtVvWek=; b=ZmG/in5q5idFRmKy4uZfmzWllw
 lM5+QtOMCNh2rFA8+d1ApfP/TAyudy48n1FF4CejkCwADfNlwe4dmiRNDajlrgYl6TuWgEWV40LWg
 9U7wwtnEk1ExLuH4QNo1cLfkAMzXwh5KxW4COrkZUlgDXrUuml4s29BXxCwBHQEerjC8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPGsj-000000001m9-2hEL for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 10:09:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so4485615e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793959747; x=1794564547; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zU4Ql5Xf08z6M8+cP09qcECfVvJJ063aADviwtVvWek=;
 b=YHs8Qkst2QZ9juaJGhVONt3U4BZy5TI8fKbBf0T6K61FSkwr2IjRYSmtpKAaBKXXgp
 Q6AgFEnfHRBxUJEvTLqLwB7KIhZ7ZVfNCzps/45DgOcEK2+OTQKhoegW1JYh6D+JHFmw
 ROphg/DG1L4TnEyKnLkUfr2K/M9Fbx13UTx5brZK+oCcSdnGiNQpS9stNszN1EsWTqZ0
 sFElDWBgxJw/VVtRC99OUkpEJ+aamgwXZyUj4lzNPlpbFBPlmCV8EaScOoB2Aetg296Q
 iVSG8a1kV0CQy9Q/40vZ81rtQCK1fhJ7bUg1UcHljE1IkRpjABQV605LzjHtgyU46iCO
 oguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793959747; x=1794564547;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zU4Ql5Xf08z6M8+cP09qcECfVvJJ063aADviwtVvWek=;
 b=r+nrjMRmbDjsYi3IbNkiND/yeMvPHx0ipR3a9HjT03e/Fbk/AJEZlWWEgZrVEd+g7q
 Xc22nQa5Y3qMQp8guEt1lM29e6xtPtwbpdpLpJNDEui+1F2eNwX2tVnCBbpr11AzIpQR
 uNJp1tKBrzRni0CjiCMUuWxch1cS031NWGZ5fk+kjyWdKNSi9ZHJZcuywyZZ0VejZNCT
 cSxI0+fqHcsf5wnzicP0+nX47hr1wReD5CRxbMp9/eYgLfC9xb9smM3TLUKMBxEmuvVn
 78G3Kz5zUwwVoYT02FhSXdfoYjI2Eq3PUk4R4HbOoJzOu0RqcBjikuveSmBfIhaOvJvi
 +NDw==
X-Gm-Message-State: APuU4Z9gqYWToeKq/XWW80IOs0YEjWFaAESAXU8EUWnDEToXY7pcQugp
 gUoUuYmVJkuh3lyUP2WoMjsk0xS5rVj+/7N1dhNLqaczd1y4fzNswtdo4nGp2Q6SaoK0C4D6ezX
 ad040IIGFJylnWQJt+JMgiUnxDzo9ReRjBfwy15aRJ+GVugUvtrJCz3L88ZqK0GBLEVTx
X-Gm-Gg: AYBFou1AbHUC/Pz9JnggEbnojrBNy0xCiGfTA9Nc5gc2qPb7WRanwH70nEnkTSwKX4k
 arlum1i8sqyHyQmtkxyjfrsGBXciRwQm0BZKDMESD45AokTWI2K1q1EG1O8doe3LI7x7X3Q12mN
 q1gp+hqnR94L/gzfYROkgif1mfk0fTxCe2220zQ8ZNimiNVxMF81UqOcyOAGKVzMPKVGYElCoSn
 TfUjbAp3oeCDt/C8DKJM53zlX4ZfnvBxtbGQjrgDpfry7WRChfAuL4bu4xsfwN8JMFD1ERI/P59
 y2Y0z2eDhvR1D/gw9oNVZvzYmyN4BtjUBiLhkunNgVHF7mgZF2M1xklV3A5mywVKKtbZ3e0/xN/
 JPdyIluZepvOIYX/jIMlwtO21dBB9JzTWi9cS2yckllzlFFVnfBaXVXCltlj9NbveTdtfpym348
 mfbx9blMIJZNfk2agY6xdXaCJdvR9LrGtQu64Eoqlh+asBVoHrDOVTdghKzdMpZW016f+81z0+P
 +YtHs6VPvY3Q6ZmGnoJ/sMsKzBMr/kKu6btNyCO06/mX8HUrI/+ozGN9zz+e2/urFD1cePG4gT4
 gy47bVJWUEhgcbj2or+NYLDbu8c8bstam82tLPTrcpXIImrc3+akWuRFAEzDixNdPZ2NkJLdgg5
 G3SxzMsQ4+zCNRlwYZfvMvkeIVbtD7N39PhJJ0UDBlUjf7isUGkrMYnC1gvNGbbgBmXv+mddAng
 q0IXuXB/GRVIj1ZA==
X-Received: by 2002:a05:600c:6994:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4b6df11de39mr33024335e9.14.1793959746827; 
 Fri, 06 Nov 2026 02:09:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm124715075e9.3.2026.11.06.02.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 02:09:06 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 10:09:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
X-Gerrit-Change-Number: 2142
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2142?usp=email>
X-Gerrit-Commit: 6422a369d480b3f6f3a99471b8a1b81a7189dc97
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 10:09:03 +0000
In-Reply-To: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
References: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTQ3NjA3MDAwLkk3ODRmM2ZmZTE3ZWNhZGFiZjk2Y2FhZDExZmU5Zjc3NGFhMDBiN2NjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58a319c3dda714bc898683035b6858705a1d226c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPGsj-000000001m9-2hEL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: comp: use the wire
 byte when escaping v2 uncompressed packets
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4424508135353838680=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4424508135353838680==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5lPSDaP7nYU="; charset=UTF-8

--5lPSDaP7nYU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail )

Change subject: comp: =
use the wire byte when escaping v2 uncompressed packets
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I784f3ffe17ecadabf9=
6caad11fe9f774aa00b7cc
Gerrit-Change-Number: 2142
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Comment-Date: Fri, 06 Nov 2026 10:09:03 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--5lPSDaP7nYU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail">change=
 2142</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2142 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 10:09:03 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5lPSDaP7nYU=--


--===============4424508135353838680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4424508135353838680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4424508135353838680==--

