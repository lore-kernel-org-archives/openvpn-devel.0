Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BC606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WHHQiO32;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X90T8ZOf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jLoJdfTI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dg0J4ike
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AZa+aV7xeGkSU38T2garqij1uPVcfg+f2sS9APOEpBI=; b=WHHQiO32pH5j4nBdIeS+RrcRJP
	Y4VLv8rxLSxoBlsf1svZdjnP4oz3FnkMZ6PoZRgysuQ6GAbw1eI8jmxJhMkd7Kk6qo6w8+tQRTBBe
	oj0H/sXxVKEIv+hW6ajgXJOCouB5uPnBl3AWEz/2WzZfPiaElHvQQOx8JZvltumZD61Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTIRm-000000006cb-1dDA;
	Tue, 17 Nov 2026 12:38:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTIRl-000000006cL-0dDi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:38:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=InY9CiQg3EoP7aS/pG+Oe6L84w6Abyk6H5KEEvgVv60=; b=X90T8ZOfD75q5nwP2pNfGUqch8
 ND7zBgcQEHySSjMmDG8QyD3K70c3/piEYnnMcM+qTKbMH2I+eBQ5fnPYedmS+4phuvTBzUyAjOyrq
 Bckr/r1npOsbdy8A+ROxRsAJNtgJwRZ7Ckoq21QYqOz0wb8urqb1nrA8P3r5C8EWN+Sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=InY9CiQg3EoP7aS/pG+Oe6L84w6Abyk6H5KEEvgVv60=; b=jLoJdfTInVeii+c81rPXKOitND
 5NJ+1TrjRgoQLhnQ5U/Z8sXfa/VjwMxLFHUjs5Q++Z+eceb/MY4xN6+GL8gVElksraV3nVtmKHRNM
 IqH3GMrQPSfDt4iiBb7boqpAQR5SFDOP0V+9S0jnF21rcpeFFii004z2OMlwvybj19I4=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTIRh-000000005GO-33kS for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:38:01 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1907838f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794919071; x=1795523871; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=InY9CiQg3EoP7aS/pG+Oe6L84w6Abyk6H5KEEvgVv60=;
 b=dg0J4ikeUa21a9tFWl7HIxV/3adJhfe7Gmyq/0in6Hb36sETQNiehenWcZOA4wivIR
 ahILRcb25mk407sVbU6CoIn+zT56vUQORk2qGufMEsHTtD+5hAdXzWuEB+BSKzIqF5ID
 00Z0+u8c4JYLrmXzGUltwTDNGdSkVhHPycxqfVoeLOddMrQ+Dpw7zjI+L7aib7hDk8DK
 P5cy+ZDht98S+rahtHXE2XPwdODd1zCoT6vMna/uZUvI0m4/+Vq74QtF5BSXhIeeUw3q
 OLM8WuS6lbcvcDJRYrX6Uw185OCEMZk8SXoS+hBLYsNpBcPHaVof5vzQDYYjYFBZ+CBl
 v9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919071; x=1795523871;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=InY9CiQg3EoP7aS/pG+Oe6L84w6Abyk6H5KEEvgVv60=;
 b=2RygNzjiFdUjQ2H2JiWsO7z+00hA6ckeyKJP7BZ8iPRwE5ANEWRXIpKA5B++BXYOan
 pZwkagz9sJdDI1Km2QUwSjdrgR0RK50N/5oZwp1vK25FTj3Upp8+xErRZOmFScar68A8
 ZUL6oDpi46tv8MBRHMYFtydDdg3bmtFesqd6lqhQ0AYY/qp89Yi2vzOLZrIcIXetZVJA
 LFkmOLdPIq9KWT87phpmQ11lgNbp3+o+K7oWdxySPnBcbxfOoH71j2/W+Ikyg1jN/Tf1
 p2ztEVAPeVQvL/yA283RYJqfKPpRVAB9+7OXOwZk7gkP6IOZrItIdgPu3mBufDSklMzU
 sA+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHfkNemENtytSIcCr3vojK+ASlL3tTkuQDG/bGC1Op3aE2EPihy/vKVsvjrmU6tTiMsk4Pm/GeB1Lm/7pwt@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/kUH8OM1pw5iH+ZUXpgHPMH06XglBhAON5w2PAKdk0bZ3Z7Q50
 vzjaH/NgPZfORleFSvYsdhTVgmCEeNBVthHyB9vlCsusEySD09IWQ0LgxT8DeJ/rYnc02M6nS3Z
 Uy1lpNTpspySFXN40zGXjPp6+wIkZaJ/mkIoQN/2/0hp2nSKEb0eyuVgWzKMy3jx74ng6
X-Gm-Gg: AZFdTZfNQB9Dt91Sauhw2XJz8xTxeeWaFQwAfto56/sPt433t5MlAbI/+tAWTGX4dNv
 0OlfPHJR8H+nD3FQ6s8orPJ8JykwYUjlSq8LyoSA3/KdIaheaZ3HUBRgTkz+XNEYmerBLWQ+Ce2
 YgEpoQ6OcttIY6Di/oEBqetPmUze51tvKOMXxtfv8XEQWt5cMfmU9HTfz7oZ1QnJmKqEdQ3DOno
 GJmFJeqtJ1PL9y0jkdV+5maMyrbNjbfUllIWrrrAKaHDvqCyG2h1ZNEkcHqbTv3Ss8qwGTgSke5
 G+q39dE84qg3rn1hhMDwl/+jb+41nKr4823Hap2qNo9m7N/BsFSZW2n5kUSBu2K+hiheP4znP8h
 vuVNSgG8e2tq1prfF65tjtml+j7NLAaGyB+6Ua1IOHkSRVJwfYuG6mC7M1crzXBoAfZmmboQ82l
 jq/37LotyUufCYH70x6D6DTLWSlYRFzD0Yn6Dgx70I5psAQGuv3SNk3ELf3iV3Ba0uezKxlrFln
 kn1c7WZqtx2PZtR4TyjgDC/oh1GU4umqttoh4OzhyJ3AOClMxKESxm7cjO9X3rPWIYC4udOykOE
 kV4PlGjtEvZ/RzRPl3VZYOGczWpthiNuE9y7l+au963+0V7vjVWSa5fP/vClrDbSllWHb1l3+BK
 g9xmi0UdfzeOWmJ0s+428MxMFt+eW4n3JaatRIUz5qIGdzUPWKnfH8kKCB4frs+acHaQM/lLyXF
 03e9rdO24ew1Pz20k=
X-Received: by 2002:a05:6000:46d0:b0:494:6f49:246d with SMTP id
 ffacd0b85a97d-49c723fc541mr20474107f8f.24.1794919070795; 
 Tue, 17 Nov 2026 04:37:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a43d41ec38sm3414029f8f.19.2026.11.17.04.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:37:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 12:37:48 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 1bf5d4802590689fd3d337aad4408f227c0713e9
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 12:37:48 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f540c86391f6f7e020664264c6a43fa013a21b0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTIRh-000000005GO-33kS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1812246466417037018=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1812246466417037018==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sRh8v5Tat4Y="; charset=UTF-8

--sRh8v5Tat4Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici, chugly=2E

R=C4=83zvan Cojocaru has posted comments on=
 this change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1741?usp=3Demail )

Change subject: control_msg: Add P_CONTROL_V2 and the=
 probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 27: Code-Review+1

(2 comments)

Commit Message=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/985988b9_ac45f88=
d?usp=3Demail :
PS27, Line 41: CONTROL_AUX_V1 after them needs to be carved=
 back out of a range=2E
`CONTROL_AUX_V1` doesn't appear in this patch=2E


=
File tests/unit_tests/openvpn/test_probe=2Eh:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1741/comment/71d8d02d_91664825?usp=3Demail :
PS27, Line 53: =
#endif
Newline before this?



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number:=
 1741
Gerrit-PatchSet: 27
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@=
gmail=2Ecom>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov =
2026 12:37:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--sRh8v5Tat4Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici, chugly=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this cha=
nge by Lev Stipakov=2E</p><p>Patch set 27:<span style=3D"border-radius: 3px=
; display: inline-block; margin: 0 2px; padding: 4px;background-color: #d4f=
fd4;">Code-Review +1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>2 comments:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><=
p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/985988b9_ac45=
f88d?usp=3Demail">Patch Set #27, Line 41:</a> <code style=3D"font-family:mo=
nospace,monospace">CONTROL_AUX_V1 after them needs to be carved back out of=
 a range=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">`CONTROL_AUX_V1` doesn&#39;t appear in this patch=2E=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_=
tests/openvpn/test_probe=2Eh:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/71=
d8d02d_91664825?usp=3Demail">Patch Set #27, Line 53:</a> <code style=3D"fon=
t-family:monospace,monospace">#endif</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Newline before this?</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437=
388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: chu=
gly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Le=
v Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 12:37:48 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--sRh8v5Tat4Y=--


--===============1812246466417037018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1812246466417037018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1812246466417037018==--

