Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F35EC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzj6Um70+kO/dZ2x03aWjS1HuFYyvRyxJm6PsY65KdQ=; b=JlspIPq1BB571lyGPMEBtipyrw
	VV9DZALa82MWhiodO//5mQxT+kxNW6ZXT91hLidz4x6ECwOWQW7CBlMjwY3ZjMROo6ODZuN4uuDCK
	6HBGetIOrbcvMuYCtRVTE9zcuCrD6C//rrCF1HNj7RlvBDrB0l/c/GETbWvJ+OQV/JP0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvvqu-0000mB-8I;
	Mon, 17 Aug 2026 11:50:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvvqq-0000lF-6F
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VUDP7ZZEKA1cD75yrBihms9mABXsxE6Er1/x0fGaYEg=; b=EzhyGBJVmE0rPsxypHhprGHwrC
 +u+4ZTC8Q2YcpfC2XQFvVW6Wr6j53yHs0FxKmJrVpmadw5PmVegExX0hLxxZTOnu98uu21qHjpf5S
 ukkWaNs8bO0CaFW8pjK+y6+Y30fkPOo/kjyIEziuA3w0IXHz4EMeJZIwqk1Q4yGVIVAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VUDP7ZZEKA1cD75yrBihms9mABXsxE6Er1/x0fGaYEg=; b=Y
 rsQFzK2EUfsnkAnZmidyTIlQvq3vrfmSquVbQ/LupxmunhlN8B4D2sSBeK2gwKfXXqTpaS+o7Z2n9
 L7PZ/k1WgqIIICdH7EJ6KplvNPMLBYRmubD0pIfCWQ/EpfTzUXTQxGVpkNv2s0S/BgEs0HPE2jKBa
 10Zl87E0rLzwHuxE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvvqq-0004CJ-9S for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:50:00 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so21823875e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786967394; x=1787572194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VUDP7ZZEKA1cD75yrBihms9mABXsxE6Er1/x0fGaYEg=;
 b=UV+nMetxlYd6C/fvYM3PLgdsRrQZdWhMa6i3rBornCttgCBCPVmvNlZstvDXdOopMh
 i0caKyxN3qwzOW6L27EOxCugX5mnf+HZOEGWoWGdhxx0U1aSX6NSEV5284iAyqWat7aR
 YiibRezRooe7tevLHvRdjsf22hiEpN8UUmB4G+Hg/6kzIOPmVnr2zAeG1YhjZGBial4K
 jYQTENjTN4CuKWJqIVHly+ObDsdJfFS6xa6NiSEUER/LdmJB8uGK2Yy7fXSOXCyTQsT+
 pz6KFRr7j6NT/58J/+R24/rOwNriGaC5QnsPLCU1Tzgtgd+AlPD7AfIpuECLF9QbRvy8
 LFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786967394; x=1787572194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VUDP7ZZEKA1cD75yrBihms9mABXsxE6Er1/x0fGaYEg=;
 b=k8BEq6R18pNbE+ejejY+3JYFzUuFCY+56xet014wowdlOdtuYlvvSSY5kpKLSKfguD
 QyU9MueLYzMl5XMGsB1AaZdCV9VTVde/gyosd0QAZaB7n2+YUUkou2V8PfFqSfuumDUi
 Nl5C6OgrvUbHT5AzkD4QHJkKvUI9pshlYfyNWpvY5ly7QmamLh3ZzmcOQMTM/wz28maJ
 3dV79LQM9xpnu3EEgF/bd64Lqa3Mkg+zpzr+c43l5fSPPIMjhzvWBdghcfGkyLL/0NfT
 DaoqYeYpNBkimAo2CqWLVnOmH8gNnSi12w/RaQuYTrx5pQTjkPnQ1R9iCxAO3W2Hm9/R
 oiSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxOd1z/NHxFhhcWDXXQ6dN5xSSQpOaUGlT1R9M4pC8ii+LKRApSN0dWC5knmzPUpoK3RGS6iWI5hqF1IWC@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyj/eHWOmrbJl4f/Od8UpKs31fPzbBgTxJ3kTGHyGCXlLePDkOY
 aAbu5c65OhFpVlfaYwztgf14hzgl17vZHpwKXD+5M2yuzPPAUlANMI2lyY6H4kw38553ruCbu8X
 W1Awmb8O18KJ3DW75/k4g44VcxQOWCJn6uJ7uwRvVJScWIa+euGax0SWmTVxfdWx8K85YR3Ccbw
 nM6GjDoQ==
X-Gm-Gg: AR+sD128zcp5DQhzgekuntdn5kvW6+TgV+zuPkTwVlEWNanbG5Wnjo1MvTmY8AZb6R2
 c+No5NwQEZHpzp3GC+oTnlPLp99/Yklfu5O5P2NKZe6i1gJM0/slE/Ik4PSEJsxyOPPUUkthVa3
 2vbF6qKYj3XFevFfP+vDZU5gXQBxW3cFd9lS8HSklovNoCGv3HyyOQiT80FGfB8EEo+JbHDeIjL
 wC6J55SvrE8y8iuPsU63fJDrpZt4pG9dSaLciNz6lrvDmS6ydrbTOlojDLmZVQ4vtD+gGvmTdkG
 mJa1fOFDhM4sk2kMcJjfTZEhGFJY+IOvfwtOARm48a9AsoQZUXmGcZxorbv0ZVFJed45mQlMHLj
 Fiv588f8ygox5joXHTGEDZDSek/zeAGNXY9rtztLEZ/Kbh5QLr4ScFndvIzx61dxDbOIQvoNFYs
 0QHhY8f/zYSoNqDXf6Vvsi5xPKnxNA7aTO3ao3K5kp12NFR6uh53OZYllEoP+xKqWiwhrBIwmGG
 w+m1q0rM7vy5dsWdnwSYtJEDV4lfHzrmxj9n3U/LQLqYnWSlWKgCYYcECeTWI5xjdzOver10a/D
 VHwqFa/f/dc7B0k5hyXUw+F22uCP88ecUb18CIabqx6Cnv9Hmmk=
X-Received: by 2002:a05:600c:3485:b0:499:8758:8cb4 with SMTP id
 5b1f17b1804b1-49987935eecmr391707335e9.5.1786967392695; 
 Mon, 17 Aug 2026 04:49:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b2a176sm280158735e9.4.2026.08.17.04.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:49:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 11:49:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 5cbfa5d1b07c85e67b6c53b8262fd1b63b352e82
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 11:49:50 +0000
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed8d1ffba3685048a0bc273aa135a1ec14ac021a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvvqq-0004CJ-9S
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: advertise a
 connect_lifetime in the probe reply
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6135743251800603541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6135743251800603541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/UhF/JgV2SA="; charset=UTF-8

--/UhF/JgV2SA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
768?usp=3Demail )

Change subject: oob: advertise a connect_lifetime in the=
 probe reply
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 11:

(2 comments)

Commit Message:

http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1768/comment/8ac540fc_47e3261a?usp=3Demail :
PS8, Line 11: =
handshake shortcut, letting a probing client reuse it as the server's
> the=
 seconds the reply?
I will rephrase it - A server answering an out-of-band =
SERVER_PROBE now also advertises a connect_lifetime in the PROBE_REPLY: how=
 long, in seconds, a probing client may reuse the reply as the server's HAR=
D_RESET and start the three-way handshake at the third packet=2E


File src=
/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768/comment/d=
db4cfdd_7887bfe7?usp=3Demail :
PS8, Line 258: }
> This scream that it needs=
 to be refactored=2E [=E2=80=A6]
Agreed=2E Reply is now in/out - the functi=
on is now only sets the peer's session id, so parameters list goes from 10 =
to 5=2E As a side effect, commits adding --server-probe-reply and connect_l=
ifetime no longer touch oob=2Eh/oob=2Ec



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Chang=
e-Number: 1768
Gerrit-PatchSet: 11
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 11:=
49:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-=
To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--/UhF/JgV2SA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768/comment/8ac540f=
c_47e3261a?usp=3Demail">Patch Set #8, Line 11:</a> <code style=3D"font-fami=
ly:monospace,monospace">handshake shortcut, letting a probing client reuse =
it as the server&#39;s</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">the seconds the reply?</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I will rephrase it - A server answering an out-of-band SERVER_PRO=
BE now also advertises a connect_lifetime in the PROBE_REPLY: how long, in =
seconds, a probing client may reuse the reply as the server&#39;s HARD_RESE=
T and start the three-way handshake at the third packet=2E</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1768/comment/ddb4cfdd_7887bfe7?usp=3Demail">Patch Set=
 #8, Line 258:</a> <code style=3D"font-family:monospace,monospace">}</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">This scream that it needs to be refactored=2E [=E2=80=A6]</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Agreed=2E Reply is now in/out - the function is now only se=
ts the peer&#39;s session id, so parameters list goes from 10 to 5=2E As a =
side effect, commits adding --server-probe-reply and connect_lifetime no lo=
nger touch oob=2Eh/oob=2Ec</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6=
c2246f9d9c0a505292ee8d879f714901ffae </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 17 Aug 2026 11:49:50 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/UhF/JgV2SA=--


--===============6135743251800603541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6135743251800603541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6135743251800603541==--

