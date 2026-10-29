Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904A606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=czEwWasY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ak3jHyPR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bNY+HTTh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DqllpMlJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TT3KC32V99d9UsKRGfo42KN8OSjVHRkeJ1OhQvXUTX4=; b=czEwWasYdBunzg1dWF3v34TIgt
	O5PtWBm1Qq5em3eN14WesdzuThZgUEXD3i44ZBOVbeG9CfoALHhZ70tSTvq4n+rGW5uciGVKLDBBD
	LA00szjJJHFptn2MtCSC4ALXWvA2ObvUAHuUNZhD75sdfVKPK5AT1fEDGuwnXxTRMxnQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMLbX-000000007C7-3KgH;
	Thu, 29 Oct 2026 08:35:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMLbW-000000007BW-0KVF
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 08:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5bNd0d+tzM7VlmuSCeT2JHj8oVFgyonLazOEDtlBXw=; b=ak3jHyPRnXKZetcgvNQgj+Vefc
 m9DeSRDspsu0UT+E761N0gd9lmjj57ObJ2CEOgPUyuIzxVAZEir9bHQfN1JLNdjoLS0IwSeUsddEd
 eLYDbt8/w6/8vbxHDgH9lLlhgjtaI7XUrT9hBO0BloMF4C/FeC7VAJWQhuOqhN1ljiEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5bNd0d+tzM7VlmuSCeT2JHj8oVFgyonLazOEDtlBXw=; b=bNY+HTTh662aJ1bna8EhYMrbEQ
 lcQ2J81m8B3CBDuRjkeUMts5nin6RVzH1sMTffAz3fpJvtuyMflZ8PiuiUQBoz/a3RpDLrqF85z+m
 LfvVCPKCTN59hKvQgfSX5q6eDrXMr/X4VmgmGx6Sp5EuikD7ysXbr0iy13fxhKQEZIf8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMLbU-000000002eg-09k2 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 08:35:22 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a7992e2f7dso16028335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793262913; x=1793867713; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p5bNd0d+tzM7VlmuSCeT2JHj8oVFgyonLazOEDtlBXw=;
 b=DqllpMlJ8XKYjE3TlKwpD/6OSvX6XSocL4qL9sSZvIK2LCNvuyZQb72ijTUOQfQh7y
 SFPLdpzSgguG0BaT64RNpfBbWxHJUvthc5WDohacOuXx68OWAdw4wZ68aibxIqJqqLD9
 QzClNz9eFfKAl1LfU1ViVgz+V+5sMMWTufV1zZKlnhQlVhC+TeArerkeSwfouZHkZ1OR
 u3wYYaVqB4E7JbuzSWPXYfXQVdmF9fXz3KAg1klyv6jZqkNw8NGyDTU802ovF2PaI2If
 L4O73rertUNJphTtW9TDIlp+cmM+EIm20x9R39OlfPDleYO01dFjycQvzThoUX9orSwi
 P0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793262913; x=1793867713;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p5bNd0d+tzM7VlmuSCeT2JHj8oVFgyonLazOEDtlBXw=;
 b=UeBoObH1wBT9XW2H8Ja73W5QailqYM3tDzFnaYaY8arr/40QO+tCwOQ7BruEqvHrv8
 gPdhXGdKrhJiPM/RaKicnQQdmgsZZ0q2hbRyZyFGKHPTFZOhXa5Cglr5FRJAZNrIfukE
 gHO+dEuo+9gZi+kBynCOzN3uEaqHDlz6HRRVeZ/LokUk7Lq0iO7/vYPLVHQtLPTRnl5i
 bkRg2P3ZZi6AIODq455rVT1E4LVloWE9NXjxYjOGPnJOwxwMlxQpDhtqZCfrACpnNW3y
 8NZM9TUf1UXttbZ0qaGVI9g3UTMsRCmdn/iOC23xhnFcbqtgwpcc3sMTvKLkB+E0OMHs
 xmmA==
X-Gm-Message-State: AFq9FYI0Msrn+wrHzilMe6mOM9TrWvcnUSz8js1K162rsvwZezfQWmAj
 zrFZNUtCYDj0wHVjkD6uV6Xaocmuaf4OF+q1UyLtnyZDiB2rzQ7xmucw0RacHTZ+yUaCfbdYNqT
 cfPefngH+QlCpYQZoJ+YupCV2zSoV6jtoj5Wd81qvgwwpRFnuMOAZgdGysjV4S2/MnzDz
X-Gm-Gg: AYBFou3GDFTO8FQ6PM3FyxQjQ7bxsElli3e5Dkber53AQ9AlH2zm2+NoxDlybLbJGfr
 G5VhNwxuKv3kDAfr5DQ2c4L1FDqA4M8pM2PBo8zPqel981q7HtmAR6CFZIz/FbNzB6m+lZHd3zV
 3Xk92FBt4YRzUs2r2RZSgRUFGqB6oZwtTfb+N7HYuRZAS5bXeNxGF0DfI8ChH/ueEEHEJaVReRY
 oBSihDKiPWWd+Qnj9KIFT3WjkVlaeGTKZL5CKqwE8FiAtGK5TcE7+wFClyFrZT1R5BXzpL+kVZ6
 89UZGh40qMVkd6nOri76kDRWuaHfKKF4UI6hg/dsIAh1qS08Wc9hX5BuND0FqgAj/vj2KbvFzlN
 d5HTqBIjSueXW2bxnalvZPr8zSH2Z8NUMP1NYIf45mw+0wSGQLEPYC1omRCPhnp3z7N83J7ZvZM
 LZ5O8uvu0nTtQbEF1QHMxivJKIbtfidSfujJQD2/VOhdze96SwhhDjuO7x6rnRpjiph1AZmQPPH
 bcvK1FYlUINi0jLBv91eQEKspnCzRKSpV4dkxi9PaDps1eKVb2etOiwqDhXR4mfa2zNryKZKVN5
 qcR0QExd2JnEm4Ooz555tkD1d0FYFMiznCMP0BPTCv+tZn6kEaIcfQnjJ7EIdaCLOGoRwoBxp9e
 h/9DVtgaH0eKZPHvETOHm9qvQrI/8FhXmeHjHokiji4uegVREkaNrVQ4tJJtcCIt+sD2VtvQXfp
 hyo3GzCWh6IyR0Ndg=
X-Received: by 2002:a05:600c:8b05:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a965ec95ebmr103165715e9.9.1793262913291; 
 Thu, 29 Oct 2026 01:35:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm67954025e9.4.2026.10.29.01.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 01:35:12 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 08:35:11 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: 8841b1dbf2dc7ca506222cbd8f8bb9266cc26a97
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 08:35:11 +0000
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec42f2b6a3f9f5febc49d6e43d38828e6ab762cf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMLbU-000000002eg-09k2
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6535210889601539096=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6535210889601539096==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fOtXn7nPIJ4="; charset=UTF-8

--fOtXn7nPIJ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2067?usp=3Demail )

Change subject: Do not hash re=
al addresses of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(3 comments)

Patchset:

P=
S1: 
`management_check_bytecount_server()` and the `PACKET_TRUNCATION_CHECK=
` status block still use `{multi, m}->hash`=2E


Is that intended?


Commit=
 Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067/comment/81ca1a9b=
_e7f1a10e?usp=3Demail :
PS1, Line 9: With neither status report nor max-cli=
ent depending on TCP
max-clients


File src/openvpn/multi=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2067/comment/2df23367_b69b028a?usp=3Demail =
:
PS1, Line 2485:  */
Should this comment be changed to say that this now o=
nly applies to UDP?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2067?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: If8ae9cbc971f60800a998abf2f97da0384c023f3
Gerrit-Change-Number: 2067
Ger=
rit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 29 Oct 2026 0=
8:35:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fOtXn7nPIJ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?tab=3D=
comments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">`management_check_byteco=
unt_server()` and the `PACKET_TRUNCATION_CHECK` status block still use `{mu=
lti, m}-&gt;hash`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;"><br>Is that intended?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2067/comment/81ca1a9b_e7f1a10e?usp=3Demail">Patch Set #1, Line 9:</a> <=
code style=3D"font-family:monospace,monospace">With neither status report n=
or max-client depending on TCP</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">max-clients</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2067/comment/2df23367_b69b028a?usp=3Demail">Patch Set #=
1, Line 2485:</a> <code style=3D"font-family:monospace,monospace"> */</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Should this comment be changed to say that this now only applies to U=
DP?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2067?usp=3Demail">change 2067</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: If8ae9cbc971f60800a998=
abf2f97da0384c023f3 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 29 Oct 2026 08:35:11 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--fOtXn7nPIJ4=--


--===============6535210889601539096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6535210889601539096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6535210889601539096==--

