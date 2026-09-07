Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EF3C79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHzwXbT84ysJvjh0ZVEFP97cDIniva47lwaDTvhxNTY=; b=QfY11bTCaIcM/55KQJ4lMr1frc
	ElOVO20w85SR5biyF/lxQMdlM1SDvY2H8xrovv2cPMQy1bI610kCmEqgFmjJJsJaDudfHo9Y9J99h
	VuLBKpT5eHW6HcnDeJQ6AClOF+M4+kCHcptABGyeQRpiErtWBRR3vB3v3WmHGHjJBor4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bW3-0007Te-Tp;
	Mon, 07 Sep 2026 15:44:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bW2-0007TX-Qk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qoSInPBGRE8twJwHf5HSOhvDwr6k/u9iAS8jSUE2hjU=; b=jsrvaN0JdF5VrQDu3v+ZVzHX0h
 zAsiQRnjiVucS7/d2sEMqvjDhknN4rLyFI1ObdT/PPHorvRI2ErcJP2lksVMp75QogkEJY0ZEtQuQ
 CFJJUaVmMlrFGKpkYdojuucXmPFWQxtoJOqMS7Q6at4ALySEb5jufohx0Qh9GEut2eFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qoSInPBGRE8twJwHf5HSOhvDwr6k/u9iAS8jSUE2hjU=; b=Q
 git5AOvxQg2XF+r19y9+Ht0fvnz6PFNxBY7jvk4W4u+E60KTfhzbCnjwIQ0ll8/o9rD45s8nmwLyi
 RFJ3+1kVpdcz/CITBzQFzJra7HjW5bzSoATpmwFxFQaICWXnfoxHLS3jyw1h9ii5wWUlLJKYLcDVl
 J/AzwGD8OP15YwSo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bW1-0005TA-6s for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:44:14 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so35685715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788795846; x=1789400646; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qoSInPBGRE8twJwHf5HSOhvDwr6k/u9iAS8jSUE2hjU=;
 b=C87O3mM0BsZouUDTV7xeLL4N6l4igp27jZzC+Cd62cGiKuDqMHX3j7cNJhVZ/DlFXp
 1YsG2FJh/KwzdESrWfwHAk966r6EyX6kUINHokEiH4HJZ6pfcOuRVDLlajvFZ5ybVCyF
 s5DtDh02PFOkaJ5DbKN1ZmG6HNGymuYHYKaFeSFOsiqXgu+59ldqtHEFEGWmgKeAfM2P
 //5Rr4IF7JFTYmSVyw76Hvk4b9Li8go1y3B95+4YrXdbGZwA3qtSPLqD16CIE5udhB+s
 3rViom4imZEETojnPNA+GtCsKzh8AKGVwgn2N+PzuLUIZ/+zjHcy51NAOcCUb+X2HvoH
 aEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788795846; x=1789400646;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qoSInPBGRE8twJwHf5HSOhvDwr6k/u9iAS8jSUE2hjU=;
 b=JcxQlxpSxNHkxtppjAkzpPm3N1FW7GoBDLnsHWE1CbFF7WXxPHmqGUhK7T+SoUNQ4B
 /EujNbdlJPIN7mYbqUJpxeZJ5Jw+g/X1svJmeFfgPIpiYX6bzMZg2PRzrrFH9pq8IRtt
 GAjXG/i1b1Y9KZDpL0M2KGl2M8cpaKW1NlhufrPmUNdjTatvtO9LPBG06Bct3jqe2Bqg
 jo8ETe/AaD1sEIAXRhY5WVZIUrpbQo5c8A2BN2ZtrNnWLGuXqPT9dr2+lKdJaSxcpnix
 uxo31rptvK9TlJ9aTEuPCzrWKW1szfQyncI4zrJziNnSBVMHhm5hzrJbIUql901GE8co
 ST9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeCqQwwTQMiXjTLoHGDDJMngAZsSpM5hCSkd/HDxOcMo51GhO9+E8ZMxSExypj6asin7wwhQxNRaI5IJJP@lists.sourceforge.net
X-Gm-Message-State: AFuF++n454yXoZ9hame3iKYCzgqggup14bq9Q5Pf/mtktINix88yTqgZ
 eieZ5UrxQuuaNe+nEZblAd22REh51hUHiY6rMKS0eweXRO7xUZtD8s/vYHts96BIKiX3jN6SKV2
 Y1pmZ7GB2c3asFSkQ6Kwdnvu6p6qieHy/whGFGgjcsZdo5I4CxtauJHcOVWQkRrS4LIQ4
X-Gm-Gg: AYBFou1gPA6XolI0gc4hu91UWwZcSdqgqhpKctJY68xSgBveCgd0tDeRxkZfm4/NtDb
 7IEb2a8SbZTIPbhN9G9f//OP0jkCDz0FDi5Q8SmUAA68PspBfwlXzlJjPCrI1Yvahks8mUY0xVw
 Jmx2LA3AecPZrrt43R7Azxd65RQrEvCl1ZEysFCU4ntUzSvDy7hpbmsO8F/oMDuYn/F7lVplpkd
 Fv4FaIIuxRpvUg3urUc5h0Fmi6yE1CaHNGmk3o3kqvEmj6KO/WFZDxieuVfaEOmo46EIhFCA5un
 5GU+aoEW8OTrLGcFzzghblXPn2EBKTDdHZsC6EbkKMMyqRxbprzSrdbBQNAYOXCoN4ViLrUd9AN
 +yptf5OIaUb9jKv7wJaQoGJCaQih3cC/WRWw8gK1LEqoxkPSjmQ7t/CFfH4qJ/WpA3z/+DCK11R
 mT2z6aIWfc0lY2X/oUOqjdUNqjI1BVT6R8g+R4KqWlRp5Fh/bFgxVYO4BrJvDUz1jdAziPV+0HJ
 Bwh1IxPYN0Q74RVEPvIUazWPayX1NtLHUVu7CjLEPP7+6BRMMv31h+yPV+FY3i2HDGr3fNranaN
 9HTKSDc7CsekOh6il+ykh+WF8KMTfL+bn5EWF5siNGuV3SMrgsw=
X-Received: by 2002:a05:600c:3b11:b0:49c:f7c4:dc54 with SMTP id
 5b1f17b1804b1-49cf82512b9mr412116235e9.14.1788795845534; 
 Mon, 07 Sep 2026 08:44:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm375113895e9.3.2026.09.07.08.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:44:05 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 15:44:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: dc8cc058476b674a71a87f51f25ced18221aaf09
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 15:44:04 +0000
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dca19bb43d6b3aa6a0de7b760971a14f77d2e574-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bW1-0005TA-6s
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8120098822493808993=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8120098822493808993==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j8GGnqBheso="; charset=UTF-8

--j8GGnqBheso=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail )

Change subject: run-cppcheck=2Esh=
: Make it more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868/comment/c34e0e7a_7da256bf?usp=3Demail :
P=
S1, Line 10:   adjust to the verbosity of the Make run
> I didn't actually =
consider the interaction with =2E/configure=2E [=E2=80=A6]
Seems for config=
ure support I would need to fall back to AM_DEFAULT_VERBOSITY if V is unset=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65beb37a2d8223=
33aa888de1baf11dfcb8490e90
Gerrit-Change-Number: 1868
Gerrit-PatchSet: 2
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 07 Sep 2026 15:44:04 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flicht=
enheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: razvanc <razvanc@mail=
box=2Eorg>

--j8GGnqBheso=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868/comment=
/c34e0e7a_7da256bf?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"f=
ont-family:monospace,monospace">  adjust to the verbosity of the Make run</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">I didn&#39;t actually consider the interaction with =
=2E/configure=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Seems for configure support I=
 would need to fall back to AM_DEFAULT_VERBOSITY if V is unset=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1868?usp=3Demail">change 1868</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1868?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490=
e90 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1868 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 07 Sep 2026 15:44:04 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html=
>
--j8GGnqBheso=--


--===============8120098822493808993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8120098822493808993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8120098822493808993==--

