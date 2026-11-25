Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E7606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QOpZGpo1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EsSwrEeT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U6WioMB4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AlmCvcEX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6FU6iZupEz12mHoQyJ2lWqd7kCXZRMkeckg6LY+fFq0=; b=QOpZGpo17eDg5xx+k1Nyh+uXJL
	KtuDUJZkXIZzRMZHtpHNYG/nPO3/UNDRt9Wukb4ebxFP4urtAJ+Mae02m67dHJDMuxuc8E4aHcnpx
	e3nxFB/ooUZ7nXo0Q8d4DZCxnH1TQ3uGWOryWwQN58LEOyXRGSuGJ2TjSUHXfFfH5Y3w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWClu-000000007xZ-0EYV;
	Wed, 25 Nov 2026 13:10:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWCld-000000007w4-0nvm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZNJGENg76NXuyWkrM/6cvF7DkjtnBv/RDZ224a84PgQ=; b=EsSwrEeTgg1zevt0LX4Yv4yIS8
 aXrBOAYOZEe3rDPfXDhFzYHuxsw1M7mlhGu/H1j7qNdQZ49A5x+RZlPnrOpINKiUVQzS1XLqetQpp
 nOwKFdHq5n1fwy3e16DXX/PRM3cLZKUo/EmfcI3x29cgfvzQfwMmAZ0u0kOVWlHoJqOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZNJGENg76NXuyWkrM/6cvF7DkjtnBv/RDZ224a84PgQ=; b=U6WioMB4c7JJax+LhZOgzLwt9p
 9YcW6UxQleTJ3MjLNbJ/kCt0FUx4QYZAcy7fTa0WJPIrzj/2+wm0SGIC8s02307kSbQW60XWKJjTU
 qRg7CRG67atILHkveic5riv02RLC9YLYuMwKi9nKwb4YK4eNfc7VXDP+ifoV4Z4PiDjk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWClb-000000002Pp-0qmu for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:10:33 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so6291605e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795612214; x=1796217014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZNJGENg76NXuyWkrM/6cvF7DkjtnBv/RDZ224a84PgQ=;
 b=AlmCvcEX/LlkICYSvck++RGZusU23POmSSc+FjxCCaeb8PP6OAautSojTWnMjrs5sk
 mbeUY6Z2ewJzCeWBEZZxaWLUlYnJByZxbEaXnGI+AnQciLM1ZGXn8AZMPpHFW7lp61jc
 ESkFXYh4UMiEk5HFAojZN/gU1nKRqCHxgDfojKBoeiwGvRa5ShAF/5c4ZPZsqoWR0KoZ
 iJxZqpfKB8H/sCgjZbvywLj6XsrNeVlRP1o2vDql87OID9IhAFzjUlrVU3Z6MFqeFKki
 IPYyLVB0XWGg17IZ6Axcipx8cGwGcYnJB06pko1cB4qDV4URwBI7pyPmkRIv9DUESbzs
 yUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612214; x=1796217014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZNJGENg76NXuyWkrM/6cvF7DkjtnBv/RDZ224a84PgQ=;
 b=oNx5mHrnrxy5KFvXj20LxsvvIfdb33hPhvz+YU/Bc3uzFP9wpvIncwtMjsQDhr3abX
 6d/BLEXSfZ5YdZG7fpx0EKT0uKs31G6JfRt+d0eNuroc0un/lNumMPzQwstXilpkkhzV
 covdwn+S60SjC0JnByB8jzh01qzj1nXunodqNsS4Xtnbzzcua2TI7+0umCVsfdxM8mrh
 7iE8h2i9JN5JJdS3xtZIEvH1A9oH9QiOhVio/kyxPPfFHVoLa1zUA9u+v61naSqlp52z
 puDp9UO6MXAJppQ/jUlKSpOp2LQRP4RmZE3IxYGXyowals1RXcPK9jzglRb09p/oo4wV
 empg==
X-Forwarded-Encrypted: i=1;
 AL+hErF1NHMeNn8uBK+AWJhiii90aikZzdn/pWdlI1UDyP41DhBSHXj9Cv/X9Li6gWLpcZMGVVfsJ0bhDGszm3BO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+6xD0F7cy0xdohiPuOyBUppwtQ3X3XO822IOaonnMW6MTCaVAg
 xFcqk40unjMxstVg5ukCIYjXNW1HDIVpGxhKZJAnKPn4e/zfrDinGXxD7uMguUB0QedLpsL/9aF
 FMMLoimxkM1GlILb07Oa41LhHEQuEjZDER3aK6VUbML18oOQ1s6dwYxwca0rpmpsWznD5YKOoEv
 tTx4fzag==
X-Gm-Gg: AZFdTZdXY1vfKSFpCR1NeQ38yFonB1m38WF0I8UufY4vrsnh+YoVDd2yqTFTwxM9KJd
 k8PXzd5draAcJp0SnDzSlJYc+7FRzrMqcZ/1BuV2bOt+kcEkUzOiHSVFdUPPURp0DSvPBDbXJ2l
 yEZpt2ZNphMyFOHXAm5+8PItbRdBjpuAH4An6FrNA5K17UGf+++5Ds+ojjAPnv7Io4RBtxy0MuO
 FAz4ol+iYAdNOwyJhOUQDzIsQgeY5daduR0ueRPmuWxDrwlWHAkTIt2zy+DtTUjEJnlC/QXoFHi
 H5q8/bs9o/KTIW1+LtIzlFBPVvZ+RyuNs9KeNn70dDfDy7+YHHwtHzc6aDw7QejNeeh5mja5Ydr
 B4LiQo2n6v8Vnft7hQ4D//g1DjzS5hm4dv0I6UZ525Y8X3Dpth4mV1qktgeY8/knnFkeS+U9dtk
 d22g4FskhG574HhbjZOB8l+yN0jwrtGisZW03kU8k72WBSjDkM0gPXovVYc5x7FQpDOFqs2zDKX
 Qp+uGGEpPN3cSb0Exgm+HNF9YbJKJSMOuIvfaBIPVVm++Fk/4rFLzN8c+zy09aN0JvAWbKuPNtK
 g5pESb/rgjAVwuMZSu8fgzyezZi0Q6IRewSISw97RvOLIO6YCdJR0aVm4wIPHhgCo/vKJnCruZH
 mf6L47Zy3qvJEqnI3t+AG1zmNkdEfd9kP4qHkxLqm2G/AbAQYCNW1iw5+3hSOWhHl9AF42YuURU
 1CrsyLEM+yx/RfppE=
X-Received: by 2002:a05:600c:674b:b0:4bb:6947:3e1d with SMTP id
 5b1f17b1804b1-4bb8892c0fcmr329568935e9.20.1795612214225; 
 Wed, 25 Nov 2026 05:10:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm515931455e9.1.2026.11.25.05.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:10:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 13:10:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: 5aeb3a3f993032b6f77be9c1303a767720a0897b
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 13:10:12 +0000
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb540f44ac097047555cf29c01b77e6ecb131e6e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWClb-000000002Pp-0qmu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
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
Content-Type: multipart/mixed; boundary="===============5963982047906473631=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5963982047906473631==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="auwzy/Gl/vU="; charset=UTF-8

--auwzy/Gl/vU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail )

Change=
 subject: Windows: Switch all uses of address family to ADDRESS_FAMILY type=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1:

(1 comment)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2342/comment/a4b99114_511d3a18?usp=3Demail :
PS1, =
Line 1909:         MsgToEventLog(M_SYSERR, L"%S: could not open interface k=
ey for %s family %d (%ld)",
> This is changing the format string for `err`,=
 which is incorrect=2E
Right, changes from a later commit creeped into this=
 one=2E But now I wonder why it doesn't warn about the family value=2E Will=
 look into it=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2342?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit=
-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 2026 13:10:12 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>

--auwzy/Gl/vU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/comment/a4b99114_511d3a18?usp=3Dem=
ail">Patch Set #1, Line 1909:</a> <code style=3D"font-family:monospace,mono=
space">        MsgToEventLog(M_SYSERR, L&quot;%S: could not open interface =
key for %s family %d (%ld)&quot;,</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is changing th=
e format string for `err`, which is incorrect=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Right, =
changes from a later commit creeped into this one=2E But now I wonder why i=
t doesn&#39;t warn about the family value=2E Will look into it=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2342?usp=3Demail">change 2342</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2342?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2=
ac2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2342 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 13:10:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>

</body></html>
--auwzy/Gl/vU=--


--===============5963982047906473631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5963982047906473631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5963982047906473631==--

