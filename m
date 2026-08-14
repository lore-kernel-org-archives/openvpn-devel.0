Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA9C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HVYxCip/vzvs+/y0usmfYbTnN7V0FflkMB8IiCKdhnk=; b=fD7RZcgMyjtUbEo8MzNHfaJZNj
	C61xyNfQN5+cY5xqkFJ98YgcknUDCcl33TKImSMcJH5QLcYmHKeeNritXlnQXNUBFPZt4sRoxNV7c
	rZ2XPzoR/yy5vTwXtcoPfIXS7w7FPRuVvULtXradsYR1WXBjBY+YxlpO+/P1CFajy4bw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqO7-0007JB-Q3;
	Fri, 14 Aug 2026 11:47:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqO6-0007Iy-Iy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2mSrtdQXo5VkYWqWzrhij7AoWR7yj2qPTzrboLQedR0=; b=gGbxVNSdkusGuhHvCcABJE4O1l
 iLKMXyPbmI3yuYdR3zEt+zhQszqqa4GCKkHgc1kzWh2ioIhTH/eiK44Knl4GtDvVOUbqBG4H2oKyL
 sjvXpti1HJsfTmaTOT0lIa0JcUugdoMB1FjIRuX93Rls+DZ1DP/msCDLNTLRYtzD5gaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2mSrtdQXo5VkYWqWzrhij7AoWR7yj2qPTzrboLQedR0=; b=e
 0pkyer+o8FWhEbe1vLb2aCacEt//1zpBzfLELYhuA8SKZxqAuQYKHxTQoskfEj+F4r52BqcXXNAa2
 /CvFM2v65WpscULfdWW7pgT/u+o2CJIS73ilm+gcaO7b8L8Bp4yg8QJZFg4IbodEEJJoMVPN74+bN
 M2bhyDRGDH6e/tqo=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqO4-0004In-O8 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:47:51 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso11207125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786708062; x=1787312862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2mSrtdQXo5VkYWqWzrhij7AoWR7yj2qPTzrboLQedR0=;
 b=U1jP4QkqblaQd7FlijQ2ISlXZGha+qVHKqlEa7+4E83bHO8qoI41L8kWDty9aBHUMK
 VXM+aqvsO4BiPdrs08ZNe1WHkpbKHjv8eOt8VxPsx6bpddU27fPbLTYei4loRI66H0VA
 R5xlX80v8gEKxD5LdrYqIADLo2ZHN/5ZaCAUsifOTWQro+K9WWDlTMlRH+75mnFDxKN3
 bYjjQbEl7FqNaOisDaeBdgp8ifL88Q6JwjznyMqkvSjR9xT+88AhHiXho/o65fENNaPo
 S+Mgq6+lxDpYxMmMJIyO3O2kjy17AhxFQmwlApzXc5rZSeWhwVlJICwVSK2NoVPpM5Hq
 x7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786708062; x=1787312862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2mSrtdQXo5VkYWqWzrhij7AoWR7yj2qPTzrboLQedR0=;
 b=UGaJqIMulyaRk6vpo3b5c13Tv0IjYqlCsHpJgcrl0jo+voqlI1j9rCv4IV0k19ePMb
 pfu+EIcAhVyjkuCZdM75bU/V6gXVsVRikPclywV6YTormRhQR1WCWmHXjCpwVdgvjsm0
 pg1L2q1gi+oNoHgcU5lufG4/nbrD6h5gv+/YrZmiZVCcufvHhqUJBANtfqbuMc3DrcRX
 1dEvaJlhFgW0gk7FODmh3Ija6SzJEKNXALCm50rE+FoarKyWmMu8s0dQPkjqyof8GxA9
 N6N9o1S7w28fAw/Xzjf74abnOD6WY59/F7kCDoS7QP2uK66B6vELwGltZCAyRVwXMKRu
 a2Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyzlYbvIGKtNhD9liZzScwoRK+aekoNdNXi4b4hrhAKGmnmDwcxYVJnI8lfwdXYTiPXee6c97LT8ZudSco@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy47wtqYGGxJH9mC+Q7sPCz+c59rCqTWbvJ1O+RgxOLKFeiUZ3I
 8KtaPhHtjVLe5Fis/Oe4biZ8P8oFwe+IdwvwAp/dR+/oHCprryWnNaeHSI+AyqCXsuQqDWjGkDU
 2aiHb/NNskLqYAQxdsM1A37D3xyH21gqavPp0he7REObPEoY/3r39fGxfPeNcbxN1EQbCcLE7rY
 BoM6jSVQ==
X-Gm-Gg: AR+sD13YJS/dPWhg5+xzG0sSrL+T6GQkbMkJFE1Skp/BbWzyKL/aTcWqycE71MBL4fj
 Sw0LbblNq3ANF7t3B+BXVorpPy5utEaF3nQkU1PjT5CQZ0sw3dIKjeHclRO+NchkvY3+38+aJdy
 8Mo2PeO5edzqenOACouCMo+Xbim0TjaGxpbWhGIHSnyac8OEf6mjMrtBOyCenkp38aIvXnOljwm
 0xproNOTXWwjUhOy0DwQHuBy3qwZSPG9l+6lk8hrvbJk7N7j8E2HKHJK5YdbL//lCCmqtON3GGM
 wzVEGRWjWC7C3lPizpnw3LhXvv+SoV7eGfPoAKp0GkiDPhKvupXyP5sJOka18HH0+ouohmly1Nf
 u+nNhqMuxqNaf8vb4uLXyoNdRSv5NQxe2NtlcIXGCBcXbAt6Ykq+fTq4i3fA8CT/h31DtJXnl7k
 cz7cq4a/MGUvPT6EEl7FsRLIqBzKSC95787tIbxJlcUhHnb8B33ntKt+liegSKqaUrX0KSfsLgw
 PrgnvSLsG69V6J3zfNvw1bmuxW4uDaJR75812/beh99VpPLJ8+6RtrYDAgz2i0eI4GKXxdc0bHj
 j3nlqpByCKII5KKLd4Bmzw0a4X9U2nPzO8tjcIhDEfVo/kAf4Tw=
X-Received: by 2002:a05:600c:b99:b0:496:c379:b2a1 with SMTP id
 5b1f17b1804b1-49987929903mr72388075e9.2.1786708061950; 
 Fri, 14 Aug 2026 04:47:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988af1068sm49945525e9.8.2026.08.14.04.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:47:41 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:47:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 2e02ce5ae37f81d5972a0e2a5103fccc8670eee6
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 11:47:40 +0000
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <981403d2b2090352f6265dcc56cbba7ce176fc8d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqO4-0004In-O8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 dev-tools/reformat-shell.sh: Make our shell code more consistent
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2495231577769410224=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2495231577769410224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aCCnEjMALvs="; charset=UTF-8

--aCCnEjMALvs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1792?usp=3Demail )

Change subject: dev-tools/reforma=
t-shell=2Esh: Make our shell code more consistent
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a94dde26631e5a665029f495b2=
104cfecb1915
Gerrit-Change-Number: 1792
Gerrit-PatchSet: 2
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 11:47:40 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--aCCnEjMALvs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">change 1792=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a9=
4dde26631e5a665029f495b2104cfecb1915 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1792 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 11:=
47:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--aCCnEjMALvs=--


--===============2495231577769410224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2495231577769410224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2495231577769410224==--

