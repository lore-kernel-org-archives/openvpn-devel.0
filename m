Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A8606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hx+r0wUX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kjk5o2a9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OeyC4t0I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NsDwg13o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zGQG+d+7fnORkYXdCl0F0oL8f/YxRiziGGgpCi6oTGk=; b=hx+r0wUXncL7/1RxQegsBKmbjg
	kcB2GKEvcEh5d7xt3OB+n869lkS56RByiMHJki1A0N4IqrzIz6xmlhPaBRC0lEcsRWjk6+mQrf3ii
	ks6rt8hs+Kh40BjI5TrE+FEFJsOO5dQ1IeOnmQXbywHzO22eVpWbJEQMwTBtVX7jrYvE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMfN-000000005lI-3BsE;
	Tue, 17 Nov 2026 17:08:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMf6-000000005ky-01Ny
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gM7UFKdGItNAfpyt49BHi9jL/O2BT9wr4As3f9iN5rg=; b=kjk5o2a9Swh9MSFlLudGl4dlOS
 y9g9Imp9AKHNWLtl1ZadUlml/dbKbWNLrXBp89y17X0MBKMZAxP2+/RpglHjT2bIFYVTJOr93yzKK
 XdwPcndUZNfvPPoC5EZdjQihLQMuIM4isir+PEp1C4iTEnz3ri81Dac2NWtT4rZIzdZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gM7UFKdGItNAfpyt49BHi9jL/O2BT9wr4As3f9iN5rg=; b=OeyC4t0IDk0aPUkYvUvof88g3Y
 ZynZbnY7cjCB7ZlFGkUhWxsVXUs0j6lCuloMQnJuxReU1eicNu5dR+5fCCBECYRDW3xyxMalylweq
 VORk8fHdaXhpvtuG9ULc5iJv0f7j1ZIfOHTidK5ZbwbpBEb6OMl/TRM86FWeIG2gmymA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMf2-000000007pA-46zC for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:08:02 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4919a880834so2639048f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794935274; x=1795540074; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gM7UFKdGItNAfpyt49BHi9jL/O2BT9wr4As3f9iN5rg=;
 b=NsDwg13oRI9KI6WyAHk9/JADHCNJW25iXCqN2Y9ZVJzXFEd8YiFapi7o0mShdK9MI+
 HuavpjA+ud2TjsaajWHUPaHMP9CxoEVM302n7Yiow7695Zd6ZxH5mybajOtAJ9hg9b0C
 ddCasQJ52xKnnZME/vy1VAbjZzHGQAvzFtKL6zHv4Zi3ZLXmUC/yfkyjeThZcHiDxpnE
 MBcBSn+0CO7uFKs+/PxJ7BNqmWpiKyJ8vJgbfo+NDbVg6npyfuPEepJz1Od73Us/6dWw
 ouDp6AJ/1z8u3fc+9mbGTQysD4HMfOWUQcZn3H6y74WVHx698sk03oA2t8LOVwqKWVD9
 GHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935274; x=1795540074;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gM7UFKdGItNAfpyt49BHi9jL/O2BT9wr4As3f9iN5rg=;
 b=TvwfKuISuuCthgvxCWV8cbWcnfo1eEoxgttO4z0VMyFlfYbyeROp7AZOKjxrLxd/dY
 opELyrIKfUQaDYr63k6vlHSPwSzWJoamDbWxX7iiCJz66xDxFIEs+BelOYAn3okza2ty
 C0NJTBqa98CC1JjnitkCn9QVIx3l95x034TcsEMiNqwceIo2IzU4iaKkVdxTCcVdE4ym
 fW9sfCcIvpOX4LM97gBG/54V1gJCbEmjqBtSG682yUL371pR6beLXGb1tRCO9+Gt5STx
 hqdmvoOUUpEAfFc5a+r6pwnQ22IavAV27F2Ti3EEfJ8pfIYBKFGHa2dbofCjeRqi0est
 H82g==
X-Forwarded-Encrypted: i=1;
 AL+hErGENtH5k1eU2LzJFz/4OAtpCWq9p/27eu6RMwk0wi6XdmaTjR4HVdNcH+dMih7ZPHsaQ7qqZp2xdgeGPmB4@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/TBzBhaor9phs/+qwPBkL5w61kB4/y40T6JQINdn4paOS2WCyf
 8XH4VYAeXqncle8QXdztlvcBcGfUw9xWlryOHoK7oTTZbHEj5cuOIplm0feBl1KF+Ip2ki6s8Sn
 V0j+JKsKHqj9LTn0h6G+xU6AhSt/5bWpFDcIJ+Xyr+vtFcQi+twKXhjBVC4WYKWIXY6SP
X-Gm-Gg: AZFdTZcR4QuN+zW6V4Lu4gqMnsnoVR05mGHFlFDN4Fh77GxQ0ey92SV5Aa+idbHsBn+
 Dv/UYrY7NmRvCcE6pUlU1+0w1LqUC73L1jSaYi5x5iinl7BFX46I61lg9fcPb1AWURwFNd2AOy5
 /N3jWIt9QyeFy3Oq6jt9+VtuMPIiAu44B7DTmxI7ZUNg3OaBCcQRyQgey5DcXwq+sqtqp4hjlGS
 ZpFfTL370pNEVsvJyc3bzTnVkahetKZWj8ihnGRDxlRDPDCHbqtUmnpucnazY65be/kS1E7crQZ
 Ok5juewPUXPG7XrvRGey3mfYcVv4ImQUnHrPCaV0OCih2aifMYSIysx0HlkRKgbxn40/bt9sC9v
 59PskHEJW21fKqgCP4yGWqZQhnAkgwRSf8auqPtZFWB/svWJL2JICHjTmgSOGiW09Byg7e9NPyh
 xdpp+mzf19F/sdi+7f8Yk5/WvBIYhSfZ5ZsSXXRjD0ec8cDLwsLCrBOiscuf9D6PQMrR7yqSr5u
 UViOB9xHeCqJsx1BGk9c0LiS3uZKIyuX/t5p+PmaqDK66HX0nR6z+Lwm1oN4R3pStLjXpK0tviN
 b6xM8WN6MSvBL65RijzNE/03vg2gusc7yA/aCsjrcUdVnKSIc7hQenpyJucIRhJwlyMC3muWJlk
 a6BZwGPr+g+hxo8g+27nolTyd33T8LYiWMEtwerT2Wdh/wEvYp4hMwwZ0kE8f99GZPyUGSQb1Ja
 rSnLv/riZjSteyCZSWhm6X+94eWGrfEBfDddsq
X-Received: by 2002:a05:6000:1619:b0:48c:72fc:363e with SMTP id
 ffacd0b85a97d-4a63eac5b33mr53843f8f.44.1794935274012; 
 Tue, 17 Nov 2026 09:07:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm27307137f8f.29.2026.11.17.09.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:07:53 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:07:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: cfc1a78e40e0a11ab2ef03577f4bb3aabafaf2cb
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 17:07:52 +0000
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3645d219c84514917d96e8e807aface923bba0e2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTMf2-000000007pA-46zC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: fix
 -Wsign-conversion in tls_ctx_set_tls_groups()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7209062197592934875=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7209062197592934875==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mKsmDhLN+AA="; charset=UTF-8

--mKsmDhLN+AA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail )

Cha=
nge subject: ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review-1

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2214/comment/5a0bc23d_0543703a?usp=3Demail :
PS1, Line 9=
: Since 7d46ff17 dropped the -Wsign-conversion pragma, LibreSSL and
Please =
add a comment why the buildbot LibreSSL builds did not fail=2E



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I33123fe621512376410765031fc9=
ae68cdd91a6c
Gerrit-Change-Number: 2214
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Tue, 17 Nov 2026 17:07:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--mKsmDhLN+AA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2214/comment/5a0bc23d_0543703a?usp=3Demail">Patch Set =
#1, Line 9:</a> <code style=3D"font-family:monospace,monospace">Since 7d46f=
f17 dropped the -Wsign-conversion pragma, LibreSSL and</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Please =
add a comment why the buildbot LibreSSL builds did not fail=2E</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2214?usp=3Demail">change 2214</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2214?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91=
a6c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2214 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 17:07:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--mKsmDhLN+AA=--


--===============7209062197592934875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7209062197592934875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7209062197592934875==--

