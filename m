Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31918606A335
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jVsHIfnt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f/yCoQgo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZTCwmMBY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MWp+Dy3r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r6v0cH+YQaXBhK5AyqMPsPqpHSDGzLCZ8sN3hvYyg8o=; b=jVsHIfntREtqD/ifxOm2RPufh6
	NfADll3CAd/hbTQ6mI6KNooFR1yBNsoeDhF8/CcD7uftyzoNyu2acJK8h2ABA+SjMvSX2gya/1iiu
	qcqqbNW+YuIHXvDmni4O0+DdepF67FGiEHRRIKIPAu0/zrglhPaU9AAlQlIrjMTUZjN4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaky-000000004pS-2SRC;
	Wed, 04 Nov 2026 13:10:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOakx-000000004pK-0Ypr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWucpEqZLmrSriU72XBbKjRnlXDFwunrA4P7gZoFr/U=; b=f/yCoQgopMVHOO+x3jqtUFbi+y
 ubudZYp4VMSjEwQwqx3szZz0x+f34BylMi1RitOLY6P3GXfugzvFk53sBo2Y/rFXEvFgvRO7SuMVG
 iSXACdxvluKQYNY75kKc/yyvxACooMcS95ocm9Z2TGDmfPRrmy3dwoTn4OKmPMKSzZgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWucpEqZLmrSriU72XBbKjRnlXDFwunrA4P7gZoFr/U=; b=ZTCwmMBYqO79edCwozLk4Pc+ac
 jsWccSEUBdu4JtCXmZDxCk3DJz5G8txfWk4YVjh4pT21EwfPRwrEwli4VETop14HCaFUYGQYcgE0d
 LAVzIJsaDbqtxOOOyoqyVN2JCx6t6sMIKq/8LS4l5TB/zrk72rj02lHFRYzlJJMzeEfk=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOakt-0000000017N-1Hce for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:10:23 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so271756866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793797813; x=1794402613; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gWucpEqZLmrSriU72XBbKjRnlXDFwunrA4P7gZoFr/U=;
 b=MWp+Dy3rWpYdTb4re+nYvbtrYj1FKuXMFCeRIcEo2rL+bjEavHgyOps8nOZVkTAagb
 c0HU+pumZ4qp7kZRdAME4oAvQ2/cmfrN7PI0QaoQalXsFYCpa2yV6Vvfp2ok91dHoEg0
 btv+SL+k2CD4XwdLYxDdyL/U8R8FheKQ7lPmm2v7POqJD/9SlIsyoVujpOg36EvbFKe7
 pvl/MYigdqEDp2iiGY4yHDAVPQv+OfqHR9u9kBzAVYt+TaREocftnU7//ZaD5rKp7hJe
 8I8yeWDZ8MjngyfnZAVhkbCfKoGRuaYndx5g3Rss0IdY1x/J9RiAyahkjSmvv45ZAEEi
 Sijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793797813; x=1794402613;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gWucpEqZLmrSriU72XBbKjRnlXDFwunrA4P7gZoFr/U=;
 b=Kl8HLxBJKMcMSPH3wQzaeO220h+EPZuJi5bRUfOx/FQy0VvQVeAkZ6zVi+Vr2YD9r7
 DjtGBxG6mmAmENBzRIMnHYKZC0OsMe0d1ytAdhg4JNODoMlo24Jfr+m7VFP2Q8NHDO2c
 HEjzdpcmE7FcGwR/1lJl2i8PMxqfDfrX2Wlnkslf/vLexVoHJdgRABIxetVs8o4uFqH/
 OflbUxCqP4K8PDE3cI7BNCqd2Zg/Of+wFf78k4+U6tN5gzVM6ul5f9/orpD5VBYYV5L+
 MXDKG9kySuLvDVWBuurUCk15jftRBQvyRvGP6g0vWE1tyYh63eEtpX2rm2oMjwTOZGMj
 hKgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4BOkwr3sTn+NnaYbOSkumk+rQ02ssIKmUITcVUImVuN9+IXiTWVCrcBpzTfT6jlXouIHTTepgccWHJpdG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8OQEuHOEKbl7VEvhAZun6CJSsgae6q9NvZilrK2HAsKbVJIjxM
 scXTt1Q9qLxzO/Xs7kW1V679CdWjryaB+889SgSCK8u3LfIZ3zZf5B49ZOGBFH1rm/FwvQevSXm
 o90XjKrKpcym/aSn/9e4HEtQjBSP5NXrX3QKjyZuKrpdp3cpbU9XiPyO2YMXEyR5lTj+mublVgK
 JtjNhbDw==
X-Gm-Gg: AYBFou07OOoiCjc3gSa1nFzNSmMx4ZbVwqzOKziaaT0VH7cIATNQesL7j4dHN7tXi4H
 c6lXncxNdwKg5f96HRumQeGv6lwSTrMOvZjC2+b/LG2kBA7w04KevSXyvfkH90yoixFGhm4yBnb
 7qVQvAPQcR+G3tncn5HiJa2RH9F2f9FC7VzoaXYfxvd/YvKJN/WKbDz81r1Nn6w3tKV9gIgCOx/
 f3TYKGnYKuE0DC6QGtaQ56U+211z5qoPyRkQrKA6eeyamBi6eZkX7TfdMfMKjFvneG04T2R0lwK
 HtS5/5ZY+UwqCOQ789HDOA6Lb6IJNcN7L6VbHgT9y7qexBSFV94Ng4vPGtVNeZkALh4ODdD5Oqb
 NUCSI8g6khhT4SIfx+YTI4Qq3+M9310zy8Pc/m3VSCwJ93Z3naAPQo/+C6qmrFiqjnCIt7uZbwz
 paBg6EV6fB4oigaiSTry0Cr3ze41h/17S5XChtvObHa9NhN0xLZN3xisV1cRXbn7sYlMCZv6gcW
 AMZbLPuAktZm3QEuoRDKJcVPxIgBiFwzC5tU7e9A1iRvL8d5ysDKzbxXFTfQhydG7/7k/tk4QjH
 EH8J0zw6XrxdUH0HgkxtpIci0irCYzDKwLcTS+/UyhtloMlw4w/IrGMUwza+eQ9xSL67PNy3VOO
 vvkPGwJqcT3MvItb4W1MWOmyJZ4j9oXVRASK7148VETYyD1Q8ZM+t0iSnkiUwMfkGEmWJd6fvKz
 eSPPjVPiHE1Jyuzg==
X-Received: by 2002:a17:907:7243:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c49d128323dmr1679692466b.11.1793797812352; 
 Wed, 04 Nov 2026 05:10:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e466175sm68640166b.47.2026.11.04.05.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 05:10:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 13:10:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4209c014003f70b1e0fd21f154d8eac8969d816d
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 13:10:10 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cdeb0dd7745da8fe6c0248002c72c4abc13de88-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOakt-0000000017N-1Hce
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN to be less conservative and improve documentation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8367400309241801172=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8367400309241801172==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g4BGAs6aDwM="; charset=UTF-8

--g4BGAs6aDwM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subject: Adjust ACC_MAX=
_MSG_LEN to be less conservative and improve documentation
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1
=

(4 comments)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130/comment/bfa11e74_9371b7fb?usp=3Demail :
PS1, Line 1=
402:     over ACC to indicate if multiple ACC message should be considered =
to
Typo: "multiple ACC messages"=2E


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2130/comment/a5bae5a4_0483d27a?usp=3Demail :
PS1, Line 1409:     Over=
long message are considered invalid and indicate that the peer is
Typo: "me=
ssages are"=2E


File src/openvpn/acc=2Eh:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2130/comment/7205cdbd_ccbb7378?usp=3Demail :
PS1, Line 33:  * i=
s much closer to the TLS_CHANNEL_BUF_SIZE (2048) */
Do we want to specify t=
he current size of `TLS_CHANNEL_BUF_SIZE`? This comment could go stale if t=
hat changes=2E


File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2130/comment/ee84d8bb_d6892e3a?usp=3Demail :
PS1, Line 195:    =
  * that restrict the message size like TLS_CHANNEL_BUF_SIZE (2048)=2E
Here=
 too, not sure if we want to risk the comment going stale about the size of=
 `TLS_CHANNEL_BUF_SIZE`=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number:=
 2130
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 13:1=
0:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--g4BGAs6aDwM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2130/comment/bfa11e74_9371b7fb?usp=3Demail">Patch Set #1, Line =
1402:</a> <code style=3D"font-family:monospace,monospace">    over ACC to i=
ndicate if multiple ACC message should be considered to</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &=
quot;multiple ACC messages&quot;=2E</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/a5bae5a4_0483d27a?usp=3Demail">Pa=
tch Set #1, Line 1409:</a> <code style=3D"font-family:monospace,monospace">=
    Overlong message are considered invalid and indicate that the peer is</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Typo: &quot;messages are&quot;=2E</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/acc=2Eh:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2130/comment/7205cdbd_ccbb7378?usp=3Demail">Patch Set #1, Line 33:<=
/a> <code style=3D"font-family:monospace,monospace"> * is much closer to th=
e TLS_CHANNEL_BUF_SIZE (2048) */</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Do we want to specify the curre=
nt size of `TLS_CHANNEL_BUF_SIZE`? This comment could go stale if that chan=
ges=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/ee84d8bb_d6892e=
3a?usp=3Demail">Patch Set #1, Line 195:</a> <code style=3D"font-family:mono=
space,monospace">     * that restrict the message size like TLS_CHANNEL_BUF=
_SIZE (2048)=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Here too, not sure if we want to risk the commen=
t going stale about the size of `TLS_CHANNEL_BUF_SIZE`=2E</p></li></ul></li=
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
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Wed, 04 Nov 2026 13:10:10 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--g4BGAs6aDwM=--


--===============8367400309241801172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8367400309241801172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8367400309241801172==--

