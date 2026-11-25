Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C7E606A329
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fhwr+zNN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gPK+yjQW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ihV2RfSM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Pk6r7Doy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W45LP8d6bq5Va1jSJJ5211MLo6F6x1oRlTrZy9Hi2Zs=; b=Fhwr+zNNoXADVUjT7w33pyo9J2
	vtYcNsG5NEJ/8T/sI26T8MFjfswHaLNrD3094ovnUzS5WyVpj0KGcTvhktrnMquWo/xRuHUxo3pft
	4jDAUhKVvonVmyFos9BcsUzRVQScDCogmhRgWmvjvxAcd+uoOOk1cTmYia7Q/aIsudDE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFtw-000000003Rc-14xA;
	Wed, 25 Nov 2026 16:31:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFtu-000000003Qs-2WQm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYV3TaK9ziw6IIacwhr0SeNHEuTOeMJD2Lu1/9BgUPQ=; b=gPK+yjQWXpw53kzbl1oXo7EFyT
 VBJwnz7100aixjX2w6hhUTR/vZfCuitiwvwi/kD0Ii1GfBVyHKALpCx4AzhaTAJsYpz8s5Xsz4Pzg
 1ad4wOPxG43+7en/E/3jmnid1MnTdO5V8Orubalj96KtsFE6/rZInGUEU3jK6S/p1r0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYV3TaK9ziw6IIacwhr0SeNHEuTOeMJD2Lu1/9BgUPQ=; b=ihV2RfSMC9cMVLlI6OA1YjzCOC
 WP4qEg+rutwycPFT0RgIi2vBOGu9ms+lQKU4hlKIHNJOE37PBlngDq1NxFxXJGnQ7xlZ3s3v5/7Ei
 i5d1wmzpIYLC3YgKZaymTDOSt3dkFhxy9oU73ybTSA68pTY/sx6IGoVBPj++HkF2JDFc=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFtU-0000000072Q-0PMe for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:30:54 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso43062455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795624245; x=1796229045; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tYV3TaK9ziw6IIacwhr0SeNHEuTOeMJD2Lu1/9BgUPQ=;
 b=Pk6r7Doy9VInYdQUs0Lg5gEWnDkZDB8Kn4EkpAeVlBcyWhun58pjvt0wByQ9w2i3Qd
 9EgCqfPfXR7jzsNhSbrRrx0uVgnfQfyL0dW0UkzCtaKpG8GBbi3q3y5NCugTJz1BS2Zp
 VnHzeEnS43Uw8UstTGFHGWnXw71KfFtr0Q63jEFNKAuP7CWo6gcDtjakH9CH/Y7S7F1D
 z+/6EEKEZpdkWjzeyfB9eb9/rGAxZyuqRWvo3FUWg0Q6gGyvmSpwSTuQXf+IrFgRd2an
 Yo26IfRpp92Fw4miVGQqllmv/BNvHIRg/OHIISU9YhFdBQm3RocXP/n47UrA3jaEc0J6
 N0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624245; x=1796229045;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tYV3TaK9ziw6IIacwhr0SeNHEuTOeMJD2Lu1/9BgUPQ=;
 b=y5IKc1Dpg/Ybe4Va0QWqwYiYEzzVzR9FGdIcxLpd8Hr07S7Z+7AYnh5mpisve/8zXT
 E4nD9IahyHmmTRTd8CoXP0YDDlthkqI13t7ibv0ssweCOPBMv0NB/M/5ECk6BsUlLDMq
 ZwAKYfsY66t8eY39dKca+u2Z97g98Ik9QKAE9z+ZsL0MYoNNmExkjBwzXYwk1g36XSfd
 RrD9g09bBq2WD3GJt5igUtZUZiYdEGULyc3aUYvhLIFl9svHCM2HVi9N7dNzew6sQgGY
 v2x+J2CB4lWY0/EelM9LFYcMMhCe6ppOKv7krV5RsR17wmEqpoq+XX0H7RV+0Xjx30HA
 uGYA==
X-Forwarded-Encrypted: i=1;
 AL+hErHDf/2f7UQcq8eV5Z3/aBJxR1ts6ca1Ea4pgUxDuNPpp8ijcLSOMGD2fWD7L2rCc4PeedxYvJvUlnMwON4z@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/rYgSrP4Sa49qMhmYPiig9KtZ2n14a6JQrh9Kwrtp3/QwAv33E
 U/8/+hkjo45g7RXtvM8ii60A/JgnlpaCjb5Bgv/dy4hNhr2Tb+0qc6vVk3+dMGK6MrP50+mpRzr
 49Zbe+1ool6HDPynAH9cZBNeCREL1yZEDAtfD5qHr4cqwQQC9L9zyNnvLb9RAY9YysUCLTmasV7
 lf6AweLQ==
X-Gm-Gg: AZFdTZctIEiSWLXw1sHAVOL2EAJBgVJBg8+2hzCeFHuOsvp/eynu0yuLS6ZVdIGtsOu
 fYJgb3YFHXvjEw85mMjWT2GRkSOcytKixt6OmR0Fq+52Y2PS4MCdDix/HxuqZYUvhDdoUCCNswN
 MgCkv8enlT56pDhYnBTsPBph9DwFkZVF430uz4YUlpWF+H+ySl9sxT03fP9+TY8hF7qDYt/Ezz/
 TqBV5S6dCMLZwX1/wuNoO7n79cNyiJdfKQ95qfiyDn9cn1Qf+kIjYUTqnTr19g5c6sk/khHvmeO
 Cg8ZfyCB3S7zT8VnSarfpsw3i8ypcOC2Qci/IixxeuKEFcURPTiSQbo96WXvo/1tX3er5MWB/ic
 nZPFsuSiTAeTuEteBgPeNdP+s828m1SmeSegZcsmcL0WadAWC04oA9OlwIeKFRPTygFWb3ztHAb
 0eBtRKHZrTD0WPN9exz0JfD08S7PP+qJcCCDKdLvDQwRvc0usW76UdMlZG/NpAarZvdOp+RX9sw
 ickuu7hGFxOZfoICZhqDS1GvXZU/Cr7MiZjS6z1ifA88dm4Xb/t4LizYz+822OOcZnLEp/QN8kD
 d3d2hZiaKoQXP+wGXAmoESVEz7pwBgRlO7kh8OFem8wgLx8huIxJhTt47LadnxTYDdKnCZ5Z1Ul
 S/L4BymvoTVBOa8n1jTwTkmbc8FWqp8D3WX7MdDFWhTQ1+fIKpImQZjSqgPYheJHd0asHQUFFjO
 srk8Fp7QSW2Driiag=
X-Received: by 2002:a05:600c:1115:b0:4bb:a602:6c8b with SMTP id
 5b1f17b1804b1-4bba60271damr38184365e9.14.1795624245278; 
 Wed, 25 Nov 2026 08:30:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm495758555e9.4.2026.11.25.08.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:30:44 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:30:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: b0f51c0b37e03b487dd6138c1d4781c2db138ea5
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 16:30:43 +0000
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a5f0e652e470256b81b9a66071875b2a93f57e4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWFtU-0000000072Q-0PMe
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: remove dead
 code
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6288692008946860707=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6288692008946860707==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SZTqJYw8o1M="; charset=UTF-8

--SZTqJYw8o1M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail )

Cha=
nge subject: push: remove dead code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/push=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344/comment/9b766f6b_7b877b=
5f?usp=3Demail :
PS1, Line 78: 
> Can we remove this blank line while we're=
 at it? It is very surprising that this has an `else if`
Done



-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f=
434141b2da32
Gerrit-Change-Number: 2344
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 25=
 Nov 2026 16:30:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--SZTqJYw8o1M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2344/comment/9b766f6b_7b877b5f?usp=3Demail">Pa=
tch Set #1, Line 78:</a> <code style=3D"font-family:monospace,monospace"></=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Can we remove this blank line while we&#39;re at it? I=
t is very surprising that this has an `else if`</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2344?usp=3Demail">change 2344</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f43414=
1b2da32 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2344 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 16:30:43 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>

</body></html>
--SZTqJYw8o1M=--


--===============6288692008946860707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6288692008946860707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6288692008946860707==--

