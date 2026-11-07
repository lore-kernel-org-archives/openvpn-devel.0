Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CF606A333
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KR0SINF6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KkonfRu/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P5wUwAy3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TLVsKIEl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gbpfcTD+vWgcyPpUSavoaCWfw6FpL2hI7wuIjSLt2Xs=; b=KR0SINF6X34ELCphL/dsaMjqC9
	VY5hbv++ZJ6f0lJGGFa7ZCATvkLNLKWrJW5ScQpv1emoHbz5J4Dbq6jknQ91/XiVRO2AYPHziuqw3
	C141TkjsKDALhXrQfHBcLz7GMHChtQ8Ql+it+cqoZ/AfoDM2Gg+/r8ggXNNEsFxAHxh0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPlZa-000000000f0-1YoF;
	Sat, 07 Nov 2026 18:55:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPlZY-000000000em-42jX
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ueUAmLTcXd4R6qQJsM9d3EN2pcV8usxEK8KtUFNCJzA=; b=KkonfRu/uqjDp0g8WzoyMUj7mI
 t8EzLxWqHBr7+/mulsjfx/5Ec+S/aHGnPcXv9PAGH67xe2Z/6nSMiZ7cMWRV7r1n+4+j2mIfY51M8
 rXNyTWYnJoUYN+n/nV/Kv7Nx4kwCdCNujZ4j2qhMBepAwQNNAJFYmyksPvUPDTT8oJCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ueUAmLTcXd4R6qQJsM9d3EN2pcV8usxEK8KtUFNCJzA=; b=P5wUwAy3F7f8shobZwzJQsR21F
 h2M/WtxzejaYDT5wYcTfZHUPC/xv94y9/10RXXtOQuZDVuslghR2q7UkzM5dHWAno+VVBwe4qOXEF
 fRCx18hnDp4224P0ec0RVHDguHpwJdqHmQ6ygByCT2GExV0DnPELUcKpGYQgEX3Rs+ds=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPlZX-0000000052b-3EmY for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:55:28 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so982789f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794077721; x=1794682521; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ueUAmLTcXd4R6qQJsM9d3EN2pcV8usxEK8KtUFNCJzA=;
 b=TLVsKIElzFUfy5VAACk1sdD3i50ninyNY4oytSxRvpXCZNgqF0QEPsQr/RuEn12wHt
 U2Ds3EuQbT/GmY7SikbSVst18sgHOADHl9/NRXfrYfstsXk4wDbXaUBUVqw4nCDqiSTv
 9j4eXdFx0C9hMcRMxGoyF+F9LC6Ut88vUc+yE6J4cDvOvLUPZ5GhCY8r7BgDp8F5Btve
 yALl20hSUxTwePqQBNkqvwKQWnGVVKNCJrlWn5BX5WpI4iq9px7lTTkn2lVAxxgceaPC
 O3yeca15ArsKw4XqcY7Jg+jhKxsoKsCXN/AJghmzAmnZL1+2dxV3koKAVShx2sjQaoHf
 NNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077721; x=1794682521;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ueUAmLTcXd4R6qQJsM9d3EN2pcV8usxEK8KtUFNCJzA=;
 b=SvtSUj6PbGW92OjspqJS/LY817d8FBmFMeg0FFCxWkKAj/c8J/vl9FnZXNa/fdEmXW
 Pe6+jOj5XRxPQM47GVchMpui+F6Aw8+ojsKZBGISL1j0olZLn3z4aATvXij8sApJt0zQ
 8vdXPXSDQkOnOsJwUTRy+VUNjxdnOikPzkucab7EuikGNhwaVC1d5pCjV7TJOKdzUv15
 lARdTTD1IbnBuEmqHfqBeFwWgBAkS6ASazaouK4WOUbZ5IM9EnpxcZyNZIIpwjzEsoAU
 DdmpWQJ1Ma34j1RM1m0d2BUnLetW+KsR2F0z9SGHfMPGOppTxflg7ZolVd6YraIy6iRb
 pebw==
X-Forwarded-Encrypted: i=1;
 AL+hErFSolYaYBe2blMgIt0pmfppjoX+NPg6EdUpi2V122ZS0cdJNOeQUn6Ii5vMzkErVQZAevbaMRwyJewXZqUS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8I2ihAmQPCFkfPDx2+LOLCq/cPnNe0l9Py8J7fiyJzpnvw5dvN
 TyPzQu8oiHnQxyjVAcZDKHndxy4LlF4eMulqS3LYkYl83MG3qA7hxx9Gx4JM8K10L5HmHTJujB2
 cFSNlqPW2X5A3Xn1tLOxE3HYgA6vfSDHfBxvStOyZl34RFvecNEOD9kTOtGh3rm0vAK01
X-Gm-Gg: AYBFou2idcPRqw5tci20j8YHFBtDVq3ijAW9iRwgrZ93TUy0UFK3N/B9fkETIVw3ki5
 zWCB04Sn3pLcmRcuyY2coVPL2ZWLLouYL/ssfLRwLqeIiJxzCQkYMN5E1iQE3GGV5FIbtMntEnn
 /X5HA+z43un/84IQybxAxT73hQlUPlgjvTM8YNDd7T+eM3XSaIR47Y49fRTa6nIJY1+lUaUJy0z
 S1LsvRHB0UO0MJs/UsceaJOpbEJ9tJXzTXMK5OKJSocBNW4lJscCg4k+dlW+XKZEAyXP5FAKy8c
 csd6NsSF4yXP2kBWpAT9nh/NbvMOoqRyFjKGFWIPnAHlTVwOmMtXdOrKh9c+i7NzsqB/OydAc7k
 maI1D+sSpS7xeMDDdjN7lfw1QbIzDboyPlCTfxasEItCLnLc/o5GK1tG/Ms/Wbwqu2hTQbiP0q+
 XHqbcSM7KjWPjPPU7AvtU3ID9iL+5PpFXN0ZY9HenknaK1kJGFIe0Y9GsqaOB4V3G9c6LNsfiU8
 TA1JgsgFzjmhDpuJ9Dh/OH78IYYIM/E+esuo+xxOHx/BB9jXwVeph5kO563/3/uaauCquVf3pIR
 WyiKI0QCEqNL8fEEGtVXNQc+XwEDXj3Vgo1Gs9YlGt/fycBPCSTSIsda1eCzPg5buwcl8e/uIps
 Tm2QPEeYfQotT5Olyg+axKkLmdzAqe82omjYWk37IlsczKzjC0oYiNC0apJPHXk2HTloOtRB2Uy
 YUx0bHyDarJ0isuw==
X-Received: by 2002:a05:6000:186f:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-492776e6a45mr12796240f8f.31.1794077721101; 
 Sat, 07 Nov 2026 10:55:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d6391dsm11074420f8f.14.2026.11.07.10.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:55:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 18:55:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
X-Gerrit-Change-Number: 2150
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2150?usp=email>
X-Gerrit-Commit: b84bdc3874918f404db839989973dffa373a0859
X-Gerrit-Comment-Date: Sat, 7 Nov 2026 18:55:19 +0000
In-Reply-To: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
References: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkllOWIyNzIzNDg2MjE0MjMyYWFkMzM5OTFiMjY3ZGMwZmY0ZDFjNTM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <23c71b99466889b9dbd2c5fba3c9cbab49ccf552-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPlZX-0000000052b-3EmY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: add
 route_exec() for the per-OS route commands
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1305056378765437199=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1305056378765437199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VY7xHaxO5K8="; charset=UTF-8

--VY7xHaxO5K8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail )

Change sub=
ject: route: add route_exec() for the per-OS route commands
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

=
Patchset:

PS1: 
I would keep this as WIP, and return to it when FreeBSD (a=
nd Dragonfly) are gone=2E=2E=2E - or we go the full way and introduce netwo=
rking_openbsd, networking_opensolaris, networking_aix=2E=2E=2E (which is wh=
at Antonio wanted all the time, and I'm sceptical wrt code duplication)=2E =
 Let's see ;-)



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2150?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie=
9b2723486214232aad33991b267dc0ff4d1c535
Gerrit-Change-Number: 2150
Gerrit-P=
atchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Comment-Date: Sat, 07 Nov 2026 18:55:19 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--VY7xHaxO5K8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering has =
posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">I would keep this a=
s WIP, and return to it when FreeBSD (and Dragonfly) are gone=2E=2E=2E - or=
 we go the full way and introduce networking_openbsd, networking_opensolari=
s, networking_aix=2E=2E=2E (which is what Antonio wanted all the time, and =
I&#39;m sceptical wrt code duplication)=2E  Let&#39;s see ;-)</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2150?usp=3Demail">change 2150</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2150?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c=
535 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2150 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 07 Nov 2026 1=
8:55:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></h=
tml>
--VY7xHaxO5K8=--


--===============1305056378765437199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1305056378765437199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1305056378765437199==--

