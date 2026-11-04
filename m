Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FEE606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WVI2h1Bd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SBJc86QK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KklCRRLI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U4b6WHDz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CBoEglN0QNOS1SpyshokRRS28snuoixOvi5Ki5HfEas=; b=WVI2h1BdLPxf2e37DjQYSbsfGp
	/n4hR2VTvWFNRKNGpxIQ+KLLaMTUdEAJS+fsxXdZ+HjdMErXj4MEPGQOW3NqYtiI2jkPyQk0DgMfY
	323VBFqXuS8XumkPj1GnW7VZ0Fm3jMKHDdg6tvaIndMtQH5CUM1BlUSxF5JkLu67jXmY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjrZ-0000000068X-0OK4;
	Wed, 04 Nov 2026 22:53:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjrV-0000000068H-2DdV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dDq+Kk25H6s5mEvptpYD6BnUK0RHKI0fPF6vU4i7TT8=; b=SBJc86QKXLXDxClK9nIHyZKJtp
 ZxEnyBSTClOZ8apJkX+0TcWM/Tm8RpYPGWTpRJ4eH+05C63p5tBrfMTMdWoiRfNUTzTezrRkG7Ilg
 jv/+uJy7mMiFy2b9eZe/wDtrmDPpEEEUX/hMbgECVzXbCyXXTD0OYXyC2BriGL5xVurY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dDq+Kk25H6s5mEvptpYD6BnUK0RHKI0fPF6vU4i7TT8=; b=KklCRRLIde74amLCLHyCk4Ssf5
 9jpU+M9WwtZJoE8FeLnCbsCKp0eJHT3a4bxGDZ+EcKGlCVWNLVx8E4l7PK0rRBdAh66AffILRL2EJ
 pjabrx7fw7dC5r+YNPnlSk1Z59RrXlu/UkkUDvhnxQ5kBplUHf3x5j78XWt+XtWpHLS0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjrD-000000003Jq-3yXy for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:53:29 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so11133505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793832801; x=1794437601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dDq+Kk25H6s5mEvptpYD6BnUK0RHKI0fPF6vU4i7TT8=;
 b=U4b6WHDziGFyt98AfYTVHdbFfLwPKT7UXOUv9+aIygRn81JxKjjw9x40AQIx+2ybpe
 whUJ0hjlD+YeMkqMKmoHFhvyl4n/Q+bC1erJmPNELtSkU6F4qwUNhZUR8IgcXJWL3U/+
 oiVfWhyVO6P9h1zsuEFCY+iEIrJANEka11xwm/LozXPPfAP+WLANKQ+YD4+RivHWHZkI
 Reifi5+GCkM1EeaMo+web06jBTXLTj4LfHniYU0qN1hvRHwdjYW7uuDlaG+ywfclb53A
 KI33S5++KSXwXsm0H/Oq+tDlDFzbr5WkME2ayVSeeu/BODBDLfiR1xYHJwKLIX0bzwnk
 QFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832801; x=1794437601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dDq+Kk25H6s5mEvptpYD6BnUK0RHKI0fPF6vU4i7TT8=;
 b=sXyjPPJXPu7OA2+oV1XuOHN/wQ7Fktctw8I5JyfJsdlK50KaXrahauy+v4Ib/2n3wP
 tnQeuTFdvCmAdH+TKdTFZFj7apP2y9wuNglzNGdr/UZoGRonWqiN64/ymdsdlmbZvJbq
 IlP4oX22YIWAbtYnw8lxvlGTGKP8VhISFqQAPnD/s/S/UrAFd5HTn38qV1ViwezB2Pa7
 EpOrUFBfB1CL0egPs73XRmBvFMbf0nUs/j8RP2Llu/yusl2XfrF6y76ICkxx9UMUmoRM
 7e89M6WA+SKZ8O9L0/Nq42eJc2vzVrykHQbEw6x167i4wACqEs231gjsrLp4RaFlDawS
 opHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFOoT2GB1VLeZm6249TkvSPg6DdgsXfrAVQG3dPg0pcaOJY4ZugCZWw+jzbCdrkkkbAa+I2Q/wuX0PAdHQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8uj6qvgZOo9TGlJonBZlHqTvn3ul8YyK0z77YBtKjQLfDhxCBt
 rfIiA/newPH+KhYO6AzTI54CMONTEfMeWSfYDcBuACvLVpnpFlxq4MvtOMqYKIFCyMDL8urybgL
 gLVGddzmvTdXQiN8lVwqBPjnIJ7e/OAltBg83JBmb85iQ5zyQwuKKYCrw9O8QSRLOCyBxt6I6ny
 GCkOyFSg==
X-Gm-Gg: AYBFou1hajrh2Axkl3T6xVpQArxKMVRbP1xZxN0IwPgCNTG9+XmeMD7oGTzx6gqqPkp
 XkSZEuSroeoddN8IZxRAeipjSYPysLlUkrOvRLdikyrIiK9ramFXQ6hueO0rbamPO5a208y3SNR
 XUPnyl2wSplLZmpT+STHmPXxulqlkgS59Eh7GrMGCwLGCog0TXm0/ggMmFbLsOUmsXE7AmXUEqR
 o8k5qTZMzP53UtNPEGDB8ic4CukO4+UB3zdG1aA+XMo+panzsvRpbKZMer6OdKqIgMbZkExaHdB
 KNrSPq6NuUeGU/QVexZE8UHO7wWT/SoWTXGAxOeVNr3gx1Bv5sxwVKvYPyNbDg5VXNhzqU55iYz
 GDPFN441272tdawwUNJ49lUmIh+WdynGcvspDmeZkr/eLX2T3QGg95UZ3KXxQvobIIOkfAuNIpb
 mVhzLsXDxRNcB/eG6EtCuDGV9aHpLIcHn1J2WRdPyQHhvO/EFhCsasm+N4YBBprsHEUV1p8FVwB
 8O51yuzB4Yrk1Bm5TB7TVEh/F2QtSCBYUh/f7HGV6U1fgVH/kYrDWbdwKy3Q1nkiWRQxXH2P7KV
 R3qo/alNcs74o1BUfk7iKOopqo118S0MrF/jzUhOmCrUE1A5cWLMQyaxrfB6RvoFJ627PD2L7Iy
 eznzJDf+Yf29NUMFkx1sTG+nrJmhVd76F/Pjj60E+gsHoLGgmzNAWRNAr3mSNakXF1IEu35vlUj
 KKRHemfjeQGFurEQX4zH088ohFEUf/fiQgsQI=
X-Received: by 2002:a05:600c:a00a:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4ac19802310mr389766535e9.35.1793832801274; 
 Wed, 04 Nov 2026 14:53:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b572caf48bsm18082195e9.11.2026.11.04.14.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:53:20 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:53:19 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 518c4cc724d42f1164cf644fb683549e6347fba4
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 22:53:19 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cc696eee3efc9b3022e1cabb5b55bb8b026c911-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOjrD-000000003Jq-3yXy
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============2208400888193702151=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2208400888193702151==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EJJWaEzjQ5g="; charset=UTF-8

--EJJWaEzjQ5g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=


(5 comments)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130/comment/a19e30c2_69218d04?usp=3Demail :
PS1, Line 1=
402:     over ACC to indicate if multiple ACC message should be considered =
to
> Typo: "multiple ACC messages"=2E
Done


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2130/comment/b73e4230_fc7b832e?usp=3Demail :
PS1, Line 1409:  =
   Overlong message are considered invalid and indicate that the peer is
> =
Typo: "messages are"=2E
Done


File src/openvpn/acc=2Eh:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2130/comment/5d6e8f38_20e1c944?usp=3Demail :
PS1,=
 Line 33:  * is much closer to the TLS_CHANNEL_BUF_SIZE (2048) */
> Do we w=
ant to specify the current size of `TLS_CHANNEL_BUF_SIZE`? This comment cou=
ld go stale if tha [=E2=80=A6]
Done


File src/openvpn/acc=2Ec:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/12dd80eb_41ce3fb8?usp=3Demail=
 :
PS1, Line 195:      * that restrict the message size like TLS_CHANNEL_BU=
F_SIZE (2048)=2E
> Here too, not sure if we want to risk the comment going =
stale about the size of `TLS_CHANNEL_BUF_SIZ [=E2=80=A6]
Done


File tests/=
unit_tests/openvpn/test_acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2130/comment/74bb1b1e_25d0af58?usp=3Demail :
PS1, Line 184:     assert_in=
t_equal(max_len, 2048 - 128);
> Why not use ACC_MAX_MSG_LEN here?
Done



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54=
853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 2
Gerrit=
-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Wed, 04 Nov 2026 22:53:19 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--EJJWaEzjQ5g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/a19e30c2_69218d04?usp=3Demail">Pa=
tch Set #1, Line 1402:</a> <code style=3D"font-family:monospace,monospace">=
    over ACC to indicate if multiple ACC message should be considered to</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Typo: &quot;multiple ACC messages&quot;=2E</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2130/comment/b73e4230_fc7b832e?usp=3Demail">Patch Set #1, Line 1409:</a> <=
code style=3D"font-family:monospace,monospace">    Overlong message are con=
sidered invalid and indicate that the peer is</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &=
quot;messages are&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Eh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2130/comment/5d6e8f38_20e1c944?usp=3Demail">Patch Set #1, Line=
 33:</a> <code style=3D"font-family:monospace,monospace"> * is much closer =
to the TLS_CHANNEL_BUF_SIZE (2048) */</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Do we want to s=
pecify the current size of `TLS_CHANNEL_BUF_SIZE`? This comment could go st=
ale if tha [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2130/comment/12dd80eb_41ce3fb8?usp=3Demail">Patch Set #1, Line 195=
:</a> <code style=3D"font-family:monospace,monospace">     * that restrict =
the message size like TLS_CHANNEL_BUF_SIZE (2048)=2E</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Here too, not sure if we want to risk the comment going stale about the siz=
e of `TLS_CHANNEL_BUF_SIZ [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/74bb1b1e_25d0af58?us=
p=3Demail">Patch Set #1, Line 184:</a> <code style=3D"font-family:monospace=
,monospace">    assert_int_equal(max_len, 2048 - 128);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Why not use ACC_MAX_MSG_LEN here?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 22:53:19 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--EJJWaEzjQ5g=--


--===============2208400888193702151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2208400888193702151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2208400888193702151==--

