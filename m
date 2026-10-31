Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B3606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K7BtNYoj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IT+dGv2f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i677haz1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EWpc62SI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/HXH3exPPe69YRCREsaRIzP/2ui5e0v6PHsi7pOIjuc=; b=K7BtNYoj6fiwQC9z2CvkCHOQvG
	3L9f56K/JYvMf1c2CyGiJh0GdWwvbJKAYDgCGkC58CIcwMETWXzHsnlsevUtaYGM42uBR8Jjx+HSg
	YqmVjqWXqLlZZfgryqWuXXur8HIQLAC+FSk/6t2ry8+hybu+Qc+V3QAv9qEhAo9QkQnU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8Te-000000007Xb-3bXJ;
	Sat, 31 Oct 2026 12:46:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8Td-000000007XO-20Qu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YjwjmQdvjI3/GTJjVO39dHPWSc5zAge19MGuaiOE/JU=; b=IT+dGv2fy/fwXf+VkZEDK85xqr
 xeIyG2ptqn0sVMuMS6LS9sjeE2FhHP2BhP+ag6RlY6/Dh9CNUGUdBqagF2Uq8c63piTxFnIQuHs9Y
 c5NUSjUj0f28o4sjZ0GBpoRTvPJtpkE1Sg+VAdi/EfBajAuPBHjfANRbaEYPj3ljlJxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YjwjmQdvjI3/GTJjVO39dHPWSc5zAge19MGuaiOE/JU=; b=i677haz1KA/FfZj07Iqz6q53MB
 FgFV3eGKqeXErP47atAYmhUEJrrHl779E9jUraGp13dAXSbitqoHuDliHIkDK+NidDLvuQnrjkrS9
 jOCYgrjqmesOG2ECBcaCUtL10d0dcj56Rf57k1x67cFSslh1SalhVoyD3PJOojlZHwhg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8Tc-000000003Tr-1kYt for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:46:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so12321225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793450782; x=1794055582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YjwjmQdvjI3/GTJjVO39dHPWSc5zAge19MGuaiOE/JU=;
 b=EWpc62SIXBrbMCIy6Y4pcrQqVIjrf366RWVNfLkiglaYXDeqmoqjjZaE0mlx9lzkrm
 0e08XdQ8dpinpMFem4m78LG/Yv1lCbBVGKue+Ox7nGTxdY/LS0Yvxb3KJdHwzrGS6tqU
 +dW8l4BwfUbhfNlFnUENSWS2QvN5z86sBgfMQIxGtul0jYoAOCH2w7NzeGpeULBirIeL
 cuqoTYPpc1Qj0O7wbr13o+6PJ0t++k9dLh7PH97B7q1eWMV6VjsCNiUr84jGIDB3mjFF
 rf2gm7lW1isTbrpZjQi5a+ESnUdzcmIB2DrRlki/nt7V21Na3OGT3oznjm4hFZa7zDns
 OClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793450782; x=1794055582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YjwjmQdvjI3/GTJjVO39dHPWSc5zAge19MGuaiOE/JU=;
 b=X+VrTLfKGTosMYEOpZ9muIdkacwdUAEuBib+eBRTGk4i7Pk0MBw9sVcOzo7sx2z7Qg
 Q7YvZIVZtXen9afouQJwYMvQJW4moORY/fDQjKklrldeecADWIge+xsOdWjvqqKdJp5E
 gcdqeUFOmwz7OizYgv8tBLVj2XgAEFbQbruda27JSpjkp0tM4ISd7phoVdwztDy/DpmY
 twosCBF9Mmn2C6v9mRYpLl/v1Zb0rrj39uEpTMOYuwS11y+3sJtHD4F2mZWlMzvlAj5h
 coNXRJRrq9+xTjPOJdDaHvxF3ylR44H4VBwq5QLPBjrIg9Rsti2L1LIOh2x3rJ2bGM37
 uAmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfgh3+VhSwSEvMV98l5J7QlHM5vwbl5IddjJJZcN/8Y3RsvwsWpsu0/i6CL+u7iLCeivSsiJ9pQqzWFv51@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ3gvkDqcQaZyYsTlsi9JFqNOGQNHPC08lqufDnXzx2VHq2Ctj6
 uNKb44TAP6q8spi48jXI5PhgGl5/r7D2ZGNR35lChSGUxKJC9uKEKjGKKa8auQb0uO/3sjL6TIG
 +l+WkR8zGLjx7ORJHsJs/ycr/WKOwQJqY+prgMhEilZny6sRmBnmlTWzQBqqhYyH4Jx1M
X-Gm-Gg: AYBFou3DwOz7R+6zKTLkCVbF6932Tjd2IWv5nXeaffJJQGcBJ1iFAkT+zxaqs9bP4x9
 oBfJCVZ1cwYlKtGoe9f1yymE9BCBCyIa1gx4UZIVUqX/VwFiAuh8XUfIPPFY34jCrXc8W2OPjps
 rx5Swp37o7zW4DQ7rO1icNyJQ64eAl8U1dHM1AzCwod3EjqXM6AjmiN0HThiVL7uS63IYuC7t1y
 N8h0qgHdmds0wY37k/pY6SGgMps9FTVmAYUwtKBvXj4gcfhVig5V/RDDUQWp9OlPnp9QaRnn7Zx
 ReZgUtoaaBwtA7wZ6yD64pWpe/o1FC6iUbT8/0fg1BEN5uciPE5aP79DG5fMgf+T+qRFI5Dp33J
 Y9gVX1+ZkwNOEiPk2C0IORhBelWf6uW7t5a3TsSYK8L7pu+IBkdJMTPzpDxi4KyOC7tVx9555I9
 vYu+3AppUvHQFKR8zJD4X42HbtLp8M1fFg4ckAWNwOI0S1fQS3qoc2wWF4OliX8XIa73QZdhGAX
 QRoyWVJFxu9cWzEGJ+H90AMkSNdP1G9MTr0v8HbtYy2uXkmVETuIw8H5xt4Klm3sgrkRDLdtpq7
 8JQSGKsRfXVRYAwALlbCylVq+w7Ei1IVVlPNSXVeBmSipOvR0SEFQ7Tvx4XqIbItoPPDn/QfyL7
 SvYuvAlCEcqwIQDQh96ZWmZ+EfZfSfxr/Cz4hDdraS2oQ4clQ62S5wr47zYtFQh1NthVHL7hcUD
 mOkMSv55IypzPenFU=
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ac180f1b83mr122378965e9.23.1793450781786; 
 Sat, 31 Oct 2026 05:46:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm169164615e9.12.2026.10.31.05.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:46:21 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:46:18 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: a8c2f29887fdbbba850e5ebfa735968f0aba608a
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 12:46:18 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e9ecdfeeb281b39eb59a59f217742b04864de09e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN8Tc-000000003Tr-1kYt
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5042990032802857697=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5042990032802857697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d+xXozSvegs="; charset=UTF-8

--d+xXozSvegs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

Gert Doering has posted comments on this change by Max Fillin=
ger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail )

Cha=
nge subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvp=
n/ssl_mbedtls=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment=
/dc8cbdf9_852c8dfd?usp=3Demail :
PS2, Line 156:     return mbed_ok(mbedtls_=
ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size,
> I've tr=
ied adding some checks that I think should catch most problems=2E [=E2=80=
=A6]
Acknowledged



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2029?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Number: 2029
Gerri=
t-PatchSet: 4
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 31 Oct 2026 12:46:18 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Max Fill=
inger <max@max-fillinger=2Enet>
Comment-In-Reply-To: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emu=
c=2Ede>

--d+xXozSvegs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>Gert Doering has posted comments on this change by Max Fillinger=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/dc8cbdf9_852c8dfd?usp=3Dem=
ail">Patch Set #2, Line 156:</a> <code style=3D"font-family:monospace,monos=
pace">    return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_s=
ize, label, label_size,</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">I&#39;ve tried adding some ch=
ecks that I think should catch most problems=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">change 2029</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ebc0d04c501d=
00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2029 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fil=
linger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Max Fillinger &lt;ma=
x@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 31 Oct=
 2026 12:46:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: Max Fillinger &lt;max@max-fil=
linger=2Enet&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>

</body></html>
--d+xXozSvegs=--


--===============5042990032802857697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5042990032802857697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5042990032802857697==--

