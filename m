Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E1606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WMbSgpwG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m5+q3da/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gW3huB/+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YxKkjdM6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CTHOXbyQsvfGQwXKeczDtr9lw33Vc5sweyn84hEzOd4=; b=WMbSgpwGo96GGJs8j6BuV4AmAN
	zJN/Wbk1SA8ZYAj/PqBorWQri1YfYjZQbl5IF5tUaNa5a/3uLIAdCeuFDUSAI0/2vs+v/CaQHC8Td
	UQHDwVDxEtHnVKFwCH4a+WzHULMhFuc1s34d4RoIkdGM26wgLNaoQ4wJjqWpIXNSD9oc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQKr7-000000003gb-4BuH;
	Mon, 09 Nov 2026 08:35:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQKr6-000000003gG-0cgx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mri61huoIMqNHJ0lEfG0IYcTj+sBvwgFqzsMqHlPyrQ=; b=m5+q3da/Y7NNVHLDBce3WsvtX3
 UMu/dAbr2QsSllZfevS+Pm0ZLCC87Nq7wG/yciCtoncLn60Y4FJSM/fys+v1txeqchU4c3hpYRJq9
 X+gwnHFjRVhDycRehr5s7nO2ywNtvbDYjIDpU551l21ZxzP1U47XcpcCBT0y7ebuRASY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mri61huoIMqNHJ0lEfG0IYcTj+sBvwgFqzsMqHlPyrQ=; b=gW3huB/+cSSWTfs3jQYZ6yocpD
 DkV7dXli3e/7HF7EF7AJBvvK9tWGptaqEChQRpN8eef+P3Kwx83S8Bff+SjtTx+Exo4vuiFlsoZG9
 RqrJ0yIh1cFnDCtTaE63bJjVp7IBIjmILEM4cEZPVrj/5Plg2A/4pdm1nMZfltFk/FSE=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQKr4-00000000847-1veN for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:56 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so340263f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 00:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794213348; x=1794818148; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mri61huoIMqNHJ0lEfG0IYcTj+sBvwgFqzsMqHlPyrQ=;
 b=YxKkjdM6naQ+Htm4aY9gKHEsFLi9Yb1j1Xv5rO48gG6x4oY45Ba2EkPePR7T6YUthp
 mwqISVImVZiyEZuApdObvcLowCfcELGfbc5fA5J3jYVpc/W4LSHTlPFB8KETzqa9Ug1O
 KX7nNrfhfsQRkn20m5TxIi/w8xKlkGIBCYayUJcYMXMKmEe0yeIHcEw9i8Jl96q+2kmQ
 3R30klizykxnZmx6TT1OT988m0u6a8aDrYCdaqiW7I5tqfNo1tNN+YdU2BW29W7zx7D/
 lGdd81oUrjcptrDLC5jWM2bi9XPzSbIWURK1P0Axz3zD0y7m3m7MSF1vVneCgQD7cKKx
 zLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213348; x=1794818148;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mri61huoIMqNHJ0lEfG0IYcTj+sBvwgFqzsMqHlPyrQ=;
 b=Hg4UmxTBIm8FnT+9evFcvGZwP+IDy0Z7IxsYlEQOTWwC1hIOdCuhakeaPLKrXLlAEh
 6WwnCUy9NSSVfh9cC5czLsJ+ivJlGXT6HkOjBrXLruZJCvNrX57AzkhwnEUkwOG3EFY8
 IIVkXNI6+X45M9F415P+k2DsZ6Hg88+IlLZMfOtxBDrWxZNlfYYvRphXstK4FpgyTZw3
 NTrosgFKfO2NvBUEaMZTou8DUzbHgS+7jjaqmjTsIXFIXj8CSfBHMFEVx3tIjWUSsaQy
 DINn9IqmRWZlENU/LSC0NSiidlmIddOCWFLLT0BI79xD2w4uUWdIpCofzEXTKf3Fk65z
 lEMA==
X-Forwarded-Encrypted: i=1;
 AL+hErGlvE+ux8lPlHB8TwUHJirYodbctCuXG9p0a1IsWhPGYWySh7HDOqsZVw3ohe0pN9lsbPjkw41v2FVo1JLo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9z634fRKFYxCIB5M9ZrezJJPvJ+V9uyOKnfrPVYUm51f+pTJNw
 zb6awtQdrfOi8+ZhI+hXai/meZEfi4+YNQm1GFZkdLM/ueueMWey+rV5vj3O0qi72jvLmEWmpWb
 fXNMhUpv1hKdJlPIOp+BJUP002rFedqA/rEUL01NYYoPQVIXfAnnrKZm6KmWqRNXqSC34
X-Gm-Gg: AYBFou2A1e8kOdD7ueqWwfdEbqHYjNLd1ig8B6Dm7zdP7IRNx0O1Wb4PUIq/TA58qls
 NQCB+VA3ucdmjcbtxvCzQb6rEtdWj4ei4LDNJ1YWx/1a6SRKBEY2MUVIk7FtBrkrrVgh8ONlKD2
 xf86BdsTYguX8QmwyLxoYvUEp7wevkRT+y7eMSq5IEltHYmtzilJbs9m127eOGZJh+/PY+UU4uo
 ZJjzdp4IfvFuQKlHqhP39O7E3OiodFnlXJ52ys1cHpOaRb2bz6wXAouSNLxo12FeMLEY1zNZpM/
 hQ4BrCTBjPJ/QNp2S4AVyY6unLVNcGfrlOoC/QdYkC0Dk29k+k6P1dKLsmR5ZAjTuSI9GfFmqRH
 H8tjiGlqnjRQVBUyjUpDLGqFBlQUEfliCwdjWtq00SyVHRI99K7hUs7ZV1lxSCOffYcJhT4pheW
 Eco9Vh2KHBPFewi2KX+ncHLBrkwwvqJ/xGmnLWGyNkHrWfI0LeJvX6BxUzBbi/hKvCAv7zr0nfZ
 0Iez+DqODNTq+uDuhF34wh8KW7o9a/58TLJpvR0MT2eOKYMXXS4HY29D6rlyv7AmXZWGCTyzMSm
 SBEs2MvI0Y3l7yQHa7dxx8r1mhwbpwSXrWZX96uFa747dy5Z2DWnfyw5jdu6gPYjFsmOryw5zqW
 4gJmdSIZAp7Yn5qf1i4jr0iHNb2DvcOYkCNnv+qgrOiVHPHpxYdXp9gGoNUGAPzEnTnKG/EiYX2
 FWEzGfru/QrWtOzg==
X-Received: by 2002:a05:6000:188c:b0:48e:6f76:dea2 with SMTP id
 ffacd0b85a97d-495841c395fmr5852756f8f.38.1794213347482; 
 Mon, 09 Nov 2026 00:35:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f38e2bsm8897378f8f.8.2026.11.09.00.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:35:47 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 08:35:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 08:35:46 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b2fea2bb362e7483b7cc26ef2a4f3c65ec27178-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQKr4-00000000847-1veN
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
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7868139488921565598=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7868139488921565598==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PlAJ4rMPhC8="; charset=UTF-8

--PlAJ4rMPhC8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5:

(2 comments)

File src/openvpn/ssl=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1965/comment/3f7427c1_5d4b4b95?usp=3Demail :
PS3,=
 Line 2665:                 }
> Carrying this as extra special case that be=
haves different forever for no good reason other than com [=E2=80=A6]
ok, r=
emoved that=2E


File tests/unit_tests/openvpn/test_pkt=2Ec:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/86f423b2_b66fe100?usp=3Demail :
=
PS5, Line 661:  * early negotiation flags TLV, the bytes older versions wro=
te by hand, and the
> the bytes older versions wrote by hand [=E2=80=A6]
Th=
e older version is the one which existed before the refactoring=2E Moved to=
 the commit message=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
=
Gerrit-PatchSet: 5
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Mon, 09 Nov 2026 08:35:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No
Comment-In-Reply-To: Lev Stipakov <lstipakov@gmail=2Ecom>
Comment-In-Re=
ply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--PlAJ4rMPhC8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3D=
email">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/3f7427c1_5d4b4b95?usp=3Dem=
ail">Patch Set #3, Line 2665:</a> <code style=3D"font-family:monospace,mono=
space">                }</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Carrying this as extra speci=
al case that behaves different forever for no good reason other than com [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">ok, removed that=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/86f423b2_b66fe100?usp=3Demail">P=
atch Set #5, Line 661:</a> <code style=3D"font-family:monospace,monospace">=
 * early negotiation flags TLV, the bytes older versions wrote by hand, and=
 the</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">the bytes older versions wrote by hand [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">The older version is the one which existed before the=
 refactoring=2E Moved to the commit message=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail">change 1965</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 09 Nov 2026 08:35:46 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Lev Stip=
akov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--PlAJ4rMPhC8=--


--===============7868139488921565598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7868139488921565598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7868139488921565598==--

