Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42396606B5E9
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b8WlXpAL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SmPAKMJX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dbYRfp2t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OHrcziQ+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rCI7Un37OUzFFlEISaxvysEuXqfD47JB8q8bfLjtIrA=; b=b8WlXpAL2WPW0enn4xZUf/3XnI
	GiuoCreKT00Pvos4kMOg5T4kzawxahcW8K+LLAi+DcPUUeY25WJqCOwIw4U9+8w60zP4bpb7bEKPP
	84lC20TqeX9zAxRKJ0nlgqL11XhKX1wp3QfdJTEdPH7JycTn93/ZUMav/oAYB/v5gKN0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjRk-000000001wI-38Qk;
	Wed, 18 Nov 2026 17:27:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjRj-000000001w8-2WvW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tvw0B/tgzNibrtJwsYQi39n0KNRetZPl6V+vSAxNjsw=; b=SmPAKMJXQnr3S8VHNcxjhS+uqe
 haKriiy33mzOLs13GwDT7qpW6mapaPyFqjGEJ1evkTwQx3Nmm/GuCfN8umcMOAwgcuDtqnOcTpOAb
 CZl8ilSytzq7nkuT9T6jtMFRLy791uti+ZLQhzRB2u6+ocR938mQ1k9VD7+UyrRuxpv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tvw0B/tgzNibrtJwsYQi39n0KNRetZPl6V+vSAxNjsw=; b=dbYRfp2tYpNgyCBkmnV9HgucvI
 x/pShd6UY21LtjfvWFRf08XVbGgSjirIu6mMqxwhJ8tGLYOdjJMgMVUW4BkTFxlcMIrN1MpwZBn3/
 EkO+ibGhfzb9NqpbsTZEi9Th95P07f0y18N7akRhcpo4zgstby/L/FCivld5Ed3CmwMc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjRi-000000007KK-01go for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:27:47 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso821794f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795022859; x=1795627659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tvw0B/tgzNibrtJwsYQi39n0KNRetZPl6V+vSAxNjsw=;
 b=OHrcziQ+8MUYnc0WGj5wuvSv6PbxMUl08bIT/vO1xBzvxSqchZky2hgJQ3XEhLNaDi
 p5zZBTYKixfKoxDKqM7jFfZQo7/+ul1EkAX2Z5MopSstQkDv0uc9fwiDJ5NNfKd4HhSu
 A9h5LaNnd55SUDadKm0DbQqxvBeEWKhcABLCDENh+9fkxa+7IyOjON3nlJLX6vqEvJ1h
 5PYWyDzfeuYnJEyY9SszqwKfwYE6ID6Yqge2LQksXdntxe2A9sYpMmuOrMiXsev56ySw
 3hPgBrDUEP6PoWf+EbgUYgnv3RmSP3oGIyyeSsYMIlegCLLW5MAk/Cm/C6IE6zGOPWp0
 EaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022859; x=1795627659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tvw0B/tgzNibrtJwsYQi39n0KNRetZPl6V+vSAxNjsw=;
 b=ZQQcH07MaSQqzV//L2y97Ck5hXSnpVmxhG/SUglNwQYkUruFQ6U6O7+N88p0TLBW5J
 8l6ZZX5xLsV1rKvdMv4jUVlRapn5lj8ezI6sZAAAmL+E9wDDNFD5IPv6u3qN733e8dAy
 LYAIaE5nNYqPH74/+zABRqpFmeoqWcyOzHp+fmLumC7thzkFVTnxygLwDz18rZQuCzP9
 6fhxaTsh/90A5HLAR8xyfcgTyAyjr4hCHTVjfawhKujQV/sfbIsvB9+Lop/w/E5WLJZb
 x39/55mODsVNH73mwfGx3RtZqYt3I5ajRrByDpe/TZvMszyCaLWbHM7SmyVZAqfSIio6
 a0CA==
X-Forwarded-Encrypted: i=1;
 AL+hErE48OheHl+uuaYoBAPobyqQaK0rxU82J094IPX6Hwgm0+hkpghKEzqI4JvnWryhWzs+DVfDpk156pnT2Bwr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+sdrxph1yMbnCbKgPmslACfZdKXSjeQ6Xj03JLQHRbhVmpIFgl
 Nxs5QmkRrWpxRbzVnedWAY8oiDpH2g8wSkSPJzm5BPdQrG4GqYJ1Nju+xg8BsVHaSXIzWXyw/r9
 eZIyJpjuL6zEMIM7BE3fRHuFoUsufKT72ZgZRXowNqkXyBdejnxJpNQFLLI8B4mV4sFmEEXzoF6
 DLYbKYEg==
X-Gm-Gg: AZFdTZdObSswMM+HkVzb4MHKdzuTTAg4tRbCsoH/Hyd4n4TYcdcPkGC3d0eInPat5Ut
 cD3GvpMwNBQzwEHZF7THqTfWgNLoIcU6tJAA+8dRqFDrbgiprwDJjiWD9zME8GMvwsS73mEoYG+
 CEiW996FMGuvRHDKNKRIB6xbR5ELfXa79GG/G4nANfxZUEzQ2jBcVpMlGiS88S3dbaSFjKNK7Sd
 VyRWJwN+AXxx/5cZugVin2+magU8WKCxlB+phxeM753Fcd1Cb3Q5vjEv948G4cwdwrkAhlRy843
 zpTENwRkTHqinsT9CMc9FjRep7ezIIKCc+v49NxMeUqol/R+RKQ6V5McjnX73JqW65n2Vlk8+R1
 YoSt+Nocw6xOrf0b6d3gS4e1pVNbnXFnv24W/z2VIctVyO0mbppHX/BTa3CKgeiajb2W1pEwy/A
 bZHMvgaLfPKiei6KHrERz7Fbq7rGR9b5/fuxi4RTN1zNcqjNGjuP4fToQf8V1Iuk4ZIYcHVu7ez
 a0t9+/R++Z3QSxutj9YRZbNb8fZoI055mkDrUUivxtyNHv/tOWtUV331j9CGiZQhiTj16tU8C7t
 yWfszrhbjsTSF0+yezNR4CdplGnDnSm3s3b5DFPZVJA4IJcGfV1FBWF2H5/pQQyeAd4KAHLTBDG
 AEDtefuQrbnE724nXhztZi8ld6doJOBwyCfBrRs/dIv/zhV42ZWosjCnIJ7FIZLqfSFBmbVqfrw
 LBNfofbCKx7BXsI1g=
X-Received: by 2002:a05:6000:4812:b0:49d:1ce3:1849 with SMTP id
 ffacd0b85a97d-4a63b9d99e3mr6946618f8f.21.1795022859222; 
 Wed, 18 Nov 2026 09:27:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6570dcdddsm5603228f8f.54.2026.11.18.09.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:27:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:27:37 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: 3c042b1a83e5b23c394dec93018c80b9fcceea52
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 17:27:37 +0000
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9943939f98014b86d8fb648cb6ef8c90bfa5949f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjRi-000000007KK-01go
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: raise the
 open files limit for --max-clients
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5555571061165154794=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5555571061165154794==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nobAED0T8xo="; charset=UTF-8

--nobAED0T8xo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Gert Doering has posted comments on this change by Gianmarco De Gregori=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail )

Change=
 subject: multi: raise the open files limit for --max-clients
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I17fafbe65fd3ff=
510a72ed809c85b0d19343fad2
Gerrit-Change-Number: 2211
Gerrit-PatchSet: 3
Ge=
rrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Wed, 18 Nov 2026 17:27:37 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--nobAED0T8xo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gianmarco De Gregori=2E</p><p>P=
atch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=
=3Demail">change 2211</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2211?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2211 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: G=
ianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 17:27:37 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nobAED0T8xo=--


--===============5555571061165154794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5555571061165154794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5555571061165154794==--

