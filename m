Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF7606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OwIvbx9w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VQXbzvNE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L2n/HwO2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Es3AYuJL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OJGJPsb1DTvwYbiPWuQJBCUeBaPbWrDYdmaikVKDNnY=; b=OwIvbx9wz86lTY3yM6P2nB1XYp
	p7A9udSa/tKZGUUKE11SEGGiXB56vFCzZn9CextJfc5kmvv1V4NhiglZfdBMKr9T4HRuLvE+ucHoL
	poV3ZyY0KJMFukwRp64qaA5HndYnVP2znrnUQ2qMeTjpkVTYX9TISMrEyjHYY++INLdg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxOc-000000001Or-333u;
	Fri, 27 Nov 2026 14:57:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxOb-000000001Od-0KjC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K57Bd8yB2yiqMDDr08yUgZhrdZ4o1t0YlLEx3TTALvY=; b=VQXbzvNEiNEO0D9S/1bO7L7ReT
 JySoEkeD3zONLBbBlD2Mtgq/YIXW0eFQqR/zWB1W8l4vioxqWxIihrOyugkOZW4+2PuPgu1LYvMmR
 6RISZ5eceq8sETAuF+ZdmzfDthPL3KNtSTEtVwK3GIsBpJKKvoIFjsGRdhpqjmLi8wko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K57Bd8yB2yiqMDDr08yUgZhrdZ4o1t0YlLEx3TTALvY=; b=L2n/HwO2bzAsydh+j0wZiy+DQm
 UnA53upazc5Eg+jDL2nAyio0mjAFH0sdu/BocrT63n4d5hDv60wLRP3VEwZ1lq2bqXse3g+lvGBa7
 F3BucY9x0/hwXItoitVPXOt+LblZkHmvLY57BJDhu4V0b0RCmCtgayFYJOuKyVPqDp/U=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxOa-000000006fO-0hY2 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:57:52 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso80323785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791466; x=1796396266; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K57Bd8yB2yiqMDDr08yUgZhrdZ4o1t0YlLEx3TTALvY=;
 b=Es3AYuJLUHk6j2IaSgVx00/FbdaAZb7M+o/MTmDaONoh5iSk4B8TxmrpvCG3WADORq
 t+bnT8tCWRwvIPUiGAO1klQTafwLcrR6N3TuWLsFhtYmvdWYSciK2xme7qMEUt1sP7yz
 nvlmiy7lYNFd82OimQPwbqaBY5sOUOCnfOPXnaCmlEHrtZn378bRZWdJVs+tjGmlVgF8
 Cr5fT3eUd258MFH+UTEeCiA3PlmyApPoDKw0DTG5eSCFRciPM0n8DyuVt61ziVI1Vaz1
 Xc8aCw/GNufh/pxKYmFndMJKMTBsHp+TzkSsmk5BuPjtXb4KLnNyitlVSe7Stv5mHS3+
 IV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791466; x=1796396266;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K57Bd8yB2yiqMDDr08yUgZhrdZ4o1t0YlLEx3TTALvY=;
 b=e6rBR36fF17DStH0nKT/tRyEEI+X19fmz9TzD6AwML6FXm8wTIQbl3vFxiFv0iBVv7
 kyTpEbxAHdE5RCaJ/8KITmhlJxQyIpozh05YVOumRWGN12B7MEiCJqXaCzynvl9zbX+7
 JURUmZHuGZcv2JWy5kne5nUiWCjLVIQqbxi8uy/JpcghYQ5+xTBPZF59NzsqkHNcZTUf
 mifp502UZbpiUFQIvqNGxKZpEfn+0NowUrBEjeSA9ZVtiX/X8zsf8u1yonVaV0Yh6fpq
 BomfNJP1H14YLoS77zCVtGuA59vXyjZGD6b+S57pS0QOm4VVRSjEfz+RoOprLAk3PFGy
 hs1g==
X-Forwarded-Encrypted: i=1;
 AL+hErFYvcCvg+iPvrrdH5ldfANCy7qyz4OdydGWYS7A95j0A2nU5aJjZzIGRAQjvjdFJXLdtEFaJgE/0JcsSXRt@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9/miM5SCs5qGn/tLvO0DvAqfCIbQB7LUHU8nlmmPjqk+RIRtuF
 RRBGfAOa9smo0RAB8DRVAvhks+vIOdTWUI0CMcvDvp1QiugPwEhMkPpgirNuXhDab8XjzcaKS2L
 sONcspkRtxNlAtzilVVRYpKQot84Ah+Isi2YrJDQ4UzRBO3mL9MY37JW9/FtMPTndL/aW
X-Gm-Gg: AZFdTZewldf6NgdEcX3+BoyD4/tFgJVeWqTgiKp/tSyBGt76Xq0oCyyphChUysj/hkf
 UgLQ4uJGvfLC0q3ArdotfFBiZQ/aHi3X68UCdj0ursT+kwkgaaM23pAEwO8Qi6sUevMAI9vVXm9
 4fvScouXnzgru16nvZehM+n4WAukVazZlQSH+MaEUhy/w0Jt0W/p3WOCeaP6SlviFu2FEvgUiKl
 uKNKmmzmEM53Zyi3A0BUQ5dt5Ub4HuZTBYef3jUdG/q7RdQCfIdzDy2HCd5FiJ4BUpS1i1Dxmku
 jNEfFERnAXU9RcnV/E0D5rHGmlYDl9ZimtMFeYZVvZXmBfTs+/686aJk6PZrXImQhv5WIB4bsAE
 jGuM2gxr0/IkYHPbotXuaTslc1g3WQN/I96q87p8s99HSxsYB6flDMu3iYNMS3urWcDhTqtDQ9I
 HXZDg/s1z2svkRToydksi9IzYeREi0E8q1p6JhEIVPNFJ6RboPeoDO7J/wfQNr9dkWrbBHpc97O
 TEvuSRFzDbP0Abl2q8eEE8mezSS4jhAHjFWFbO6H0tZ7c53CpzFtDmPdLtOSyeGyR5pCUBfIovf
 BffpWH9S8Z87dGP5oiGtUca4fuSOlL00o8M70jMp1/vjnm8nq1DhJDFxsP7L7Rj/ateD3v6tySt
 JDHNJQwTYqCqscoRngpE2neXV4dhXaGZ3tw8GUXWZH9rmmqoSBAl398raywTR5Z+V/LfvkcU80d
 /mwUJG1u79GJ63BTw=
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb887fc396mr506845345e9.3.1795791464457; 
 Fri, 27 Nov 2026 06:57:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm684929495e9.1.2026.11.27.06.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:57:44 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:57:42 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 02e1598c759109ca5a6c7176aeb6bf03ecbf0cb3
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:57:42 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cfe286d086805336a0d2242d5f9321ff02ad1872-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxOa-000000006fO-0hY2
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8374502887446602622=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8374502887446602622==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0LGGoVJ0100="; charset=UTF-8

--0LGGoVJ0100=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Antonio Quartulli has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail )

Cha=
nge subject: dco: detect local kernel capabilities through netlink policies=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4:

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1981/comment/801afe61_6f8d8492?usp=3Demail :
PS4, Line 24: The query nee=
ds uapi headers from 5=2E10 or later=2E Built against older
why 5=2E10 and =
not 5=2E8?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1981?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051e=
ffe7f0636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-Patch=
Set: 4
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf=
 Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: F=
ri, 27 Nov 2026 14:57:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o

--0LGGoVJ0100=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1981/comment/801afe61_6f8d8492?usp=3Demail">Patch Set #4=
, Line 24:</a> <code style=3D"font-family:monospace,monospace">The query ne=
eds uapi headers from 5=2E10 or later=2E Built against older</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">why=
 5=2E10 and not 5=2E8?</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">change 1981</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I005=
1effe7f0636e30557d9ce92c50c458002f9e6 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1981 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregor=
i &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gianmarco=
 De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:57:42 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>

</body></html>
--0LGGoVJ0100=--


--===============8374502887446602622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8374502887446602622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8374502887446602622==--

