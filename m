Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EDDC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mrocS2S40ffI3ecMaui+c1Xb9N4s6QJNZWtjxUUeg2o=; b=m6thOCQbr6XPiBbjaX37oM1QgN
	MLcRM/Q3Z6IJiTwmCQ6Jy6J3BiYXbLqz9tSC9KsUHUERQ1sY1pPm6HvPnXPRV4v0GAFWPhoxjGT72
	VolgG4lKoL0FH5PaKdbRsl9dwgSMOFzWBpxPzzPE/MXMaEpF2CcbvI75LEw7zMdY6Fn8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqIT-0003Ez-Vo;
	Thu, 09 Jul 2026 15:04:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqIQ-0003Eo-W9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=644UJlfqibK+o+xAwMH3fjJcT5kjFhbAurIDBZKJe+U=; b=RCmAK22Q5aNu606IUzHa8kOvv7
 tLAyRnRm8rroWoQUACqcVLdQy7owij+xSpyNlnl30w0y78hBPnTTlEKH2t1gA8dEfq5tLlc0Q37i3
 00KVf+u82OIHrJLAkaOhAz1lvTLOAeoS4il2aHVN+/smNBE3C7pZ2GImbEhBvC5yiwPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=644UJlfqibK+o+xAwMH3fjJcT5kjFhbAurIDBZKJe+U=; b=d
 /6ASsrShcUDDHPrRBEHMV4sFTfUoU1pa4ua000/oAiH6ADWWZUJVCKWYZfGTn5thaOK9y4UfQveuM
 71We5Asvp7RV7R2TD02Kwvh7vkjJrHZ/L0b74Y5NWLftnOYBmhaxh8Qepps2qozEXHF7aQfIHU5bj
 BMaw3KS/NoVjfb+M=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqIQ-00067j-9u for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:04:15 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47df6a2c809so266399f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783609443; x=1784214243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=644UJlfqibK+o+xAwMH3fjJcT5kjFhbAurIDBZKJe+U=;
 b=gyawECBO+hagEDbiEpmLSrLvNoYv/KiKswFZ8NvIWsIUQLQWqWip9Vay1WUysUZvAz
 m6fNKdBqoFUtzq+giSR51L/3oUtgAbdjxiUK6Pk7zlDUXc9WL5UQz+aodhAnLhxJ5R4/
 gRBc7Ln0bBuOi9YzW1tzab2d5QPpeuU65eEilTOb+IbqdBp/x7iYyMgUQYVzadlglFtP
 hqyGW5DdBHADYGmagL3yFRuGVBZXSyU37Cu427ixGFuIhhJOdTZ4S3eR7dMDuPfmBgAR
 t1Io5j2BXckYSF9UuhFmFpKJzHdtnarw6oXu56SkIkhvhT5UN+XBbxLEi6TO/1ek9hli
 GZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609443; x=1784214243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=644UJlfqibK+o+xAwMH3fjJcT5kjFhbAurIDBZKJe+U=;
 b=U/lDkzb0z+q+E35aNCeTbJDQvc0qLbD/53tZIyc17S3Wk9i66aflaMPF/VExdbXqIz
 hmzbfVnCH6uW9Ypm2L6Q/Lh35St/aQAmIrcvdJQu9Dw6rv+/aEhmHxYy/Ld57Gflnhw5
 nXzEO/s58ixNaCoacsIv7Ycx3cr0qFQorVQ9IORqGcZMdJqz+p0K0or2xsOD7HQgonCs
 fvhbNBzxZq50qJvYgFvgXeoTpNKhnQY+l22L/UKgTi3YQ4zn4pFJosqz3OJmC6knQiSz
 uQef38I6BNzVWaDs0bJ+1Tq76TB/AzNmFTJ74/a9LZIAMn+hWv+LXj6eKW+saUpayF63
 U2JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7iteT5KvPkHlh0hk6drBquSYleCIXOcU1m+buBnjCkc/Rjh3G93AVNZUy+diQwT9XUHGcXsBJTspJdm1D@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxBchOIq+hXBRJLtp1UrJcTntbtBLAHvKpzcD3gBme/gQkKt19e
 4mekWoMDcWFBy10Ijr3CKOhrDaApmmFNNoHIposE/JAagOZfA5f6Bo+4QmbLBxy08cn1G4ZXY3h
 thZcGATN37YVdEXCQ8RMfjVDF9ph8pBqjQVMsExk3qTmiyVVML+zhGriIOJm3oBh8NDSZzYFgNg
 Qk2L0z/A==
X-Gm-Gg: AfdE7ckSY5872k68PE6UwpbT1AhCfysnm44w+wcNd0wmzetYE94sy5DkSerPA3Ma2MO
 NScrLcBRdIDzNYspmHEO6+5bIcS2A7MVAOyRX1zaOH85UkP0hL6qG7emGHCVWVoSP0fRzPhsqLN
 6ZZTsjE+tGCMdMx+ktA1RLgwq79/gfTiZ076Q1MIfg9cZ/u57mRdEg5FIyu8/2w1xwfDKpbWu0s
 Q8CTuEoq+E7+ZJIiiDJHdtOJUsSLzmGaRx/tBQdn4qpqL0/xjZGOL9zfdIuZdgvHfmGtcyTSAru
 L6jXiSU2qv62MzrYXrVQDaCLuit8EPKiq/aLlmhp/X0Qr/XbbDa55RrvPTL0IXMRkLCzeF2Mq0i
 EHj2FmHF4uGD1YfN5nQuRQFzPM6NMFL0iPcm9IH37AfZuu2gzGsTXFCjJ4n6fq9O/XUJzvdqqXm
 b1Ae+x3IMbUkB4aoJzimpD0kR5ak+vyTPFxbOlQlg2suNhNiWIl1r0frnbEy31AatgyRQxnY/t3
 IfiTdrUWj4Tw4eucWLNecrPhWW1ItTxE9oUTbQ5cvAJRYLuk/03anHqnE36uIyG2copKlsU94Ny
 xWc=
X-Received: by 2002:a05:600c:3b2a:b0:493:c182:6b08 with SMTP id
 5b1f17b1804b1-493e68ecf7bmr73464455e9.36.1783605733485; 
 Thu, 09 Jul 2026 07:02:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm113454875e9.2.2026.07.09.07.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:02:10 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 14:02:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 225628306ecc72d5b7b06c16d88ac5f271e56b89
X-Gerrit-Comment-Date: Thu, 9 Jul 2026 14:02:04 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f538306fb4fff67e7bd031aeb8fc8e2286925808-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqIQ-00067j-9u
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1565307371329811576=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1565307371329811576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e91FHCLL+1c="; charset=UTF-8

--e91FHCLL+1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/oob=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/ef87b237_5a6142ba?us=
p=3Demail :
PS3, Line 62: #define OOB_PROBE_PARAMETER_LEN 12
> Those are on=
-wire lengths, so sizeof(struct) could be wrong due to padding=2E But let m=
e derive from wire field types instead=2E



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Cha=
nge-Number: 1741
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Thu, 09 Jul 2026 14:02:04 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--e91FHCLL+1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/ef87b237_5a6142ba?usp=3Demail">Patch Set #3, Line 62:</a> <=
code style=3D"font-family:monospace,monospace">#define OOB_PROBE_PARAMETER_=
LEN 12</code></p><blockquote class=3D"blocks" style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Those are on-wire lengths, so s=
izeof(struct) could be wrong due to padding=2E But let me derive from wire =
field types instead=2E</p></blockquote></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">ch=
ange 1741</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jul=
 2026 14:02:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--e91FHCLL+1c=--


--===============1565307371329811576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1565307371329811576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1565307371329811576==--

