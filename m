Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B3CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDM65QeDszQ2h8BB5QekDGsAAYsvwHwJzUlBJ8zxYSw=; b=legZA+qIJoB+WejJlwJTnJhekW
	nDrEVkCTHtBeDdPB8JsPp/KNXABuTjDUZPs4muYt2twI0Rgv7OBArSdNHTJn61qC1P1fm8mlhhv1e
	lvBSlK0f0rdrqTpMrviv44VXz67f9wkNS25Tctpv4L1LU6xKsGgJnFNNYtmrsmVUk2S8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDm4q-0002Hn-PZ;
	Mon, 05 Oct 2026 17:02:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDm4o-0002Hg-MD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Db2VYr/PdivmjQ+oP8gaSztCGP+R37GRTpJRTpF68z8=; b=kl0qDB01KG6pGCXuMRfdrJRAWD
 xps/TqQEh0QW8WMrFHo+o0/PguG69L5p+CAkPifsZOXi3Q8TNH9yFl7aBYCbEyBk6r2dy+xKGYFFO
 VrbW5URDxwi32BsRAhaMVHHomvc6khpPpy6U7YhcsVFFfVkMQV1XlcPGZzuW7G2SGPIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Db2VYr/PdivmjQ+oP8gaSztCGP+R37GRTpJRTpF68z8=; b=Z
 dtMPvufgNAOTAs1Nlnbkkgs2FNsIvfA9VdjkIFxylWV/0Un0STpsWTNZ4mTgo65vrWmi/m6oeAJ1B
 ZDkSv4lT6QjB/sYa8VVged3s6mvzI2Jrek+dOzcYTrKWiDANp6Vx+Ks0zhWk3rJEIlzkXSlAdq0j2
 h+kDZrjLRmla66VI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDm4m-000590-Ml for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:02:11 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so19685015e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791219722; x=1791824522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Db2VYr/PdivmjQ+oP8gaSztCGP+R37GRTpJRTpF68z8=;
 b=RimESolxc/vcrL9ISwAXP/fkbC+SXSsuuRtS5OoAVQ74lUSUr9ZOUnxAGhSY4RWejO
 W3mtBdC/mFZCY5j/CfSZhgTuyIF1l+j0v+H5N6QEMJn2lvL/uVw+JACeQfnOmrDclIys
 /Pz+fRMpC8nyIXDFpkbtg6HXNGCTxDlT5afBI4ZhR1TQNeO8UzxoIX07pXs5xCTqO/vo
 EDDMnNwCx2Ed9s4aerkXbOuk78SYg53uOVet3w7Qw3J49LCAki9Ous4apJnbN+jsL/Oa
 uCbH9SppnHJF6L8ZEhb7SLTDn6mwLOopdXrvg4KZyziEgo9pFWMpzQ6sbU9G3ThWKBQA
 jIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219722; x=1791824522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Db2VYr/PdivmjQ+oP8gaSztCGP+R37GRTpJRTpF68z8=;
 b=1PezikXb6rtyoDarF7Il9/EsB6kOE7j4ijNqqQCUzX8z3NCy6AMSS8trEyzShPQ6m6
 QwilqU11wzT4XP2lFunj81OeAUWEfZHPNGCts1T5pKVLu0fcB5OI96NmHrNSHZveQJPh
 929rLEx3InBq4ebXTkSgWypELa6JsGStR42rwYNln8jsC8AbtpStNM8Gcg/rlxv4BDke
 O1cqi0DxdL+FgxTHFJ94bclh444znsSuQB8Cz+HNowsaZMxA0f32MEmPuAajXka6xXAR
 D4lTuG1TxIewM8qhlPZWtGkTUToIS0POfCDUEx9K8im4P114bzy/DsQ874mWMr0VJacO
 IEWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1WuWyUizyWLxgzjcrPljPLWYk589+ASvDPNPfC1jyq/3VUe55t1uV6mJwUnuhPnPx1PezYIKF1UC5/R4u@lists.sourceforge.net
X-Gm-Message-State: AFuF++kbHplALepg+aRw/RQthRio4iUHUldnbMO9U7Pz7xXkG3r9u1I5
 6czD9M7b5R6As7G95tjbkZxnRe5SHF9BE+CUc+tLM6kQnNHoPpJi51RKwQQM2MMS9OKVn74/uKJ
 GYgH8CFkq0V2gBcKPk8KwT2XmIFe1SaWn7ujSfJmTvN3r4S3MsyNNxIlmnu03Vj2sqywn1QOTzB
 Lux03KVQ==
X-Gm-Gg: AYBFou18gjckxtkRX/J+KTINxT5nS9MjLtpkRGFRhsq40AE52vx5LBZKrBJ33zesM4Y
 91o9fHNH+jMJ7d12cDzfckcOYQgeJxqLC2ibI5Xj3whW7V1sod7q2BsHDK0QbnHTHqfasxl0Z1j
 3kcsAOWHSKVEReeNG/D0oUtXc4lp63JJSKqI8/7LdkHzh67y7Zd/FtuxlExaf2FMBYJVk+E84Wc
 Vpmmp1DymJX+Z3xkfw6Rh5vLcfwha9VXiN2ZBWSDIYlDDNkgJztB3VzGvExzfXObbXRKhEWfSem
 iZTaqY4etB5qS9sZ0fk7PMXY5ROQj0Nvg+NGrBwRKEifx3qBA46sgJqQj4hgR47lLST9L++j78x
 c7ou5msSR12qNkoUcFoE/EZxQcR4xNeS2Nuf05aMj02EPHWi2PqwGmnjsGNw77pYS2apGdd0P2o
 fdCcxSP5/3orWWH20MjGcm73HszLfaQIN3Fzfnp8dCEVl6BRXJbdn1uxCMNwvYchAAX6DU4fY8U
 PVRHRdZFCaPKppw2H4HSU2ze2GackdvbhFQKkGZgt6SbpAY+f0v7tRzqpRkT8vSd65HPv7N+WvS
 hGyZntd6wJuW174D4EpwNsbWJVaJmEUGf++MBwJvXHbqn+Nr8w3Ue569Rh7O
X-Received: by 2002:a05:600d:10e:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a168105e88mr85465265e9.31.1791219721881; 
 Mon, 05 Oct 2026 10:02:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff20831sm225787835e9.4.2026.10.05.10.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:02:00 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 17:01:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6a3ea0b127610c2fa41b1aecf97f81939a1b8ad7
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 17:01:59 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d355130c9d536fa45f26a9292f7a8357520d8d55-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDm4m-000590-Ml
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3421168260293079873=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3421168260293079873==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yBT6csF9SIM="; charset=UTF-8

--yBT6csF9SIM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9:

(9 comment=
s)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/commen=
t/d5fa3191_2f3e23c1?usp=3Demail :
PS9, Line 14: This provides an easy to us=
e secure channel that does not depends on
> Typo: "does not depends" -> "do=
es not depend"=2E
Done


File doc/management-notes=2Etxt:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6f4d2db7_38ec51b3?usp=3Demail :
P=
S9, Line 804: the common app custom protocols between the client and the se=
ver and instruct
> Typo: "sever" -> "server"=2E
Done


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858/comment/b07bd95d_e3ba9d46?usp=3Demail :
PS9, Li=
ne 809: to the client to faciliate the pending authentication=2E
> Typo: "f=
aciliate" -> "facilitate"=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/5290d71b_74205003?usp=3Demail :
PS9, Line 826: protocol --=
 the ACC protocol identified that this message should be
> Typo: "identifie=
d" -> "identifier"=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8/comment/fc579552_89240bf8?usp=3Demail :
PS9, Line 1316:     protocol and =
identifies the protocol=2E If fragment is set to 1, the message
> "identify=
ing the app specific custom protocol and identifies the protocol" says the =
same thing twice [=E2=80=A6]
Done


File src/openvpn/acc=2Ec:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/60c40c96_64ed4629?usp=3Demail :=

PS9, Line 185:     }
> There's no comparison of `payload_len` against `acc=
_max_message_length` here=2E
I added a comment that this is on purpose


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/cc49d2e2_4358d549?usp=
=3Demail :
PS9, Line 221:                  struct tls_multi *tls_multi,
> T=
his parameter is not used=2E
Done


File src/openvpn/init=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6d5d694f_45c242c8?usp=3Demail =
:
PS9, Line 4309:     struct gc_arena gc =3D gc_new();
> `gc` doesn't appea=
r to be used at all in this function=2E
Done


https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1858/comment/7f46c860_bd4f124e?usp=3Demail :
PS9, Line 4312:=
     bool ret =3D true;
> Shouldn't `ret` start out as `false`?
Acknowledge=
d



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e1589=
6b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 9
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Mon, 05 Oct 2026 17:01:59 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--yBT6csF9SIM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858/comment/d5fa3191_2f3e23c1?usp=3Demail">Patch Set #9, Line 14=
:</a> <code style=3D"font-family:monospace,monospace">This provides an easy=
 to use secure channel that does not depends on</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo:=
 &quot;does not depends&quot; -&gt; &quot;does not depend&quot;=2E</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e doc/management-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6f=
4d2db7_38ec51b3?usp=3Demail">Patch Set #9, Line 804:</a> <code style=3D"fon=
t-family:monospace,monospace">the common app custom protocols between the c=
lient and the sever and instruct</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;sever&qu=
ot; -&gt; &quot;server&quot;=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b07bd95d_e3ba=
9d46?usp=3Demail">Patch Set #9, Line 809:</a> <code style=3D"font-family:mo=
nospace,monospace">to the client to faciliate the pending authentication=2E=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Typo: &quot;faciliate&quot; -&gt; &quot;facilitate&q=
uot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/5290d71b_74205003?usp=3Demail">Patch Set =
#9, Line 826:</a> <code style=3D"font-family:monospace,monospace">protocol =
-- the ACC protocol identified that this message should be</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Typo: &quot;identified&quot; -&gt; &quot;identifier&quot;=2E</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858/comment/fc579552_89240bf8?usp=3Demail">Patch Set #9, Line 1316:</=
a> <code style=3D"font-family:monospace,monospace">    protocol and identif=
ies the protocol=2E If fragment is set to 1, the message</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">&quot;identifying the app specific custom protocol and identifies the p=
rotocol&quot; says the same thing twice [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/a=
cc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/60c40c96_64ed4629?usp=3D=
email">Patch Set #9, Line 185:</a> <code style=3D"font-family:monospace,mon=
ospace">    }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">There&#39;s no comparison of `payload_l=
en` against `acc_max_message_length` here=2E</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I added a com=
ment that this is on purpose</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/cc49d2e2_4358d549?usp=3Demail">Patch Set #=
9, Line 221:</a> <code style=3D"font-family:monospace,monospace">          =
       struct tls_multi *tls_multi,</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This parameter is=
 not used=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/6d5d694f_45c242c8?usp=3Demail">Patch Set #9, Line 4309:</a> <c=
ode style=3D"font-family:monospace,monospace">    struct gc_arena gc =3D gc=
_new();</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">`gc` doesn&#39;t appear to be used at all in =
this function=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7f46c860_bd4f124e?usp=3Demail">P=
atch Set #9, Line 4312:</a> <code style=3D"font-family:monospace,monospace"=
>    bool ret =3D true;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t `ret` start out=
 as `false`?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3De=
mail">change 1858</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 17:01:59 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</b=
ody></html>
--yBT6csF9SIM=--


--===============3421168260293079873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3421168260293079873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3421168260293079873==--

