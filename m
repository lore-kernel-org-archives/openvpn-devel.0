Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB002C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pm94rkDdzI4OYdGI0/VS8OgxNo521b9i11gnJHKBpVI=; b=OSbLLKShX9vLZbDss4zIonvVfy
	IK3yT/iZmST+AJb00mIWQLtt/v8HGuebW1AFmQfhKX9OlSRHq78RjYZN3YKMfGYLKoF9hH2dAnzUF
	jnUmoplBC8FarU/+NzXnZVBnnNfNJGXZAWJXZXR/BDclcaE4OXKdXOtnza9Fx5uP26f4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6WH4-00017P-IE;
	Tue, 15 Sep 2026 16:44:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6WH3-00017J-Nn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:44:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eSs8P3gUVNHEu0eKseNhmFrpWl0CuQaO4w/yybcZIf0=; b=MYjkR+6UrxkDS7zgQqQyXCmu1F
 vrOfmp1R1Trr4g0GTRmI39644x8zg0Ehj5be4U7fiIsD2Uc71jECfsoIbJqPvLuOu4ysG3nlr+UCw
 UPSK3rp4DzdCeFLnuBoLtdZIZqIiCgDKEVOH4Kn7GDzLFBvqoeV8mdb7Ujn2NpNOmh9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eSs8P3gUVNHEu0eKseNhmFrpWl0CuQaO4w/yybcZIf0=; b=m
 +OMfHaWyI8c7eC/MYMCR/BxgrZN0OREibEFWRER5q3J+9C8N6R49PxLW1dgSUT/D4L/5apB5W8zVy
 C5tIXsbsTprG8DIRGb3/L0+/KTnpZGuabEa4DaZioXJvRfZZdpKrGOxe33kjX7RFGrKwnpgGq0LGG
 G0WuzeBDvTDPmEqg=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6WH3-0001Bx-QT for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:44:50 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so1749355f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789490683; x=1790095483; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eSs8P3gUVNHEu0eKseNhmFrpWl0CuQaO4w/yybcZIf0=;
 b=bdazROkDluZ3pJ/wQOnNPHOVI1QtLDXhinkJYWEHduIXQtg1G6ctl6M6K7k/nEAONG
 Nr1UCGezChloLxOIWgbmjW7HxDdVHhT7GlHOxpPaTzZehS6anDDslJoIHhe19XZ/Cii+
 l7SzSyEk5erpePpW3BTo8FAn8TJXvoFK6RFgW2bua+6QK3VhkDaT76zisIaZf6mku/02
 JTOhXbhvwlvB6zBp9QCGvTVQ6z+84EfEU2SwcJP+XgWZxwfsBtB78dit9z0A6TXxqbwY
 u1PyAiimw3D5eKhHRPuZkvX5vcCIMdaILG7KPZocsSMxzp/fjCcQHJ0cDTCnOOcEr9cx
 aRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490683; x=1790095483;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eSs8P3gUVNHEu0eKseNhmFrpWl0CuQaO4w/yybcZIf0=;
 b=clfzbwmHICEf2hHZcPkxXpXt8Z2/qIOrwVjxm8JTlQUz7e9kF1Bo4yVoBZCy2HkZrd
 D88TE7f7cRZ4bve24ZXEQ4v43vyAXMSXqA6IsgmAgps+25eG2FrVQHmkpNsQoDJZfN/8
 +wFwxZ264p43HlrjIK10sSjfWfGc+yoS4AaJEFVk+tQPs2Y152VcoyobxUMVnudjZqYZ
 YTBQl6iov7LKdmYX+UivyDi51glzJyxr6hqzV5Qti0iMjDyp3W/mAOMyIG5So613nKdV
 OIfsddSSGFUf/c/JQm/kJvH6r7m6BPO2WqweB05bwiUkYB95dPOHGaKF7i10DTzw31GU
 qyLw==
X-Gm-Message-State: AFuF++klAFkfl58yUAyROYrd583vYthPFQV0AqGBonNHPwSAq+lhWnhi
 I7avc+5JcEj6QjtmkvTcsKoLfblla1QQuan9nkn/iaGjzgyovS2YT7XqxUcOjA+fHUtLQ8Aq5Ja
 AlYU1IkkYUJ6NGc5/YAnS3xe4V5zJVrfLWldl1g3JVdZ5/+SPVxEivKoYM4zJGKi7KnmSfBTjbd
 vuCo9MZg==
X-Gm-Gg: AYBFou2z4oHuWgqtKQ8CRBDfZ1lN0IdAXB9uvtWNPedy+eVRDj3nAGK5GAawNKexctL
 t5vOwGzpUa3muZVAZN4NPib4/0dAh/oiEtGzCczNQHI6R6kHeKC51TmisdwVJRUmqAveGHfbkTz
 kyv62SgVsILJlorD3XV/va/9bWYDoWpn4e9AcahElSuOpkTU2E0Z3m0pG0yRdiJRhQXg6caKWPu
 8LxnziBW4QAWGq3eDZmI1l/LlBp+3AWwdmvWgQJ+U/Z/ftnhd6lEqlZ1uFLzsOA1dNaZOcYmPPo
 2YKEBad0/GtibhwQ3PWpvj79rBGYgitjIlMWNeftV9vmqEExfIDNLVYWZQFGYn4vdoStXRokFqf
 JuRc0Gucjy0b0ulhfBbRouSb9cDf/bntWTG+7oWDsu57yoz3qBZtJ2to2ACARIz7DkZK3gIKTgH
 kh1qgzR9QqucJc/kshEm0KJE8PQxAhYmgWHlnhgO4xwii3pYLpjy5zX44KHSAGbO9PTnYDGPnie
 3MLGGQQeJtRVwtIQ9ke/phtjX9jlYoaclxZzsQ5AcdoxqnzHobyh63tjHa8QOoh5pJXCFyLJFoC
 qTMuGvzt0WKq2rr4O8zqM1honJCAiHbhtyQoboSMbKfOEZHFl67BQt46xGf2wQ==
X-Received: by 2002:a05:6000:2382:b0:485:9139:2733 with SMTP id
 ffacd0b85a97d-48702af8cfcmr8792350f8f.6.1789490683001; 
 Tue, 15 Sep 2026 09:44:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27a36sm273329f8f.17.2026.09.15.09.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:44:42 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 16:44:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: c9b0a0b3407c9535a07dba24c5a78ba7ca4cfabe
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 16:44:41 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ff383d69b294db496bbe89e6c7388c3aaa253a9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6WH3-0001Bx-QT
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1872661107040132358=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1872661107040132358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pZlaVnN33gQ="; charset=UTF-8

--pZlaVnN33gQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 30: Code-Review-1

(1 comment)

File src/openvpn/sid_hash=2Eh:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/ae09b1f9_b61fd358?=
usp=3Demail :
PS26, Line 23:  *  51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA=2E
> Done
Not done



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Nu=
mber: 1727
Gerrit-PatchSet: 30
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 15 Sep 202=
6 16:44:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-=
Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flich=
tenheld <frank@lichtenheld=2Ecom>

--pZlaVnN33gQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 30:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>1 comment=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727/comment/ae09b1f9_b61fd358?usp=3Demail">Patch Set #26, Line 23:</a> <cod=
e style=3D"font-family:monospace,monospace"> *  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA=2E</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Done</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Not done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198=
792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 15 Sep 2026 16:44:41 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></ht=
ml>
--pZlaVnN33gQ=--


--===============1872661107040132358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1872661107040132358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1872661107040132358==--

