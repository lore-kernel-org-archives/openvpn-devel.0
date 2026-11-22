Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B5606A32A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c9WTeO8s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=duCrI/g9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B2LXio60;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WdyradvZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gBsUcNXDmB1YsKQ55ozzd1FWzP57CCX5Sa1naNaqw8k=; b=c9WTeO8sP179njuMWAiY4rGcO2
	QuGmRqraUCesL/DLfgTOxHaHGV4DtKmMRcFHAMwTnd6g4MbbofmteHK2SAqhLD94PkhLL0HAPtGzC
	JhvZJL7ur/JuRfZD7maTe+wEnzfOV7CXSJusdCLznX4l2tOEkBS3+Q1EYZurK913IDDM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV53m-000000001na-1lly;
	Sun, 22 Nov 2026 10:44:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV53l-000000001nT-2NKr
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 10:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmPSBhHi9B/vNTuLQ6uQrpCGnnUn3f8EOugjXpa5p+w=; b=duCrI/g9DYoNQ9Gn3TRiwLYoCC
 f5xaYdDH0Jbk0hIVdRivjzlthhRRNLm8MLorbWljLzuo6Cptud1qtT8aXyNC/nEXOMCf+gUGrGadA
 kub77H5aas+1J1RFvNc/aNQYPepffXmI6nfItuIEmJjTPzZEjQDOVEAJUH5/XksKxAKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmPSBhHi9B/vNTuLQ6uQrpCGnnUn3f8EOugjXpa5p+w=; b=B2LXio60iHOKXkXWTeB3FRTDNN
 zRNTbbzoKa2NVIm/LP2P5z78PAFVII6oR8f98jElt57rB83LyOtPL47KJpo+gAoVV6NVRab9bEVqE
 KXj6cC1HG9yErNaWPckypoiseB4L99SAXb5K9wTHzBUfgpgcOosKfZK/sx0vjzGqv3Hw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV53k-0000000051T-1y2R for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 10:44:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so19616085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 02:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795344270; x=1795949070; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JmPSBhHi9B/vNTuLQ6uQrpCGnnUn3f8EOugjXpa5p+w=;
 b=WdyradvZhGLHzq07c35garRTg9/aEO+H9EQQx9Exr1qYWhtt3ayvJuFFOqhO/gqmUr
 mYLLXK+ZNmR+tf7BAyla2g29qwRKfsgmiVulptcqs51GpsNZmgwK4fu8H3WrZ8ZdALHD
 V0l8eYU7eGAAcO6+RrRtG5sMQm+hjnZMfFT/piiGNrlVIYTIADHZGOCi2GYj6qn6H7Hl
 RTVwk7CL7CKoC4elMry5tuVYmoHUrUv6P2oJa3ewiBZB+0X/YW6QZkMoBqB63gB7A+ow
 hpKco19NQaA+l05c/k41EAYxewGZNgVHEmCjKD4CDs8JuAio9kTCSuoTxX5dN9Fnd5v0
 93oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795344270; x=1795949070;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JmPSBhHi9B/vNTuLQ6uQrpCGnnUn3f8EOugjXpa5p+w=;
 b=s50OHL7j0kCZeQmefVuQziGrnzTl8euCzi3qC+jdZqdnEMc+PbH/c+y2gtJ9o21AnY
 C1f9dJTYk4BOcZPJKH87X7Shkhj0yjFi4njXcoMT/uRcmymqLiUsy/mvivkmsEL1FPVM
 Mvi07KY6DTLo54CVNiNVGrld6TIU7FCcNyPW2wDvYqXLxBBAx3RWKO/MMkwGHj0FRmt5
 a/Z0IQWYtp2wxb+edN3YD+k47WaDeIahmqv4mrPGh6bUmmzWy7Tox4SHgyBHAs16uMB9
 7bS0J3zjPJHmrvlHt/5SA29lTALs2mlyMH/uf4vMo7AMNkqf/jfe3oBbVwII/+gUHXIr
 cU/w==
X-Forwarded-Encrypted: i=1;
 AL+hErE6KAFhC9zuHXWPduXp98BcCx/ZqcWHGiqBbkKToD8KdjEj5unaO0LGHg2LuWbzDm6fpIM/Y+SYnWUg4YdW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8fbjnMmylt0YST8PwFvrIWbgsW3MUx9osr3mrgZARcf/HYDJwY
 QENp4vB5t2RlIk2GPcPhv/YuodGABAdJAhC777MO91q9mUqLjYtsKR3k/AvrCj+moODYpUzFXEd
 tpqOdIHeDUbIRliWH19VWB3hB5/y22GA1PhaCpq66epp13h7sXRIgq+Lreqc16YMS+TEVazeEb7
 KvE0tLQg==
X-Gm-Gg: AZFdTZclwiKW+ip1Ivquy1Lpax79wphvmCHFmioBHiWw8CcRZ2jjg4qJeZTwKx1Pgcm
 oL7iaIZGk4wUMT+7CL4PtpH3Fc3EQxhugehOxrqOg02YHsmHwRRC6ooyV3xDjC+vIIrPV/6RjKv
 x02qkLsmukbrUd53OVLC5aWgIm+7R6XPtlQgEMdIag24HPWp+lYEnCAmy1sPZvxL2hSpaPrKqDb
 9ogHIjvTSsUpBvjEMqnV3qGgnceZI1xNAmmdwkQfVuSuP+1RcRqElaZpt9Scc5TuhpDHmAfuYVC
 RBSNYD7SIbvgBqHG2heaXotJp40IqdiCZn2MF3BTDwgi5zDDpblie7RCFdqQVOOf6MW2/1kq2xS
 tblKHiXBqG3mCEaakUO3XUm6Qy29KAhR9eKUjOYXfj8P16jwFQ3WeorhQs9PRkBCO6gexZKhdS4
 DHpcmSOm4ZHzMDIlZXVXGdHOHeTxNMclt2qK7nVO4vKDN53zM0om/Fk85QovlM6eVt8YFuqgunb
 AEvT8sV0oq7UfBPirBZelgKJcCwhT2ToNQ9Svk6iCAQ6ytuyU0FpN2ZX1LmEjYLSPu/uU+2M7Uv
 tiK/amYbDtXpLyGPqvOL7EZRdN0BNP3hZ0TWTLDlsZE7021Qh3fHT3mCLmCDeq+6r08+rARYhTY
 YBGCHJeo5I9zaa3cCtEdxXSWtwcpRkvZROg6x/iWs5L5XSlcxC+UEABaf853TWgfh3R4muID8sB
 KJFGNlEeb+Kk0e5o3thJC4OfMc/DT00oabK5sy
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4bb8880f29bmr199757215e9.10.1795344269741; 
 Sun, 22 Nov 2026 02:44:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm220958315e9.12.2026.11.22.02.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 02:44:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 10:44:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
X-Gerrit-Change-Number: 2234
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2234?usp=email>
X-Gerrit-Commit: a95dff7ba064193f081a2b93028421a3f890a3e0
X-Gerrit-Comment-Date: Sun, 22 Nov 2026 10:44:27 +0000
In-Reply-To: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLkkxZDM2OTk2MjE4YzNjNjFmMWYxNmUyYzk3ZjkyMmFmYTY2ZGY2YjY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97c93c48024ebffa6642bb6ba023f0ec169878da-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xV53k-0000000051T-1y2R
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 room for the DHCPv6 name server separator
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0072394007823470961=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0072394007823470961==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="psHFyyqAz9c="; charset=UTF-8

--psHFyyqAz9c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail )

Change subject: open=
vpnserv: check room for the DHCPv6 name server separator
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d36996218c3c61f1f=
16e2c97f922afa66df6b66
Gerrit-Change-Number: 2234
Gerrit-PatchSet: 2
Gerrit=
-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Sun, 22 Nov 2026 10:44:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--psHFyyqAz9c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">ch=
ange 2234</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2234 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Sun, 22 Nov 2026 10:44:27 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--psHFyyqAz9c=--


--===============0072394007823470961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0072394007823470961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0072394007823470961==--

