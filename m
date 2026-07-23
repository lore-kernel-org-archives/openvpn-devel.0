Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7199FC531CB
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eicrZT2CJl1J1N+0W7Qfelgp3cTdflYtPN+0oc/id2w=; b=hHzLKzfhd0bvZ7kbJ8x86EQTUS
	E7LImjmH9gfjjpTsOjmD9cymRJ4c3mjksQE5fhtecK0mWSIln9xtMMF7sQCk5ljaY+2bo2vBy14NV
	HSREw2s1phRy4436XQTwuXAgz/G31LYjh6YySnHHNemTMsvSMC7FJ+LtqYmOggzRg3O4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmsK5-0005jw-Ln;
	Thu, 23 Jul 2026 12:14:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmsK4-0005jj-Jf
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sapxlIdfEJJwpZ8L/WBIWhDkdu8yCB8F4AGAxyr1nKU=; b=lcfy+r/qSnS1um3bzOLXgJYMXJ
 YBAq87kEXZgCJjrNEEKe8yH9OLl/1IVy81s+s2TSfKvXpHwjwVTltvEUBE0KHxnrHHUJxgiDmSQec
 sRs0aN0DZnF9M1+KaYNxhfDtmu80HcpSx2Zd+lJ5X5dXsEi83hOOmP2XEc7u8S03vKgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sapxlIdfEJJwpZ8L/WBIWhDkdu8yCB8F4AGAxyr1nKU=; b=X
 YhLuBy8Lk4Nnoz0S3nlpb9Zzl7G3otQWtpUWVBkVu4Cr1Ff8/+9cFlt8abhsxIQQfl9pOrcMnIK5v
 eyrtKa0BuUKj0FMCOfJrWeSWYwHetnEkaBN0uPz1znQlXcoLFJmWE00CZNbPhs2XbaFc1x0l2qfqV
 bnELvnme//42i1vE=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmsK3-0004Pu-Od for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:14:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f7854678bso208932f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784808877; x=1785413677; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sapxlIdfEJJwpZ8L/WBIWhDkdu8yCB8F4AGAxyr1nKU=;
 b=HOXEZfwlNjRO1Gob+yfGqzKA3mIFULaKXilxoFx5Z+CANCWpzMpCbG0Ux7qxSv6jK6
 MbsW6018xRtM3+bpXazy5rO2I9WwsJvhe7E49lLIKpvhwlJYaUb2sInwjfcc93neQG2y
 wVSvMRUn1sVwjqNLD+NCL8UI14tu5iy7LoJdM7z/nXhnKTn6VqtsI2yWAnZlsQbCW4OX
 Joki/drHp6sSTfmu79J2CsRfJDlaYeLDjqrTX8lkpxkYFwwjO2SbGcF6nwAN0H8ZCP2Q
 xbadlqEB5CF2jT4RRXZruf0QX5QC+1CjUqEj2eysmt0rBmnldptaeZhrRcxO6nIHksGv
 LBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784808877; x=1785413677;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sapxlIdfEJJwpZ8L/WBIWhDkdu8yCB8F4AGAxyr1nKU=;
 b=CGqAfNvVcyCJBSBifvOHbnUSKnsMYH1pUKkDpxUxBAo6nOX4HD9gbS5rNinX32y3jX
 wJRFbV8To1BigY45nMmjTVO5KHbZAwG8T659FJMA+DFGJ/3lZ0Lr3SXflxPeAPzOMRnz
 sZ+G6zyBXUfjR3f/cWpD5A8CBP3TOjFPwJhcrzByQVhrSeB7NrsoQiNecV/QJgeiamy3
 MaNRkurIW0KHXyKcMHYzfG/mFCtNtg5S8RCKdBIZVez2rdiMQzvwhL9H2PGUyuYbxrmD
 5mQxsk7p37ls6sA1H5k3lhQU1i3qJdwMnki24ysuy8alGAAxvYweZPXu6NQl6Ft6dgJN
 KhBQ==
X-Gm-Message-State: AOJu0YwuB2geKhX0jq+5yHEUPd98vObv7qoF8fFCu7NDEIe3pd6tCHtd
 Gq427MpqNWAn3WxRJOjSiXfE7QxpzGgz+oImAYgRPDtMrk1hcOl34fQJ45m2lHEv5e5pLIdqT8V
 dKyCiaA2ZXFARB1e2Dw5yhS7MrD6tRhBmiWxwI9Hf7hgC43QZtUoYfPwR7SpQuM9tqhFmGUDZ9N
 mVKmbfcw==
X-Gm-Gg: AR+sD12wSwGtM3tHpdRI8uBmIeadP4rLo49lvAlJ1wL+kmsDhantTYLEkXCTzWpL6xK
 6iZj3U5tNL3F222o0yt4s/34uV/mFOuhS1zusr3btZP+04PIPggKvRYajnNpy7dRD8KxU5DSis+
 /Zo8vUmm0pc7MT+4czvJ6v8ve1JOwIKM+Wj+q8/4M09KDQSEyFkfWg5tqJAChcX21G0M4d7YCbl
 nfC4A0gZb1/8zaNca46tw8iPVSyVuGGg1mR/hEjgKDocZsUfWJdk40LmrkNUUUpY0/t4svxcIu5
 inolScKVe0f7P7NCqRvBu2lsQC6YdzGe+4UfS6+OYQz4Z5kjh3D0spTmUudUPdrWGearfz8l0cd
 HAeeJGleT4e1dOduUkbKmzaDrldCXxtoCdKsa7u8/DSbR7pONsOHR8IL5/KKwm3ZT+8O+4iQ+JG
 /OoPqAQqDWzT++PYVSx3BIVF9tOK23dZBkigSCteN+3ykiXDls9PmfeEKEdJcv+8xQpU8EGAEws
 wzkNq4x+9lPPrpVzs0FJH4YoUnIsqCTBq8523hWxpXgot++ZjAOmuxPzz5ZjxqG1GCX
X-Received: by 2002:a05:6000:220e:b0:46e:37a6:c762 with SMTP id
 ffacd0b85a97d-47f8dc7a09dmr3841118f8f.32.1784808877058; 
 Thu, 23 Jul 2026 05:14:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm15649501f8f.37.2026.07.23.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:14:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 12:14:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 6ad6d340bf9bd7ae183521fc973ecb115f124f03
X-Gerrit-Comment-Date: Thu, 23 Jul 2026 12:14:35 +0000
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <876d80ab318f8fb5d5c2d18b39d622f4dd641e47-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmsK3-0004Pu-Od
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3101684730469742345=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3101684730469742345==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u495cOs+um0="; charset=UTF-8

--u495cOs+um0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS serv=
er and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2

(5 comments)

Patchs=
et:

PS4: 
Code looks good, commit message could use some work


Commit Mes=
sage:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/49dcfa3f_f4ff=
953b?usp=3Demail :
PS4, Line 26: Our mbed TLS code basically does give the =
SSL context any personality
"doesn't" ?


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1728/comment/35799328_5aaabb29?usp=3Demail :
PS4, Line 28: code ca=
lls SSL_set_accept_state/SSL_set_connect_sate=2E
"SSL_set_connect_state"


=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/44f47685_ddabdc9f?us=
p=3Demail :
PS4, Line 30: This also modifies the mbedTLS to use the decisio=
n to pick client
"the mbedTLS backend" maybe?


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1728/comment/2268e2bc_41f41786?usp=3Demail :
PS4, Line 31: a=
nd server in that path as the OpenSSL code path=2E
"in that path as the Ope=
nSSL code path" -> "in key_state_ssl_init, same as OpenSSL"



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a24979=
53583d0
Gerrit-Change-Number: 1728
Gerrit-PatchSet: 4
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Thu, 23 Jul 2026 12:14:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes

--u495cOs+um0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>5 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Code looks good, commit message could=
 use some work</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Co=
mmit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/49dcfa3f_f4ff953b?u=
sp=3Demail">Patch Set #4, Line 26:</a> <code style=3D"font-family:monospace=
,monospace">Our mbed TLS code basically does give the SSL context any perso=
nality</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">&quot;doesn&#39;t&quot; ?</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/35799328_5aaabb29?usp=3Demai=
l">Patch Set #4, Line 28:</a> <code style=3D"font-family:monospace,monospac=
e">code calls SSL_set_accept_state/SSL_set_connect_sate=2E</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot=
;SSL_set_connect_state&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1728/comment/44f47685_ddabdc9f?usp=3Demail">Patch Set #4=
, Line 30:</a> <code style=3D"font-family:monospace,monospace">This also mo=
difies the mbedTLS to use the decision to pick client</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;the =
mbedTLS backend&quot; maybe?</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1728/comment/2268e2bc_41f41786?usp=3Demail">Patch Set #4=
, Line 31:</a> <code style=3D"font-family:monospace,monospace">and server i=
n that path as the OpenSSL code path=2E</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;in that path as th=
e OpenSSL code path&quot; -&gt; &quot;in key_state_ssl_init, same as OpenSS=
L&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">change 1728</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf1f3475e4f27a920c028=
cd73b1a2497953583d0 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu,=
 23 Jul 2026 12:14:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--u495cOs+um0=--


--===============3101684730469742345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3101684730469742345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3101684730469742345==--

