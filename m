Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D657606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MA07vrgT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T9Za4VQu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Xeh7zSU3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QJG05XGK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6DeZ0n9AjHDaKinVGwvyo0MPYmP1+CB3mhSJ//W8Sp0=; b=MA07vrgTln999S7PdPAoK8PFMp
	29Mn3b+lTkEoH7joqhyg6f1dzmJ76IfcHmnS4wSDsOdtroAjDJNkxYX5vY3YgFXENDdi9sPMCVCRc
	SqWEbfthGfRx3qbkuReXTE7ofV+jFSXYx1Y5Myn+WIJyaAwedRYOYb+7Hz1/rsDAIHnM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLhfC-0000000019F-0vwG;
	Tue, 27 Oct 2026 13:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLhfA-00000000199-2dE6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PWY2tQzLIIW3v6Bpg9mKdHbLBWgbBZr8aUaPCh5LZbs=; b=T9Za4VQu4kD3yjdJXAkwxZdvW9
 fKYRgWh83Cz0nDriGiq19UtHZqqZFvGtt5ZB0cE4q7VJg7tvwgWIhHeZF13zw1TtCwX6GM7hZ1OVg
 iIayu8I5LY62TgCs3t1eVl2RLMsLGix9jju7YPcq3uc9p0+U2xiZBhrlfrtRloElqs2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PWY2tQzLIIW3v6Bpg9mKdHbLBWgbBZr8aUaPCh5LZbs=; b=Xeh7zSU3Klr0SOUJEGmTdAazg3
 SifEMaLonl18AGj3b1TbNPyrBQOekNQbYr8Im0j+2qDyZKbnEs5OljngCw+pWT7pmdafUAbWKNAb+
 H0O8DpfrzHQc8F0GKf7DjbM1FKqyxWxiU+yJNwT3jsYKXcOspLWMdGzMXe373WU9RcsA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLhf8-0000000080i-3nh1 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:56:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so6253475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793109380; x=1793714180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PWY2tQzLIIW3v6Bpg9mKdHbLBWgbBZr8aUaPCh5LZbs=;
 b=QJG05XGKOZX8KqAYoTIjD/K82VeMvs6i1h+xoPA1gVS1zmpLUKqZVsfS5r1cZiE6Sh
 wHVPFXDGwEF8Bspupsqnd5tP/D+f1SXht4ALfq4gMpwXXcAM+ZRoP0SFq4/Ep+uK056u
 cyjUYbcp3ZMxzevluf7VHEjnBFWH69pADCRWNrO/KqWYCNTydbTAhNjep0DatpkJHERk
 dO4X3GJbH/f8P3JvNrnTS8iUSmvyXyLmzfkx7gZs+Ag0T/BIknC7xx6fwFGGZ7gCr1Bp
 +TGVAE/O1pQnbx9PkaPgCAn+WiBvhNbSyMk7wpR/7NZOhijcqZkGYdsKS/1RDKXwuUO+
 u+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109380; x=1793714180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PWY2tQzLIIW3v6Bpg9mKdHbLBWgbBZr8aUaPCh5LZbs=;
 b=GoOnYw88S0HeS0yxCujwTs/DHxleA+FriSCwSzT3K78L4+F04raDTUlLL0d4fjcMZQ
 zvLS/I5HL/wtzi2tnKJVOLyfVbTTVZA2Y17MwnaG8pfZwvHSXD1pGWBbH+OWi0hRIK2S
 mWtEL6cyw5xZjBLPVamgCHD7DADYBI6r6/ZOVIOEonEjUSxlElbAwGlyypdzd72um6UI
 zQux+kuQDQyHv6iHRP+yJMAfHg1dNgoLKIlyc4SB4+L9cUqR17sO5oADOG+aAMFQNUYD
 zpCqw0K6nz2A+2Bddun6a4QywYPUW7o1fAqvkqZlei4AMc058BUbNYJoKjrSBxjhOooa
 WWUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0Gb9TciaeyDnXMpIaGVEosvkjWmPIKaKUZYDwiG50N/qlmFPVBC5X52mzW5tRdT+c8um5+YPNLha+YVms@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK9JC1Vnb0LQoIPMjU75y4qd1JW0nqcxh5v+iZCOR+l2ISWeBa2
 0xBquSBXc71NerZBuer11FwJoSaW+6gqlChLw2vkKzsBcaF9KGmD3nNDm+Ks1bQHD6+3Kfg4Z4Z
 /E7m4M33PHmzZNdEe3G34KmoufqsU1AFIJ4QzKsW9YKuvfIfFK2S0mDeemaKsnGogwpya
X-Gm-Gg: AYBFou2aH/mFKgVjeu6a9Pi2U+EvPpOUxCeZGGUvG7kGZpg9nZf/wtV4blgCkknM/jg
 KM+MRZQn3NEp+caY93RIeuu3D53gVF/SoUHulsiy+TN4QqU2XT3/Qa76gltAacneXpZupPiB+v/
 JcaW3RV1GexNqdacCu/iCavUupZlDAc5IT2yJsF3447vMEX9qwTKwa3g8o08qub6mbUC2ivvXgU
 bZk33hgPfPFubQcll2Ab/1HcU33jk9BhSjc+XcqYZKRbk3duXh8QDOCl3r2IPEoUYErBdhuhFKN
 7YJ9sggESByCqx3PqxP/Ygsqz0xuYr8k3cs2NRQrMdzqKYjfcO20CTM2Lc5/K/hLqor6vw24p34
 jE31Y/od5XaGSJoAPwoK7mLExwOdc1ZTKoybsOc55GiUDwU/h5Q4QkcJ9Te0U5aifQf777njwjM
 ipOp55Blx/QnUbbe3Y5layyw8Z8Fh5Y2I5ebfCfnZEefgHHjQPo+J7+E9Wm7BejPcijjuXS2ydj
 SJfRhfFN8F+b2twtEkEVrUtfWa0uAf2LpQTM5aK8dS5TSw0GtcTJdsNXud+d9AfF6QjwZOUvhRB
 c6wBqAVY/vQZVl0xUeNeqOd+KlD3C0kKgLW2VKQkE869UmDpVkyldZvRUG2rB0nMJqiX52vUNT2
 Tclz/O5u+fnrYymz/4jOoHnAsWqMSM3EEzG8rp4UmSw==
X-Received: by 2002:a05:600c:1d05:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a7c0485179mr57200525e9.5.1793109380097; 
 Tue, 27 Oct 2026 06:56:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359ff2189sm316039135e9.1.2026.10.27.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:56:19 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:56:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 8747b625499828f3ffebaa38270409a05846e4ac
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 13:56:17 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <562049aaa58349779a296f5fca41a80805c15f41-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLhf8-0000000080i-3nh1
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============9084186929296792168=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9084186929296792168==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EGQypzDnDek="; charset=UTF-8

--EGQypzDnDek=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: C=
ode-Review-1

(6 comments)

File doc/management-notes=2Etxt:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/1e8ba6ee_cc3ebecf?usp=3Demail :
=
PS15, Line 838: The server should then use acc-msg command to send app cust=
om control messages
client-acc-msg?


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1858/comment/3a2b33f4_69fdc753?usp=3Demail :
PS15, Line 882: >>>>>>> =
fd23ffa35a (Implement sending/receiving app custom control protocol message=
s)
Leftover conflict marker=2E


File src/openvpn/push=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7bf304f0_c5f9e0ca?usp=3Demail :
P=
S15, Line 235:                            "without client announcing suppor=
t for it");
This is missing a space (will print "control listwithout")=2E

=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/d7aa5730_d66c7e32?=
usp=3Demail :
PS15, Line 247:     struct buffer common_list =3D get_list_in=
tersection(&gc, protocols, multi->opt=2Eacc_protocols);
Isn't the `if (prot=
ocols)` check below too late if we're already using `protocols` here?


htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/dab730ba_75132fdc?usp=
=3Demail :
PS15, Line 260:         multi->acc_negotiated_protocols =3D stri=
ng_alloc(protocols, &c->options=2Egc);
This also allocates `acc_negotiated_=
protocols` on `&c->options=2Egc`, but later `tls_multi_free()` calls plain =
`free()` on it, which is bad since it was never `malloc()`-ed in the first =
place=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/c47ea38d=
_403eee9f?usp=3Demail :
PS15, Line 260:         multi->acc_negotiated_proto=
cols =3D string_alloc(protocols, &c->options=2Egc);
This is use after free=
=2E There's a `gc_free()` before `string_alloc(protocols, &c->options=2Egc)=
;`=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e=
15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: =
15
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 27=
 Oct 2026 13:56:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--EGQypzDnDek=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 15:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/1e8ba6ee_cc3ebecf?usp=3Demail"=
>Patch Set #15, Line 838:</a> <code style=3D"font-family:monospace,monospac=
e">The server should then use acc-msg command to send app custom control me=
ssages</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">client-acc-msg?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858/comment/3a2b33f4_69fdc753?usp=3Demail">Patch =
Set #15, Line 882:</a> <code style=3D"font-family:monospace,monospace">&gt;=
&gt;&gt;&gt;&gt;&gt;&gt; fd23ffa35a (Implement sending/receiving app custom=
 control protocol messages)</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Leftover conflict marker=2E</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7bf304f0_c5f9e0ca?usp=3Demail"=
>Patch Set #15, Line 235:</a> <code style=3D"font-family:monospace,monospac=
e">                           &quot;without client announcing support for i=
t&quot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">This is missing a space (will print &quot;control list=
without&quot;)=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858/comment/d7aa5730_d66c7e32?usp=3Demail">Patch Set #15, Line 24=
7:</a> <code style=3D"font-family:monospace,monospace">    struct buffer co=
mmon_list =3D get_list_intersection(&amp;gc, protocols, multi-&gt;opt=2Eacc=
_protocols);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Isn&#39;t the `if (protocols)` check below too late=
 if we&#39;re already using `protocols` here?</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/dab730ba_75132fdc?usp=3De=
mail">Patch Set #15, Line 260:</a> <code style=3D"font-family:monospace,mon=
ospace">        multi-&gt;acc_negotiated_protocols =3D string_alloc(protoco=
ls, &amp;c-&gt;options=2Egc);</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">This also allocates `acc_negotiate=
d_protocols` on `&amp;c-&gt;options=2Egc`, but later `tls_multi_free()` cal=
ls plain `free()` on it, which is bad since it was never `malloc()`-ed in t=
he first place=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858/comment/c47ea38d_403eee9f?usp=3Demail">Patch Set #15, Line 26=
0:</a> <code style=3D"font-family:monospace,monospace">        multi-&gt;ac=
c_negotiated_protocols =3D string_alloc(protocols, &amp;c-&gt;options=2Egc)=
;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">This is use after free=2E There&#39;s a `gc_free()` before `st=
ring_alloc(protocols, &amp;c-&gt;options=2Egc);`=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 13:=
56:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--EGQypzDnDek=--


--===============9084186929296792168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9084186929296792168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9084186929296792168==--

