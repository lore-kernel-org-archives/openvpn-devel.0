Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A1DC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v0XL14KwOPeFxpXZ7JP0G0KmI8oZ3yCW18Y7yTMUUI4=; b=DeK9oGKXyXUfPDYyiu+hTNmGqU
	9cvlRDXE08fqP92G+/v5fX1fgNSsPNnmhJvd+dLRcMo4phdiR3aqSXcRLOlzAt2Ds7m166OmXwVBd
	IMVHu0Afdg2EdRIu4p0qe+rimd2P7Qp6gEk9KF+fmn6120vveBbZvixRIwkgbjl6pcSs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqtp-00057W-16;
	Thu, 09 Jul 2026 15:42:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqtj-00057N-Ao
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=58uv4y9K3TL5JBuzKfmTqOtwve7tHjURtXlTRZe2wIU=; b=Gt6amLFaJZKlCoN1W98ll94910
 96hV6sqTdVJ2Lqh2CAljOk5E1FfOAqyv5/B3oha8tE6eZyMrExfDnh7Ngp8JD1zd5fPkUi8be1T/Q
 LyCFX7/ZwqC3qYOg+6nJnWMWKqaoMWAsV+JeAaXirFPJ34pukV0JckfWD6srhf2vb8e8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=58uv4y9K3TL5JBuzKfmTqOtwve7tHjURtXlTRZe2wIU=; b=c
 UCh6XL9ai62Jhih//q9YEUDfc7tcjJgVoaQe3D7gGlYTHc+DNhICmlm0MS8qvb9UhKR5H1JGMBhPI
 01YhfLxoJLVL9CD/7K7xns0XTIiPDhWXydxbh4Q68VYs1uLWUvUGhettg8sOpG1Pkm4nqBcXiGKoi
 belXgarfwpz5uX7Q=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqti-0000hq-MO for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:42:47 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c15fd3a299eso4559466b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783611754; x=1784216554; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=58uv4y9K3TL5JBuzKfmTqOtwve7tHjURtXlTRZe2wIU=;
 b=Pt/mRNCLVtyuq/i6ogqcPp/UVcbTJIr4g7Gqba88BC7SnuviVt1tRecW95FS52xjYx
 Q7BGd3G4p9Uw6dJWbqR1+0WNQp6d3IKL05gRaB6izpum0cWwfPjVrDOuPBGCK9IS3nV0
 IKuKTL5rlEl2SgjxgKGuTec3Cz00qwYhbOSzLJvA0KXG4lA3gmnLeoqxsn1ifumVvXsY
 lUBSNnXhTrhDsqvexlrS3oP+mwLyXMpQuOS87Kk+dWhC16V+KtVMEq5Ltp4ixjN6K9Ct
 KJO0OpkbAI4JwcdJcshv+W1oJ+gHOiLQNOHtfFaxICNSrTisPTcHPu2LbCHXO8vj3QST
 QVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611754; x=1784216554;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=58uv4y9K3TL5JBuzKfmTqOtwve7tHjURtXlTRZe2wIU=;
 b=J0pishYSfa9ZGXQ2rl7J79eGUBhpFPgDMwurRh3LAxX/hBJeyF1lMwffoUwIwdO6qL
 946+W9I0x0uSkdgDReZ10zKe6t6LNfhY8+K/0s4D6x8DPcHULihB6ZuV3Y4oMVBrqs+9
 tvBdCesvElie+JNdsVFpeMHfyUNdrMGquLHYzSdKCafFFJLLy/g0Vb1y7skEAarR4hP1
 Opp8ip1hH5xDumVzeDLaqiUP+uD6r9BVw9FMo8M8fitRiVlvVVVeNm/zu82FbuqKyP9Y
 q78Xn8985kiXH2kuw9couOeDRFOSB4AL0hUEfbUvaup/Mc8i1/3A7wIPHpBDolKnSJNk
 FMbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ropwgo4gLHauXDZipLnJHpkMMB9vNMcHXd1piXBcMIlhF/cWrIC/G5qX2dwl85AYCJulreFxR7G/5BGnKyr@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwMCt4W5N0LkbuxCosLlJPZQ/fMiD/HL1iAZpBzH/cZowlVXaPH
 acLWmO3U16bQ75Ctz9k2mDUugpte8aua9eec+rVYjMU/xOdPjLHEBxCA5Enx9NKnseN47I66jNX
 99RJVoT7mEp2FA/UHL/KFYy3PwNY9VQiIBWwHNWtR5dJsTL6hMmOI4prbo5B9Tz1I0rMSfmX7oF
 XGkgfdRQ==
X-Gm-Gg: AfdE7ckLEm0QDnvk4ODGIVtJj1ivYSRaj1IGBJv+r/B6w+RbzkviuO9ruSOUQZfJtAX
 htMIt6wJUezUSINtTXkMBBNz4/u721imqHLb8uYktPsfyzQpCQUmra9y6piulnGG/HEUktf0bCU
 vQkl+jBHrhIYqkHc06VRE3knrJT3S3Oz/3ltA1lJtVrcW4lgreeAm2wrdtf4vnl/YCrPANGZtDE
 X0ReIjOvuHgAPVkaYl5IYL+YaKbDL7b5FXWAYcM5EZf5Fm39hGsbMKpS2eIvB0YpzQiQYO47pJV
 05HiN7djon56gMGIB/TdE88UlbE5wZrU5aFoFqSlNSNYJkwME2tIsFUPqNrtiyf0axZHwB7/nLR
 1chCHujerD85IaCc3ByjoifRhzTLwuaY/LRbpjHtdzvbvRSgILptRUPjtrUWA3RG8ejGqpzLB8h
 4cyLMnyNSZOoB5G5gbbGteZ7ikxa3yDZu5UEZ/GyQHSYRtBpffDCN9yX9LiBetcwXrR9KKgo6a8
 ML5kYvUUV5J0G2fvxkajFZdPsLtHpF4dcXbal3qXkzAV8Uk6YBJw1rR0hJYTJpEAnuNRJa9dOGK
 U1AwLqPiGgLCRg==
X-Received: by 2002:a05:6000:186e:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-47df07baab4mr7519260f8f.22.1783604943710; 
 Thu, 09 Jul 2026 06:49:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm53631175f8f.21.2026.07.09.06.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:49:03 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:49:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 225628306ecc72d5b7b06c16d88ac5f271e56b89
X-Gerrit-Comment-Date: Thu, 9 Jul 2026 13:49:00 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd876f201c986802639f74834919dad3747fb01d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqti-0000hq-MO
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
Content-Type: multipart/mixed; boundary="===============0741710003424958502=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0741710003424958502==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wmCEc+ybbxM="; charset=UTF-8

--wmCEc+ybbxM=
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


Patch Set 4:

(5 comments)

File src/openvpn/oob=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/615dc762_016d178a?u=
sp=3Demail :
PS3, Line 35:  * This slice implements the SERVER_PROBE / PROB=
E_REPLY pair used for server
> Not sure of the purpose of this sentence?
Th=
is is about series of patches=2E I agree it might add confusion so I'll rem=
ote it=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/298aabee=
_731ed6bc?usp=3Demail :
PS3, Line 62: #define OOB_PROBE_PARAMETER_LEN 12
> =
why do we hardcode those instead of defining them via sizeof() ?
Those are =
on-wire lengths, so sizeof(struct) could be wrong due to padding=2E But let=
 me derive from wire field types instead=2E


File src/openvpn/oob=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/c951b8b7_d2f6c9a8?usp=
=3Demail :
PS3, Line 31: /* Consume @p value_len bytes of TLV value, of whi=
ch @p consumed have already
> Doxygen syntax but not marked as Doxygen comm=
ent
Will change to real doxygen=2E


http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741/comment/01cc794e_e144d4ad?usp=3Demail :
PS3, Line 105:     if (!ok=
)
> Is that safe? If the buffer has enough to read for u32 but not for u64 =
could we end up with ok being [=E2=80=A6]
No, this is a bug=2E Will fix=2E
=


File tests/unit_tests/openvpn/test_oob=2Ec:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741/comment/5475378e_0edbd3c9?usp=3Demail :
PS3, Line 153: /=
* Reading a header from a buffer that is too small must fail rather than re=
ad
> This comment does not seem to correspond to the test=2E The buffer is =
big enough=2E [=E2=80=A6]
Will rephrase, thanks!



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Ger=
rit-Change-Number: 1741
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Thu, 09 Jul 2026 13:49:00 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@licht=
enheld=2Ecom>

--wmCEc+ybbxM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741/comment/615dc762_016d178a?usp=3Demail">Patch Set #3, Line 35:</a> =
<code style=3D"font-family:monospace,monospace"> * This slice implements th=
e SERVER_PROBE / PROBE_REPLY pair used for server</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not=
 sure of the purpose of this sentence?</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This is about serie=
s of patches=2E I agree it might add confusion so I&#39;ll remote it=2E</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/=
298aabee_731ed6bc?usp=3Demail">Patch Set #3, Line 62:</a> <code style=3D"fo=
nt-family:monospace,monospace">#define OOB_PROBE_PARAMETER_LEN 12</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">why do we hardcode those instead of defining them via sizeof()=
 ?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Those are on-wire lengths, so sizeof(struct) could be w=
rong due to padding=2E But let me derive from wire field types instead=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/o=
ob=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/c951b8b7_d2f6c9a8?usp=3De=
mail">Patch Set #3, Line 31:</a> <code style=3D"font-family:monospace,monos=
pace">/* Consume @p value_len bytes of TLV value, of which @p consumed have=
 already</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Doxygen syntax but not marked as Doxygen com=
ment</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Will change to real doxygen=2E</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/01cc794e_e144d4ad?u=
sp=3Demail">Patch Set #3, Line 105:</a> <code style=3D"font-family:monospac=
e,monospace">    if (!ok)</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Is that safe? If the buffer=
 has enough to read for u32 but not for u64 could we end up with ok being [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">No, this is a bug=2E Will fix=2E</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/t=
est_oob=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/5475378e_0edbd3c9?us=
p=3Demail">Patch Set #3, Line 153:</a> <code style=3D"font-family:monospace=
,monospace">/* Reading a header from a buffer that is too small must fail r=
ather than read</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This comment does not seem to corresp=
ond to the test=2E The buffer is big enough=2E [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Will rephrase, thanks!</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d3=
02ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jul 2026 13:49:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--wmCEc+ybbxM=--


--===============0741710003424958502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0741710003424958502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0741710003424958502==--

