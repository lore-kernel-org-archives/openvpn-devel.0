Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0C606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fLJz1o2x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CKhaGF0F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TaR4/CAm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MA4Q0sqq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+DyXjwFJHAyinLCYI4mytBaliX9sXwAmZAyeb5UM8OA=; b=fLJz1o2xa7ufXwlFJzUcdAHZzR
	jAe0OfB2RwzSXnmzGNNEY4nWwddq6/nxVd4nTtOPLsWKd1xG6+drwxIChtcrflgwAFnOlxtnfkIfs
	mh7okd4M75IJqTQ0cQAX/0IkvIKS5TUEJJ8zW3+z+yWGO7kwCMto7xNngJ+gec7/UEHw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOhF-000000004IJ-26SG;
	Mon, 09 Nov 2026 12:42:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQOhD-000000004I7-3j3x
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WrYS/gXHp8cLr+L/LiKd8w7eDesLvcfRfcD4eWrB5uU=; b=CKhaGF0F5h+LrODciN3XKrZ0ju
 v3DZWybKMYcQXbIxP1047u6Fndle3PQtIDfbFKeOclKqOTQ8gUbeZIdPhF+wsksf3Mt9/MEQm54ul
 SxjLFJxErCdhiiN9bNeIJ7dEt3knt8F1x9C3ux5EHOV65Nz6XCMax57FmsvSD0hjueV0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WrYS/gXHp8cLr+L/LiKd8w7eDesLvcfRfcD4eWrB5uU=; b=TaR4/CAmT57VCh+0C/KgqzYPoe
 9lgljvD/n6Lrx3PuhJn+6gjw0akUKet9L9FIF0KUqYuaxZHWd2dXIY08q1k6I8tT6JBXDqhaC6Zm3
 aY7n3S3t8QXNk9a2Ar+gRGDIOmPuHSTsbqsdov8P8uooE4uqI9SsUC1AsP9Ax+NAVIfQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQOhB-0000000050m-43OC for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:41:59 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso5787535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794228111; x=1794832911; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WrYS/gXHp8cLr+L/LiKd8w7eDesLvcfRfcD4eWrB5uU=;
 b=MA4Q0sqqWMrG0w9v7xgmMPtHKstIBAR7sIAh8GgugLy7w1APrdy1hEtRzxgHEd6wTz
 GEg9SNW9YEkiM8EJN2V+TxfUwh2jW6CuK6WC20lUuGhf+4Ddk4mpiYHce76B8Pshh+c7
 JSCf5jmSOHSOAXo1/1U/Uu3OXWOenDZRrxCBml5OzK+oX8mAbLuuz2Sy7RSH1m7sHywt
 0B2BI1OxXGQMXLQK/8zw+8LdVNuVQy8VFEler2vKAMKWHuZ8fmPez5ZQ+uSUBYsScQby
 mrtTnyN2WT1mmr4GnjQ8wcjPv+c4RCvJpgnwS8TZ7b3DVnLUfP8wJGM4FXQo8f/eD0xB
 UfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228111; x=1794832911;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WrYS/gXHp8cLr+L/LiKd8w7eDesLvcfRfcD4eWrB5uU=;
 b=mNwC/uvmFmNPuAJxPzWWqftyaEPcSpxb4BAEmziH4v0LA1Lft7OQP+yo5Ada+XWX6t
 +80+8N89JPNzl5Vp6yEIgfrGJZk0sIGmoJ9bcZc858w2gh7oo0paYvQN/0ZMJ+mEPJia
 8CbkkQtfR7NjCNbfjWpO7nk4BaUAyJJYQTlvG6BCIQNTTnkZy8kM7FAr/pJbt5fxFC3t
 3Wry8dY/EgG4edmigxD0jTh03hFhXEyx6Nd/meRfQqdJ/mCNUskFXm3j7/LRSnBf4KKY
 SltPo60djFzll/hSJutcBLqv94p85MfT2KA8PNAXTFFrK/h832CSOlNBLSC+Dvc5+Idr
 iscA==
X-Forwarded-Encrypted: i=1;
 AL+hErH63q75hI2X6ZFv40qcXKXyhpsyld0SDVNO7r88Mhm8qz+iSCt3BBKLI//E17V4W8lBwJ20aI91vGSLrOLz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z96X5id1FunpQ2jlWxkvimT/C2U+MQDzd/6otaCYtx2Y7f6y4r2
 8zF+h/X5kVx8RR4I1LzXX4xeGXQteMsHTKrbOcpfCHTsAfVAL58gICJO+fRNVIboj2VXeBjbjtH
 OhGMDYG/P7iO9sK6geP+flV6AaKGHqjYP/QEEvMqPUcXF/Bheo9HWx7p7dQoutP6GQxfA
X-Gm-Gg: AYBFou3a1v3r6NBVj/wGJ0IjKkpnUaGEusDnaNsz+4Ajxqea5vvhQADEkElUceEjH2R
 2iFsF5OSXG/IVCAH96uRWZz8fU5mtTaW/GTgbOvDTBcOTHiNdG4WW4xYaSQ6//3Czz5JkM6gUiy
 Zj0D8Cf17KFSyFyEhH0jhbAvoYnYQ/Hf0Rtpu5xASD6VEKO9WcyGApSAejsvhWZRkHwndB4wVXc
 3yQCA4o/03zpEHqnDzZr3ViO5q0Y5Ocl49z59KshUu47k75pjrjGdmlB95r4QziXjKhp9y72ewN
 QorisawoD+/NFcUiWwNMQTUt1CA8n9crpe2ZzZmV5Ek4emXwwuO1AbZGqDVtcuiex3Mqe3Ukud+
 almfHJD6/JloeFAEXG6edmn17b6/CgOZHHbWk3Reb35MTOeQd2hrD6cmwi9ykdunV0qdw9VdO6U
 iMeZ0SEgs6Dfjdk1tGmAoEkgQxoOwpNc1vo/m50TIr/wwt4mnRizGBMNqmoPl7RW28kez18g6XQ
 tlfBm52YoMYRHjPRis36s3dpYdBRofjvVhO8AFQOj6QZQDf3T1IG9Bvs7U07VLBwEc8f54GytS3
 EZUH7/6mzA64IcfAqc9gRwGdJHFwC6jyVBmD1PlWgJmdt3N0K/xoHwZd36MY8TGlsvQoTGTTaxy
 8/ry0tEFI8sx6BZFN2lfq6hcVyIR5+6WD9Vt73WLq+qNr22K3OIW4wsgh4ZBY5uUpBgSMl3NFvV
 DvbTGkQ6NqG8729g==
X-Received: by 2002:a05:600d:82c8:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4b963c89155mr85398255e9.25.1794228111316; 
 Mon, 09 Nov 2026 04:41:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597748acbsm9712970f8f.44.2026.11.09.04.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:41:50 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:41:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
X-Gerrit-Change-Number: 2149
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2149?usp=email>
X-Gerrit-Commit: fe84554b29b3606dd25dcd6d8adb29cfcef5dcfc
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 12:41:48 +0000
In-Reply-To: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
References: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM0MDAwLkllZmNjM2NiOTBmM2U2YjAzNmE1ODRhNzQyNjg2NzhkYmMxN2RhNjlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b00661af7a606b21d76720e63d0afb7bc8bb935-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQOhB-0000000050m-43OC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused
 gc_arena variables
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
Content-Type: multipart/mixed; boundary="===============7793012054672808547=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7793012054672808547==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S+UUs8f1BZc="; charset=UTF-8

--S+UUs8f1BZc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail )

Cha=
nge subject: Remove unused gc_arena variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a742686=
78dbc17da69f
Gerrit-Change-Number: 2149
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
: Mon, 09 Nov 2026 12:41:48 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--S+UUs8f1BZc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?=
usp=3Demail">change 2149</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2149?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2149 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 09 Nov 2026 12:41:48 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--S+UUs8f1BZc=--


--===============7793012054672808547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7793012054672808547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7793012054672808547==--

