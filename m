Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B2AC54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGoNeZjB/fR1j8zJ4NCOe94zd2KdAl08B/5C104VSq4=; b=QapIGGp8XFa2uRgaABKyxkgzr5
	7AmP/wUkU4E7GkvGiXBPYy0LifekgmrrNzhM2QYxoSP0ryI1+jZe1lgVoe5MpJJKa10HKrvp6OO5w
	6V4BCo5tDl4hZ/cj5dPoJte34xsVYc+c+zTmSFywOxYViqO+U6Uaw/6BbI4pwkTwY3DI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMO-0001oU-5V;
	Tue, 28 Jul 2026 15:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojM5-0001lp-H2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lR0XyJCAWbzLpcEwEC4Af1blbakUEeu7b6EMbd0Eagw=; b=QVN1AV83wxElrf1cMWLGYNLZNM
 UrKgoMNNK30YBrFdM1on8jWTSrDa+Ik5gGmhWfKMpaiFq1osVr8IztAxGOUpLQUg2mNSnAwMJ51hc
 KfmxJFyvfyOpusQucSdySLYMpwS5Y7JvO4iM0wFMju2HiLDG4iv0pj27A77wGEVTyKGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lR0XyJCAWbzLpcEwEC4Af1blbakUEeu7b6EMbd0Eagw=; b=J
 bnaKhkAQAcWmiHXWhBhbonHWA3Qolr9TBXWlK4M6gNAAZ4Jjn84FXBkCOD2A8QG+wxWh7JFVaS2mV
 xlI+Iqgl6JGj9iOuw2KijGd1k2z2uMtrfbbk3KNDSJF41D315Vxdq9yh4hX8REI5rP0ekUCx9SNbl
 yz7q7yoK1bVz3/Uk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLw-0000QH-IM for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:21 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3318635f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251054; x=1785855854; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lR0XyJCAWbzLpcEwEC4Af1blbakUEeu7b6EMbd0Eagw=;
 b=ewqC/nKSRKdMhzSrByXflCpuzLde+OaI8rw9NDyTG2cl7OsTrDiZ2J9NoMucm7N/aQ
 7wrsQlEujMaNTm+VOlfPJUi6qBCI48hU7BidIWaJhZ+pQ4A2qxBmjUsU7mszcjKokolC
 4xASNpT7ff0riotFb0B45/BkzVt8WRmJAfsKxTGhyh3m3+SPY47RnemIJWJ4wCQ3jzm4
 SchD89P0GTSnqg83i/Lug6LMoYilQrNW8VI6eu/bCGan2axRmqhYVEqFSPkFDpc/H86W
 Tmg98OGLVvH4BVksHpEORjuW+CVN0adR2VaopKnzC2Gnctl3cDSH9Py75Gs0BKroslb9
 J48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251054; x=1785855854;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lR0XyJCAWbzLpcEwEC4Af1blbakUEeu7b6EMbd0Eagw=;
 b=GFEczzOroOuxZE6FwHL+0qao/bvH7F9xe/MkITyGZQU6TI0Sxvi28+mXFz9Q0ZL8jn
 aikXLXLCQRVXTPjex+BSIm8sU4rgFz7DV2pUtd/IgNEpQG/Spd2NUdITRTaXE2sKLouJ
 vXQxKCZRaDUlNwuL+qgKxIzV/8Lr7awgmUJ7+YpHxuRi2dlnzQ4nIbTu0DBepU9fSxHk
 aCP0+ureSJHOdlC3YDf7GZebI4KULGqFFpdFhyGl9ZqfGjzn8gCjwCHRM4MuIWjxgPVC
 6zDhn9d5wVTUBXDXCKS/sTQt6CqXr4hrI4NsstPHeMPOrdXxbcUd0suSLDDDZeCKRJtw
 wOsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RogBw9rCYNNFHRRhoBm/TFkkqFqiiW5eNpn7OYmzv6OCT3akzti3PfjLulBuyOgc8qnvG/OpFwuZCVurUbZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzoJch33mncayqhYEq6wxdnMbKbInFz9Ih5hdSIxy29sv4ELV5t
 CohGX/eSrzLOxjdjCJlkpjkAEJu7OwZmI4kHBlA135zK5qn2ttcdy2htQowzy1kHHfmdSsBiaSG
 JEmi5abUdlQUFyfirGTJtNJy0enssFXf2ldAZGLq19CiaGqa2QChMQtZK30o620DJvYXL
X-Gm-Gg: AR+sD13L21DLOLYvmgbYxCiKyPsKF8HZwsyJ09fqWjFFqZEO8LnNo9Zv5x8AcBFM3xC
 kGfElq0WlWEx5rmQdJ/SzMJV06psqhrEFpjyrr89S1LHw3zCdDIP5pFY5qMA+lBZz+NYaQSx0AQ
 OaSsOph5P19NecC5VQ/zX3Vve0TpF4gvNARqQTJ2baNC7SUkPcDY5kJqSF1AkSAy6AlaCzLACb7
 +gRFKB6KmBgRVHov7oDm8LD1KOvDinZC5b96TS2YPMism2HfKUH5KLbIUPShsP+1G14MuwlQape
 cN1Ud8Tun/7jPBWefqLdEMY5DLA5e+j0eB5C0yQruo59wRWEZUCn4AhYPPmPw8/GihClKZQq06t
 an58GN0FDpeeI5XcU+RM7KCQNqiNbgWVtMPQZvQOHvTdXYHnpWBh7iYxKHIBmFsIbEOlV0YnRun
 BKbMzfUiTTYIrGSXwEI7qEsmvlQkZUM1MLL9eQLx4yKNPw29kR1tZIGDfGqG1PH44JFo4sRJ8ON
 UyR7RBcMrRY03rCjzUp4pImNma6mNNBatjaGxVDoHe3zomX6WCGH5HqHec0MElw06ey
X-Received: by 2002:a05:6000:2408:b0:47f:80e5:b98c with SMTP id
 ffacd0b85a97d-47fb1f149c7mr3092794f8f.36.1785251053732; 
 Tue, 28 Jul 2026 08:04:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm62206322f8f.31.2026.07.28.08.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:04:13 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:04:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: a86807f8ff487d67889bf8747327e6311aeba99f
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:04:11 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9cbf54fed4709bec4742be56b97b0e0a06f7d0c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLw-0000QH-IM
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5321430363707910013=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5321430363707910013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2RogCbXj+4o="; charset=UTF-8

--2RogCbXj+4o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 9:

(9 comments)

Patchset:

PS8: 
> The spe=
c I wrote cover both out of band and also inband MTU check packets that hav=
e the same format=2E [=E2=80=A6]
I will move the code which touches both OO=
B and future inband into control_msg=2Ec/h and leave only OOB-specific code=
 in oob=2Ec/oob_client=2Ec


File CMakeLists=2Etxt:

http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1741/comment/c99a69f9_76cadbc8?usp=3Demail :
PS8, Line =
868:         )
> Do we really need an extra unit test for this? Can we inst=
ead just add this as extra compilation fil [=E2=80=A6]
I would keep it sepa=
rate=2E There are already 19 test drivers here, many for smaller modules, s=
o per module seemed to be the pattern=2E Also test_pkt links the crypto bac=
kends, tls_crypt and reliable, while oob_testdriver only needs a few files,=
 so I would not link crypto stack to it=2E


File src/openvpn/oob=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/e5bb0109_e5122bc3?usp=
=3Demail :
PS8, Line 32:  * Consume @p value_len bytes of TLV value, of whi=
ch @p consumed have already
> What is @p? That is not used anywhere else=2E=

We do use it together with param name in doxygen in other files (init=2Eh =
for example), but somewhat inconsistently=2E Let me remove it and use only =
@param and bare parameter names=2E


http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741/comment/b28e0c8b_70ef40c7?usp=3Demail :
PS8, Line 37:  * @param va=
lue_len  the TLV's declared value length
> declared as in the length in the=
 header or declared as in the spec or as in expected=2E
Will replace with "=
the value length from the TLV header"


http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1741/comment/6c0b4a64_7b69b0a2?usp=3Demail :
PS8, Line 38:  * @param=
 consumed   number of value bytes already read from @p buf
> We normally do=
 this by buf_advance instead of this way=2E
Yep, will call buf_advance() di=
rectly=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/b4561618=
_b5c30c7a?usp=3Demail :
PS8, Line 52: bool
> Why just have a method that wr=
aps buf_write_u16? That seems uncessary=2E
agreed, will remove the wrapper =
and call buf_write_u16 directly=2E


http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741/comment/1537b583_56bd7781?usp=3Demail :
PS8, Line 91:     *value_l=
en =3D (uint16_t)len;
> I feel instead of passing the same values with poin=
ters again and again we should instead use proper [=E2=80=A6]
Yep, will add=
 struct oob_tlv_header struct=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1741/comment/9db80515_ad07ed38?usp=3Demail :
PS8, Line 168: }
> The forma=
tting of this method is not really great=2E
yep agreed, will fix=2E


File =
src/openvpn/ssl_pkt=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/co=
mment/23c27391_45a5ff38?usp=3Demail :
PS8, Line 70: #define P_CONTROL_OOB_V=
1 12
> That feels like a very hacky way of doing this and also will already=
 create problem with the spec th [=E2=80=A6]
The root cause is that P_LAST_=
OPCODE has 2 different meanings:

 - could this opcode appear on an establi=
shed session
 - highest opcode that exists

At the moment the last opcode w=
hich could appear on a session is 11 and 12/13 are
OOB=2E When 14 (inband) =
appears, this will indeed break=2E

Let me change it in the following way:
=

 - P_LAST_OPCODE will be the highest opcode that exists (in/outband)
 - ne=
w static inlines to gate session-valid opcodes:

static inline bool
opcode_=
is_oob(int op)
{
    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTR=
OL_OOB_WKC_V1;
}

/* true if op may occur on an established control-channel=
 session */
static inline bool
opcode_valid_in_session(int op)
{
    return=
 op >=3D P_FIRST_OPCODE && op <=3D P_LAST_OPCODE && !opcode_is_oob(op);
}

=
What harm in answering OOB packets inside the session?

No real harm today =
- a probe on a live session is dropped anyway, but
incidentally: OOB carrie=
s no ACK fields, so the session path reads SERVER_PROBE's
0x0100 as an ACK =
count of 1 and then TLV bytes as a packet-id and session id,
which mismatch=
es=2E The payload is attacker-chosen and session ids are plaintext,
so it c=
an be crafted into a valid ACK array - forged ACKs stall a handshake or
rek=
ey=2E

Answering in-session: yes, but as a follow-up=2E Today's behaviour i=
s worse than
rejected - the stateless path only runs when the address has n=
o instance, so a
connected peer's probe is dropped, not answered (rare in p=
ractice: probe sockets
are unbound, so reconnects arrive on a fresh port)=
=2E It needs dispatch before
reliable_ack_read(), a per-instance rate limit=
 etc=2E I'd do it with
CONTROL_DATA_V1=2E



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Cha=
nge-Number: 1741
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Tue, 28 Jul 2026 15:04:11 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--2RogCbXj+4o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
9 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #8:</a> </p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The spec I wrote=
 cover both out of band and also inband MTU check packets that have the sam=
e format=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I will move the code which touches=
 both OOB and future inband into control_msg=2Ec/h and leave only OOB-speci=
fic code in oob=2Ec/oob_client=2Ec</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/=
comment/c99a69f9_76cadbc8?usp=3Demail">Patch Set #8, Line 868:</a> <code st=
yle=3D"font-family:monospace,monospace">        )</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Do =
we really need an extra unit test for this? Can we instead just add this as=
 extra compilation fil [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I would keep it separat=
e=2E There are already 19 test drivers here, many for smaller modules, so p=
er module seemed to be the pattern=2E Also test_pkt links the crypto backen=
ds, tls_crypt and reliable, while oob_testdriver only needs a few files, so=
 I would not link crypto stack to it=2E</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/e5bb0109_e5122bc3?usp=3Demail">Patch Set #8, Line 32:</a> <=
code style=3D"font-family:monospace,monospace"> * Consume @p value_len byte=
s of TLV value, of which @p consumed have already</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Wha=
t is @p? That is not used anywhere else=2E</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We do use it to=
gether with param name in doxygen in other files (init=2Eh for example), bu=
t somewhat inconsistently=2E Let me remove it and use only @param and bare =
parameter names=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1741/comment/b28e0c8b_70ef40c7?usp=3Demail">Patch Set #8, Line 37:=
</a> <code style=3D"font-family:monospace,monospace"> * @param value_len  t=
he TLV&#39;s declared value length</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">declared as in the=
 length in the header or declared as in the spec or as in expected=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Will replace with &quot;the value length from the TLV header&qu=
ot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/c=
omment/6c0b4a64_7b69b0a2?usp=3Demail">Patch Set #8, Line 38:</a> <code styl=
e=3D"font-family:monospace,monospace"> * @param consumed   number of value =
bytes already read from @p buf</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We normally do this by=
 buf_advance instead of this way=2E</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Yep, will call buf_adv=
ance() directly=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1741/comment/b4561618_b5c30c7a?usp=3Demail">Patch Set #8, Line 52:=
</a> <code style=3D"font-family:monospace,monospace">bool</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Why just have a method that wraps buf_write_u16? That seems uncessary=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">agreed, will remove the wrapper and call buf_write_u16=
 directly=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/1537b583_56bd7781?usp=3Demail">Patch Set #8, Line 91:</a> <=
code style=3D"font-family:monospace,monospace">    *value_len =3D (uint16_t=
)len;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">I feel instead of passing the same values with =
pointers again and again we should instead use proper [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Yep, will add struct oob_tlv_header struct=2E</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/9db80515_ad07ed3=
8?usp=3Demail">Patch Set #8, Line 168:</a> <code style=3D"font-family:monos=
pace,monospace">}</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">The formatting of this method is no=
t really great=2E</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">yep agreed, will fix=2E</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741/comment/23c27391_45a5ff38?usp=3Demail">Patch=
 Set #8, Line 70:</a> <code style=3D"font-family:monospace,monospace">#defi=
ne P_CONTROL_OOB_V1 12</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">That feels like a very hacky w=
ay of doing this and also will already create problem with the spec th [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">The root cause is that P_LAST_OPCODE has 2 differe=
nt meanings:</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"> - could this opcode appear on an established=
 session<br> - highest opcode that exists</pre><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">At the moment the last opco=
de which could appear on a session is 11 and 12/13 are<br>OOB=2E When 14 (i=
nband) appears, this will indeed break=2E</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Let me change it in the follo=
wing way:</p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"> - P_LAST_OPCODE will be the highest opcode that=
 exists (in/outband)<br> - new static inlines to gate session-valid opcodes=
:</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">static inline bool<br>opcode_is_oob(int op)<br>{<br>  =
  return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;<br>}=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">/* true if op may occur on an established control-chann=
el session */<br>static inline bool<br>opcode_valid_in_session(int op)<br>{=
<br>    return op &gt;=3D P_FIRST_OPCODE &amp;&amp; op &lt;=3D P_LAST_OPCOD=
E &amp;&amp; !opcode_is_oob(op);<br>}</pre><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">What harm in answering OOB pack=
ets inside the session?</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">No real harm today - a probe on a live session =
is dropped anyway, but<br>incidentally: OOB carries no ACK fields, so the s=
ession path reads SERVER_PROBE&#39;s<br>0x0100 as an ACK count of 1 and the=
n TLV bytes as a packet-id and session id,<br>which mismatches=2E The paylo=
ad is attacker-chosen and session ids are plaintext,<br>so it can be crafte=
d into a valid ACK array - forged ACKs stall a handshake or<br>rekey=2E</p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Answering in-session: yes, but as a follow-up=2E Today&#39;s behaviour is =
worse than<br>rejected - the stateless path only runs when the address has =
no instance, so a<br>connected peer&#39;s probe is dropped, not answered (r=
are in practice: probe sockets<br>are unbound, so reconnects arrive on a fr=
esh port)=2E It needs dispatch before<br>reliable_ack_read(), a per-instanc=
e rate limit etc=2E I&#39;d do it with<br>CONTROL_DATA_V1=2E</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Tue, 28 Jul 2026 15:04:11 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2RogCbXj+4o=--


--===============5321430363707910013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5321430363707910013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5321430363707910013==--

