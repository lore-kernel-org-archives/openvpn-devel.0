Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C4DC531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owzCzHU1yJnF/p7gIliiVHERT1sWNsHdd2xeJBFWGJk=; b=jf1RMCEWzJNDWwh4W0BaaEZMoK
	wadfH84XZwo/Ecc9axFLM37Le7pOq3AubP4g4ZFSIfvzStoIiQpTGY8CDF63qAT2OkcmpKOztQ9Ko
	csEcZdLt3RT1Boi8OEBfWarq3yUZ6gTFo+WxsGkgZVy8NeJ1s6i0UUNwhXQ2jP7/SF18=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnnCR-0008KM-LB;
	Sun, 26 Jul 2026 00:58:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnnCQ-0008KF-8p
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rL1WbfTc/c/6r/IrL2qNK/DUvgdwY7wkEITErhgbFV0=; b=RYCZ/1dLI5dbSA0ktXSHV52Plf
 p/6H13jzDweyYARXN9WG+eht6sJf9jqQbGlLmIo418/taOq31GCg43AXpeiIy4jTHD1OIfPXZsIq0
 a46x2HdvdVZvjvPQUGIrCVyYUYAdO/3szZr3nEka90r5lldKUYZJJ/7KX6TAl6EcWKn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rL1WbfTc/c/6r/IrL2qNK/DUvgdwY7wkEITErhgbFV0=; b=I
 8ubYZtBaNk40EOoQrX0SoBicar2LSXvT8oV6j/BsxgfQ9LwpY9p/cByYT7twOADPohWFLkoIIFH9H
 8qLiOYwrz1OJILEVsuIqLDiU0YnvBg0+HVw23b66G5zqzDRpKrG7FRdjXiKEvfzpMkTD6t8dOD+Qu
 Uy8bHFPKQjcmyuPA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnnCT-0006yn-Ou for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:58:38 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so12096815e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785027512; x=1785632312; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rL1WbfTc/c/6r/IrL2qNK/DUvgdwY7wkEITErhgbFV0=;
 b=SEyfOyQpBtdzUMAWNAawwtimy0pQsWPkev0yZ31KOfZ8rLis/2yVneV/RjaujSiodp
 jPeNyTKqBLGB2JPxGAwr1lKSP7HgLnL0rHpsIjp+ppaCoRXKIhB43j0+pPn+0wlC3zXw
 bh3LaSEIaiWKhK7amIuPDWzB036HoJmx7KAqLIIcKm+V6n9h+Bci31Yo+jaq8RH8iG4u
 NaIiUKyFmNlLmkF9vaJLAO8xzrw7Nbg5IiwThfEHG3Rdwexn8maWKWziUssNDetXHf02
 0bHcxzydQa+Kt7S9dzZKOF5/upUTiAENbZdmuZnLgb6yBdtdwHeGwbfhRVkx4pIUnDy2
 0hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785027512; x=1785632312;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rL1WbfTc/c/6r/IrL2qNK/DUvgdwY7wkEITErhgbFV0=;
 b=kKchMTOAt9B/lRpmYKSWeOjznG/LAeN5O2PbPyzinjVkeErLx6CI90dWg7u31Z7mtX
 uh9Sg7ZzgmoSVg6JEskxQ6e64v2BwKHoQGVoz3o4VRR+98wWS2YdAwcf6g8yNSQlmeNq
 8Q1LvEUeKZXXDdvAX4RaHNUZDoFXcxPHI5HPyhsd75iRrCZ3YFRF6DdhrxuJee8H88cB
 FLrDNJPmTNrW3VIzGNlarDnmvteUzlopASbPa0eauenOOptLEFGNTGlCIItgDMgNc5LW
 hCMuA6h78mg+k0hiZOwIR5PriyZMJYAmMuq+wjpObKb04Kqiy09uow6lU4NIlK2EOJLQ
 NReQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPV9eXxoF9/OBrMnvZ3nGzGMi+XVQxr0v+XYSL2T0TsQf7w2+lCRnkdeEsMxKSZbvCZ3/Q9SYpVZvbtzMQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwqGd117XzmBIyDsLR1dcB/9nxAkaTRTvYRhkNYfMbUA6p9mCDp
 h2+ZIvEiMAxvKVO5ZEmysXpSapCF1SCCGucYeYaBh8pPz9Jyek2uIbViVMgEQKZHCu4orLm8u1+
 xuRE7NWPDYu7VjGHNuTH79quVv/MVErMd0Or3F8vS5YgHXRCgRCpSUM5h7ZogqWj1/fznANQSoe
 OawaA+vA==
X-Gm-Gg: AR+sD135a4F6lqkEyieBIS4SSePThtf7Ki7d0GWwKgkQ8sjL+rQM4N0Oa3A6yrsSDC2
 1KD+XkWAGir4vQPfOqpI7tTGvy02FhA+Qy4tVMTOphYZ8MOXbPdZ0KRElX5XlXpkcE79ZG8ULxn
 S9zS9R9i/KCm6azNa8x/9l0PBtJ5QCEmsj8G/tMJwiOOi7hF+T20t0p+LjT/0iowa3H7jhJFNBF
 7NzQa9HR3F4epIh1Lwj2vKn+gQysRBHTTSP8isVkexAasbTnqMuM+/4aFIX/NY/bFAa5dX7Gu8Q
 P0OdiZReGe70SkUrRjXt85+M7AgHde1LUUoHSStJ20pG55FBvoEXQWLNYtEv275Jj1DITP0hYVx
 OER27Ft5c1LZjJ+ESfTIaTlDdHGa9RTVDn+QZc83MHO0f4/pY+kNSkZf1TuJochNGJaDtMYkbZ3
 p14ib/9q7SZBYO+nmhRfZtRwseLFe0W10vrxO6ya0uo5F4ttCy0CyvRXdog0Ec2QbnJBOeocYf5
 ePntt61mnsgSCtc/SJKtnOMJg0jw9nA8h20kVedj+qSUcIawjGyTeYEHUbrkYF7evqw
X-Received: by 2002:a05:600c:a016:b0:495:63e6:5fb8 with SMTP id
 5b1f17b1804b1-496b56fa3c4mr45218265e9.12.1785027511572; 
 Sat, 25 Jul 2026 17:58:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957d41ed1bsm123535195e9.2.2026.07.25.17.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:58:31 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:58:29 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 4e332039301865b4061702bc2d6b622d0691ee60
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 00:58:29 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fee29e6f337beabb28f2bb82b2b8f3ae988eb091-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnnCT-0006yn-Ou
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7149661764188283308=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7149661764188283308==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/6wct5Kz0J4="; charset=UTF-8

--/6wct5Kz0J4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
741?usp=3Demail )

The change is no longer submittable: Code-Review is unsa=
tisfied now=2E

Change subject: oob: Add control message TLV encoding (P_CO=
NTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 8: Code-Review-2

(7 comments)

File src/openvpn/oob=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/b45eab83_cea5e37e?usp=
=3Demail :
PS8, Line 32:  * Consume @p value_len bytes of TLV value, of whi=
ch @p consumed have already
What is @p? That is not used anywhere else=2E

=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/87eaa606_951f189c?u=
sp=3Demail :
PS8, Line 37:  * @param value_len  the TLV's declared value le=
ngth
declared as in the length in the header or declared as in the spec or =
as in expected=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/=
c82b36ce_c84f3b09?usp=3Demail :
PS8, Line 38:  * @param consumed   number o=
f value bytes already read from @p buf
We normally do this by buf_advance i=
nstead of this way=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comm=
ent/d7e80cce_f9965cee?usp=3Demail :
PS8, Line 52: bool
Why just have a meth=
od that wraps buf_write_u16? That seems uncessary=2E


http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1741/comment/c74e3f34_d9a3d0be?usp=3Demail :
PS8, Lin=
e 91:     *value_len =3D (uint16_t)len;
I feel instead of passing the same =
values with pointers again and again we should instead use proper structs

=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/a5fbae94_48df0998?u=
sp=3Demail :
PS8, Line 168: }
The formatting of this method is not really g=
reat=2E


File src/openvpn/ssl_pkt=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741/comment/34640017_fe9a3866?usp=3Demail :
PS8, Line 70: #define =
P_CONTROL_OOB_V1 12
That feels like a very hacky way of doing this and also=
 will already create problem with the spec that we written as CONTROL_DATA_=
V1 (=3D14) as we then need to change LAST_OPCODE to 14 and then this falls =
apart=2E

Also the assumption here that P_CONTROL_OOB_V1 needs to treat spe=
cially should be explained here better=2E What is the harm we consider if w=
e parsed and respond to such packet during a session? I don't see an obviou=
s reason why that is bad=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: =
1741
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Comment-Date: Sun, 26 Jul 2026 00:58:29 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--/6wct5Kz0J4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 8:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -2</span></p><p>The change is no longer submitta=
ble: Code-Review is unsatisfied now=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>7 comments:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/com=
ment/b45eab83_cea5e37e?usp=3Demail">Patch Set #8, Line 32:</a> <code style=
=3D"font-family:monospace,monospace"> * Consume @p value_len bytes of TLV v=
alue, of which @p consumed have already</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">What is @p? That is not =
used anywhere else=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1741/comment/87eaa606_951f189c?usp=3Demail">Patch Set #8, Line =
37:</a> <code style=3D"font-family:monospace,monospace"> * @param value_len=
  the TLV&#39;s declared value length</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">declared as in the lengt=
h in the header or declared as in the spec or as in expected=2E</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/c82b36ce=
_c84f3b09?usp=3Demail">Patch Set #8, Line 38:</a> <code style=3D"font-famil=
y:monospace,monospace"> * @param consumed   number of value bytes already r=
ead from @p buf</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">We normally do this by buf_advance instead of th=
is way=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741/comment/d7e80cce_f9965cee?usp=3Demail">Patch Set #8, Line 52:</a> <cod=
e style=3D"font-family:monospace,monospace">bool</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Why just have a=
 method that wraps buf_write_u16? That seems uncessary=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/c74e3f34_d9a3d=
0be?usp=3Demail">Patch Set #8, Line 91:</a> <code style=3D"font-family:mono=
space,monospace">    *value_len =3D (uint16_t)len;</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I feel instea=
d of passing the same values with pointers again and again we should instea=
d use proper structs</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1741/comment/a5fbae94_48df0998?usp=3Demail">Patch Set #8, Line 1=
68:</a> <code style=3D"font-family:monospace,monospace">}</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The fo=
rmatting of this method is not really great=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/34640017_fe9a3866?usp=3Demail">Patch Set #8=
, Line 70:</a> <code style=3D"font-family:monospace,monospace">#define P_CO=
NTROL_OOB_V1 12</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">That feels like a very hacky way of doing this a=
nd also will already create problem with the spec that we written as CONTRO=
L_DATA_V1 (=3D14) as we then need to change LAST_OPCODE to 14 and then this=
 falls apart=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Also the assumption here that P_CONTROL_OOB_V1 needs to=
 treat specially should be explained here better=2E What is the harm we con=
sider if we parsed and respond to such packet during a session? I don&#39;t=
 see an obvious reason why that is bad=2E</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dema=
il">change 1741</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa=
 &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Sun, 26 Jul 2026 00:58:29 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--/6wct5Kz0J4=--


--===============7149661764188283308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7149661764188283308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7149661764188283308==--

