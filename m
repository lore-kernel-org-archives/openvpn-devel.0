Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327060A262E
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ASMWM15X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kPlJz5K6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k5tWWiHK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Pfl5Hn+I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F72Iiuk7QhttYBJlA8ZgLAyw6VPy1W9gQq2cHIkajrk=; b=ASMWM15Xwt1ZSTdyszcqUdWmS5
	N/xTFsrN840N1bUy1yQH7RLidi0aRuYCGCKTFWBTzbokAxSava3AC0Jcc0CyNQV3U07CBKE6LRpQF
	PScyGpVuQBc55v2QLdEKExLRt1zEwAlYsP1c0vTXBfGVHm6GC3wv33e5dP3GwOLTAZhg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfrP-000000000Uw-0HsG;
	Tue, 27 Oct 2026 12:00:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfrN-000000000UV-0Y3y
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:00:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tlrSWGJUhgcCq6g4L3YvpGtY1gOKJi/EK45ubIvAOdU=; b=kPlJz5K6zJxE0rGAWI8r7uABCx
 uQGc13/EMn9Z+qR0yEcOTIu7t+oNfnjz0fyzqvcVMWfW6TjqehdHlD0WRNeGkIZJyBG38pWb9O5iw
 NUxeER8a9ZJKkpMP3yQVbUcnjYCIgVJ3cLiXw/M4qQgE8i/QzxXRkJGHGse6Cl7V/eqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tlrSWGJUhgcCq6g4L3YvpGtY1gOKJi/EK45ubIvAOdU=; b=k5tWWiHK5XHIXoiFqa9v6bj0bY
 Gc7agxDoQnhdGj5S3vp8lvHVzTwzKho0x/gV25cjyPg5D8OyH9d124eaBLBF9f014zALynMKP6fsP
 XVV84B3yXiFnqPyPITlBePEVt/6oe91N5t/BrMaXCYA7ObpAOeo241w0Cz4A5Kc4YOHQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfrL-000000005H2-36Ya for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:00:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1840371f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793102449; x=1793707249; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tlrSWGJUhgcCq6g4L3YvpGtY1gOKJi/EK45ubIvAOdU=;
 b=Pfl5Hn+IOM1vPQgrXHZTN/OwJWdFlZBeXZdtiMIv2tKF2Wvy+4oJGAXxETe60Eth2M
 muyLqYeHx25A5m0puTMrb4Plw5yqrczP21dzi2jAUE8ZE0I0G/lkaPyIjYKkFFMtD/zv
 qkXrQEGQkyftX+JnBJOSFKWE6eFRvfQCfa3NxVeni/DX2NvacccGEN3p1Kz8Kpu71M+D
 yr0WySvSItlSKhXq++PHyXIvnZMnkh7y/XIN6clU2czdGVQU0xLTQyk1UbdhlCmpmzUq
 nXSWcSApE5tEoWQZ8Idt3tQWa85pBn1yN/OQnMl6Mf7FlPaQ0ZbvZJtyG4iW0jTgxcbm
 F98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102449; x=1793707249;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tlrSWGJUhgcCq6g4L3YvpGtY1gOKJi/EK45ubIvAOdU=;
 b=oyLoRnr39R2uCZlq4NGwvYuYHExx19WSwKbvWQhXO+DdgAbot+Dr7nsw2zAX7JVUUc
 HE09cyaIUHdQrkwpswL4qfeiZ2sWRoOe4iBBm+JDAc89xXtZaTky14F8dj0nFtKnEsSw
 HTC2eJ4td7c2QU7gZe+hRW+0YVvBL9WwZJ/3t+t4IzN1e7Gx7QRK+YA9q/I1VG/OnsPT
 FDPtvtkyqB/BOMEB0eUFQRtI6yKUWuMfJg3jPKjDHPXJR1OTSDqtnLHJer96abg4OpcE
 XRpuZIZ0Aun1FjTWVvIdxnI5F/PoRnfCto8T4JXxZtfSfBi4u1seyb+aqLYk4dzbwKi+
 9rDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykeMSvkoz4LEmiJaH7oKw+MxFZP1ma+H1Laj2F1PZDVU2f4IHb3ZO8dobgIOu19QvzHItIYzDGVjbWV5HF@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJjry+548T50pm1jGX/QwxwZRXPtyh7ud2wPUNs+ZZlCMg0kwPD
 lJsEHjf4DU7zXBaqBKeg88NdCfzwclFjC7Gj0GcAycyrhZDnDJNDMncEIUM6vv6sj0pMBIbILIv
 xLtypckfVN5SgK6vb7rXDkzejwCXt/R8/UAYVlMk13+3PJZG3KYiSpNR/K3elccS9UENk
X-Gm-Gg: AYBFou1kgv1kyg3IhcLXdU5+lwtMxZmUP1YXGw23Bf+TPposioHW56/egK9QtNRIqWP
 OxID+0BUiOpyySZIRtcdxZEmpuvFDPceWdat70oAEChraj4j+iHjm0ZEjqkUI9K+f6p8Gd8zHfz
 gs1QvXUUMovPft6ru916mdd9yEmjFPn2/vPOvChkMTs2DiMqIzPcxSOp3TCBMVjki0E3sau4iZh
 +tPpzSj/QHi2WbXijZ/v4UziS5UgaziZi8y8KF3uc0ii91nufxlAG1GCmlIqEEzNlOuR8RIkkCe
 dAhUwa2nK5kf0guppnA9IF9b+xj4J2XxX06JEA+d91zIJfzGpeik49SAVKUz30SNrWRwRSZVuUV
 xgyLynnRub7ovupO00f/7+MX/Px8UENSaw7lrt54c8/PY8SexWTTnz6yTksgLJs/3IysBNGPGbG
 TyKpaQpGx6Vgj8unJgwJjJqMoOZy4/n2mvNdaR4V/1f4uFq6kbaoqFgbAkbLORFkpa9oD3Djndq
 QFtk2YHjjIdcASORrgHQSGaQifoAbRGMuyt+6gHiSSEPtK8m5JSdTv2PaFyjknkTXAmJVSP8k/0
 hMrVMkAlZgmL/KnKExDxZheRMXsH3K6azOgxLxfYkWBsM0IqisUMWgjtoWaAbyqfn2P5N9fVYe+
 HhxXWWvTkTMwWC0/xsaaz56X21IS7rUlN3G1iupu+kA==
X-Received: by 2002:a05:6000:184e:b0:487:463:92d3 with SMTP id
 ffacd0b85a97d-48e3eb866cfmr17247784f8f.20.1793102447527; 
 Tue, 27 Oct 2026 05:00:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4be6sm20495986f8f.37.2026.10.27.05.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:00:46 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:00:43 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a890e3661cc83021cf22ff6cd8752e7112c77cd
X-Gerrit-Change-Number: 2055
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2055?usp=email>
X-Gerrit-Commit: 95a1644fc5903f54725fb3ef608246ba673b63ab
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 12:00:43 +0000
In-Reply-To: <gerrit.1793096063000.I6a890e3661cc83021cf22ff6cd8752e7112c77cd@gerrit.openvpn.net>
References: <gerrit.1793096063000.I6a890e3661cc83021cf22ff6cd8752e7112c77cd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkk2YTg5MGUzNjYxY2M4MzAyMWNmMjJmZjZjZDg3NTJlNzExMmM3N2NkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae18b049943f2b079a8801324a8f500ea4a90e1a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfrL-000000005H2-36Ya
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: transport-plugin:
 add sample obfs-test plugin
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8994193119700550534=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8994193119700550534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="erdf7Y55SHk="; charset=UTF-8

--erdf7Y55SHk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Frank Lichtenheld has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail )

Cha=
nge subject: transport-plugin: add sample obfs-test plugin
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1
=

(4 comments)

File CMakeLists=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2055/comment/610d8b9f_77ffcdc6?usp=3Demail :
PS1, Line 690:     if (=
WIN32)
I would prefer to keep the buildsystem definition slightly simpler b=
y always including these files=2E Just handle it with #ifdef _WIN32 inside =
the files like we do in other places=2E


File include/openvpn-transport=2E=
h:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055/comment/350a44aa_7ec27f=
e4?usp=3Demail :
PS1, Line 200:     openvpn_transport_native_event_t (*get_=
sock)(openvpn_transport_socket_t handle);
This should be contained in an ea=
rlier patch (applies to all code changes outside of src/plugin, stopped mar=
king them all)


File src/openvpn/socket=2Ec:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2055/comment/e8f26633_9da184df?usp=3Demail :
PS1, Line 2744:=
 
spurious change?


File src/plugins/obfs-test/obfs-test=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2055/comment/386566f2_34734571?usp=3Demail =
:
PS1, Line 1: #include <stdlib=2Eh>
All these files should have copyright =
headers



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
55?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a890e36=
61cc83021cf22ff6cd8752e7112c77cd
Gerrit-Change-Number: 2055
Gerrit-PatchSet=
: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026 12:00:43 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--erdf7Y55SHk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Dem=
ail">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2055/comment/610d8b9f_77ffcdc6?usp=3Demail">Pa=
tch Set #1, Line 690:</a> <code style=3D"font-family:monospace,monospace"> =
   if (WIN32)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I would prefer to keep the buildsystem definition =
slightly simpler by always including these files=2E Just handle it with #if=
def _WIN32 inside the files like we do in other places=2E</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-transport=2Eh=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2055/comment/350a44aa_7ec27fe4?usp=3Demail"=
>Patch Set #1, Line 200:</a> <code style=3D"font-family:monospace,monospace=
">    openvpn_transport_native_event_t (*get_sock)(openvpn_transport_socket=
_t handle);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">This should be contained in an earlier patch (applie=
s to all code changes outside of src/plugin, stopped marking them all)</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sock=
et=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055/comment/e8f26633_9da184df?usp=3D=
email">Patch Set #1, Line 2744:</a> <code style=3D"font-family:monospace,mo=
nospace"></code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">spurious change?</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/plugins/obfs-test/obfs-test=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2055/comment/386566f2_34734571?usp=3Demail">Patch Set #1=
, Line 1:</a> <code style=3D"font-family:monospace,monospace">#include &lt;=
stdlib=2Eh&gt;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">All these files should have copyright headers</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2055?usp=3Demail">change 2055</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I6a890e3661cc83021cf22ff6cd87=
52e7112c77cd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2055=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 2=
7 Oct 2026 12:00:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--erdf7Y55SHk=--


--===============8994193119700550534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8994193119700550534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8994193119700550534==--

