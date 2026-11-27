Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210A606A32A
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RAOFAytq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iIwqJ7zV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QYAoOPb7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c3B/thCo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tyyd4RY7omagydz2POTdRB4dx9qOVkfU3eE2sgB+66E=; b=RAOFAytq40UZOj1dzMosqaRYTA
	xsJd8oLDZ9qjdWdUmFlEtgftX3+9Y7rdGecSPvw0iO1DNbrisJbI/zklduEhriofnmP0876fX1E15
	S22vwK9izbKe7ABdSpXWWwDXQpt6G4W7uFveoNDn2sBit4jILsacnk7P28dRFES+VZfM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWufL-000000007pm-42jJ;
	Fri, 27 Nov 2026 12:02:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWufJ-000000007pf-0sP1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=85BpWJpoyMQDyb6A57QY7Vf6v3XPfP8jsT9U3jg7zBQ=; b=iIwqJ7zVZFW2BZP5Tez2kylWF5
 xg7794IieK65Lu/0RskJ7lJixQPHxwl7cyfvL22EyIg8naE/aUtqlpeMPaHmXesRhzbFYi+LR35yt
 BcyJ8eOU+zcIIyFyql2lYWrfRrxe5nCPu+ObTw+GJnTcZXDYH/dFoZg7tlfJaskXEC7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=85BpWJpoyMQDyb6A57QY7Vf6v3XPfP8jsT9U3jg7zBQ=; b=QYAoOPb7iJZPg6evTcrZf/M1Zk
 qb6STCCZkExoLbKWDi2k8uQ68MQmXgmGe/ZFB6yehbGLV66scB1RGYShwab9KXjR1tH29Ek488fCQ
 OKsCGM3TVVzujOxhnozdAETiHszHFMKJ3bn5soH2G/qRe2NcvrC4iEo2+tCwiC5LWGSY=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWufI-000000002nJ-2F1U for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:57 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so78732085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795780970; x=1796385770; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=85BpWJpoyMQDyb6A57QY7Vf6v3XPfP8jsT9U3jg7zBQ=;
 b=c3B/thCo0cIQ7+ObGvkv2dYYUKX8W3UKImfLAN/F/rlRKoKWH/JRMAAdzla1WEJ56t
 r5GSrxcVyD1tUuQajAhKJqyqFQAKQlQIy4jTHBFbukuf7GVYhVgJUapYwu+zB4pu8l9q
 MfdC7520VnLqVBPIe3qezEitOdhYgTuFiyPWtr7gtLXr57rqlDmYqHcLzPkh+OmJnfvD
 /WY4GOycInrH0p3Iq09ONFXkFoNGEsaXGyWoD5uh0a/IFOUpEFCwc+Qzgd0AvRg4ePdP
 WI04jRhpEDncxe8cs1notcwRJ6A1LJr5cj5FTh75fNTb4cY1wJottBtgMxeW3rA8c9Rg
 P76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780970; x=1796385770;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=85BpWJpoyMQDyb6A57QY7Vf6v3XPfP8jsT9U3jg7zBQ=;
 b=vwpteYEaL+qcIJiqCIWesh1Rz9XDyzjpZIpKIVWtq+vnYS1YKWg1oPDyZsFd57X8FD
 2bECwfPo6HiAQcDx52pAE/aahWIeyAIC4mdwhGjJwi/3xoqODFO+GvnpXmB4LOHAaHe9
 sZMpSQttycJFiFO0/vgvs93qHFo9+iY8MWHJQcMszgjdRQizQjHxrs8fgNdQScqW9dH/
 PzyGKNRa8zNsueeOEftRkOtXPZgRQIZJU2e0q5g7TEAMsJF9vh3Ct1eckv56TEYgohw1
 SXv+ojCTCk9l6mQPUVATeH67bYDiRLVh3AZrTbTg8c9Bm3D/LOLEvg1bA4+vaEui0u+k
 /RBA==
X-Forwarded-Encrypted: i=1;
 AL+hErGg3/F1OkQpdKjNLvnbC2LJkGYrmQJgSjxu9IhLX/El5Dh31ZXScsOJFTHpRZyTHZ9vziLX2falF3slcuR+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+frJCymsfTgf69VdoUobBtw9YjsNka12axwq1YA7mE3SPz6MQK
 hCdbPyLFzDQ4ZklAV3/HrpUmhAqiR1kddTijxm9+ogAKXMOjiDU2KDBsZuZ82eUI26/9rw+aWi/
 IeC9qoCtXjRnda8huIMB7/Xy/58GC4T6kZrUO8FJHYoi9f1Ijdv3A86IdLyh5ePA+AQXX
X-Gm-Gg: AZFdTZeoZtVmaCYyaLUAFMEdPU/+Qlq9WTP2Katvyd91h7OLvqAHsge7cibnqqLpDks
 ldeM9mBbwi4n6Lbm9CC+BvDaRerS/Hupi4T5jW5NGOG/qJlDofGkNAExFtV/+lIgvps1Htc+9OS
 /t62FRReGACne4hHJFIkBDWyJGFJe63Oq++3sdjfKN441K2xvj/RZc2TG8G+kvur6pnl6RZEsHT
 cw49EpbEQCrAJfyidItwC/xGdA688xCHONIqzAWmoVCG1KR9RJnya5T3liMuaaq2hX7KuNu9bQv
 UVq1KxqIBBoOx3arJEXcaDRhcqGffkKLzm8D4iYLP3rNoMTbzWsmR+mUVPLAlR2mF1PKnP9wA+0
 AqOqnTmQl363ZGTIpfd2B6a6zIFJSZc05gFlRTLsO2FdZZZDocQVjT5dmiQ9uK6lyi3zKR9EY2i
 mSy/M6IgsniX2cyJOWte4/Qkq9cgvaaTfce1fTKbNB37r1fyas8181JxPmRZVXJhPY0HIOkCXZP
 gVWSU0vMBqNCE/UGdhMqGpgndFCc8mnWKBSjYKnROw+nblnhmrEkd4FdYy9kIwIUeauicd18jSS
 caBYmZVn/DSIW+Yp7IPXSsEnBIYAvwCOIbIyHv5UcB5XRTFIPPABGoXJWDl4+opW+iPtj6begJ3
 XbSC9C6ChVrcAlR+dxSJszQfysopLkVPBRFU6qBSzslBmp5x14RWQhBF9YitzvgIu98Z2haul4a
 ye17QdxaNvzuj7yg0=
X-Received: by 2002:a05:600c:1993:b0:4bb:8711:fcb9 with SMTP id
 5b1f17b1804b1-4bb88941bcemr458387635e9.33.1795780968344; 
 Fri, 27 Nov 2026 04:02:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm437392545e9.2.2026.11.27.04.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:02:43 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 12:02:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
X-Gerrit-Change-Number: 2347
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2347?usp=email>
X-Gerrit-Commit: 16476f1c8868042d4e7ff2f25716adb7428d640b
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:42 +0000
In-Reply-To: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkkyNDc0NzRiNDNhYzdhMjJkMTZhMTUwYTg1NmFlNTY0MzY1N2VhY2RiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d5af07ebd3bedf9715aaf91c2bdd1711089534e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWufI-000000002nJ-2F1U
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns-scripts: don't
 re-evaluate collected search domains
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8801761418443087428=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8801761418443087428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BWmqTRytTFY="; charset=UTF-8

--BWmqTRytTFY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Deri Hae=
rudi has posted comments on this change by Heiko Hund=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail )

Change subject: dns-script=
s: don't re-evaluate collected search domains
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+1


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae=
5643657eacdb
Gerrit-Change-Number: 2347
Gerrit-PatchSet: 2
Gerrit-Owner: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprintin=
g@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 202=
6 12:02:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--BWmqTRytTFY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Deri Haerudi has =
posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">change 234=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
47474b43ac7a22d16a150a856ae5643657eacdb </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2347 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;he=
iko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:42 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--BWmqTRytTFY=--


--===============8801761418443087428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8801761418443087428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8801761418443087428==--

