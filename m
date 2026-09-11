Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5678AC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWg7VNwIKOuMfgE6QwEQZVgu4q5NZA20zz0YpI2PGT8=; b=hEf/np2KiO8oV9HgxEfcYYyBWP
	5fH+FwRKmM9JCxKFCJj0b0/dAbYABqAuISgSKAIsAOH67cA2ube/fTamvL7nlstxlmnrcVoKnmWOE
	g6hHX+jXpYc7XJeIHWu4Ptiv+Fz/b0F9v0I2Ym3WzKhJ3/PRBrYajYwCG8zSAaANw874=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4ygA-0001zh-MD;
	Fri, 11 Sep 2026 10:40:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4yg9-0001zb-Hb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 10:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=INu0CpxOnTp7gQ+Pdvbg/EmJBQzlwm7NFC5mLp7GbkE=; b=ZWZJ+rOCeMfTvGjPN0wj18pcjn
 qoNlUrdE2aHwl9KVMzl49hOJaIcdKzWBuCCA857B90u9i9zwbNW1eXClN2PYOgOuIJCfA8cZIcupz
 lNll9KKfCGt7RFdxqloVSttyUY/VXKjisnrGtSPeZKAkZzyV1GTL0ty4XskJAcRFDtUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=INu0CpxOnTp7gQ+Pdvbg/EmJBQzlwm7NFC5mLp7GbkE=; b=W
 jHc8HgxtSV73u3EZkEMWtQ9+QiTFeQ0RSk1yp+anUw8i3VP0TAJ0hfSugWJQ0+LFqFWfov3RQnFUi
 6Roo3+VC5yYEpoanHdVmEvR5IoDeAlpmirgUyEBoeRgxf9YIotwpsS0wCep+B/t+SUl92Wzz1WNxS
 3e6OtWawHzSZc7aY=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4yg7-0001Wa-0c for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 10:40:22 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so392933f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789123212; x=1789728012; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=INu0CpxOnTp7gQ+Pdvbg/EmJBQzlwm7NFC5mLp7GbkE=;
 b=agmlQZz6FS/GDUme53kNaXgKrUt7FEU2Y4HQd7yhHz4l+kq2qHI/8sl1Teu8Duxl8D
 NLBpZ74MbU9hyPT84QYrJOA4mQsJYn7PWHAeo1ky8Faz32UWmOxAarzIijRsSqyU64t2
 94mQ17Lox+DzTFN6P0z94XWqcGWluioeX7UiE95sRhlXcbLEqfnaXr6btChLYTRVqWZs
 FqLuDkOxe9Osb62AGcGJRIoq+Ikgwy+bNwQkgpM5kq+1ctsDz4LtAXr5K3gPGqEp8gBH
 WdJ3S4xnFHDwSg3TIpNBgsjwYvQAonpQxUAxGUaAbCjygcQPkgdzQYjfAoFRNjzs+WOc
 QoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789123212; x=1789728012;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=INu0CpxOnTp7gQ+Pdvbg/EmJBQzlwm7NFC5mLp7GbkE=;
 b=nEKQ5klIQzSC7H8VrAURyjGJo50FY0Z6pfrUo4lE1oZhxt2hbLvwYiNIArC5PLC0gP
 suBB1eYFTrPj7WpXryjWy04eHt0DTlyt1W1uwawYQA5733AuxOTDG3ghy7ATJU9rXLnE
 U5FSq5gLCdRO8XyGVM8s3ZCp+GMBp5N2TTM72AJERQBsSC3UlGyN3r1wu56jbmnTpmhL
 aIzEcllKUwZ6OIQmtntINe6pDOSRdwAOgIXu+sN3+oxyYOkQPgaoKGuLLzhSGI0FpwtY
 q9RDvod+wt1IvUkR0ktO2QRo0uTx+IOYrZX4LiVKvMS6pclkMMBXu4F9Cgeq9U/14oLy
 WhOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBmD8riAtnT5LeOlY3O1G19PU1hE0B98Lrm95W1U75G+xcVPyrIxNSUmfCyeZ8IPTNtHpedd0BPlLpsPKT@lists.sourceforge.net
X-Gm-Message-State: AFuF++l6FOplaxnDL1Ebi8VQcdcwqRFIBD/8ytGaREkTL2Sabo4Sma34
 +NhUDbduNXp7C5MVMKhKDTZxyRhdMsdq/i3ZVPflmqcYQdRmtIIP9rlOuD2AT3ErYl5ouJ19p8E
 +Dgfc9UORrhm3qE/ROlJ12BtgvI9/bFizDOf8a69vcyID0NiRH1W0q+HcrIFAI74kAwMZ
X-Gm-Gg: AYBFou2eaz+2loUrgqqL23UVjEU4HKLIjxS7yNJEtUCMUxyoT+MbDnspMAXmo7UUAyg
 OHyEjldXo6rmZfci3tpD616juk/ex3pDQ2hSpQBTnPhbGIOa78A+0QA7P/kF7nAgPmKkxQcK3Ox
 N/VsY13FU0JdC/u54bfmnPvTfhlnXV8bkLJkUe4axxJEMnPES6kke9hlTYMiFmlyHZzQGUvm8lW
 zp6F4Bk0V+wpZ41NZNS4Htvw152nhcPM5fk4hkr1x5zUQMPBal28pjJfJQCX56icVT9VUtBUupG
 lXQEN1AYQO2eKPJcvY4nMgornrPv/r7wt6WTc/LrIvdaqu7xe3tSe43nmCFO1EXWliRtk5oSNje
 ZMGvjrKuqT6YwhGXANIRu7rY5bZYOzzrwWT2/mmgxnKyY97MVODL1hSWNu7psDKhtO7mw/c+qeT
 VMuR1XcDZOm01CfJ7hpIo0AlbOtzGqlTshqvivmCzs74CFbr3Pc9feix+tTo61xFLqwy3X2LcWw
 aol96oiHdsrqZ7jrk6nqDh1KfvacAkHuoq+dtX2f++vIDWL0kLEflIfUruSyoeNCD80FCnsPmea
 lRLtJYzUyk/v5uUfejpaxKrMBiclKpeF1CoO899coc5ZODGQOt0yqrXMhc957Q==
X-Received: by 2002:a5d:5e0d:0:b0:486:e900:3944 with SMTP id
 ffacd0b85a97d-486eb357df9mr5817799f8f.27.1789123212142; 
 Fri, 11 Sep 2026 03:40:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm5109232f8f.19.2026.09.11.03.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:40:11 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 10:40:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: 65b938e40b3fd0ceed1bcfa6a12d35b5071e655c
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 10:40:10 +0000
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d1db6feec06b871547472f0f0d7ab45138cb245-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4yg7-0001Wa-0c
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
Content-Type: multipart/mixed; boundary="===============6652347185109014228=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6652347185109014228==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ExlZZRtQ88k="; charset=UTF-8

--ExlZZRtQ88k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1904?usp=3Demail )

Change subject: buffer: When extr=
acting pointers from buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(4 comments)

Commit Message:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/0c344c20_c1663d2b?us=
p=3Demail :
PS2, Line 14: pointer if the buffer is not const=2E Change all =
call sites
> "if the buffer is const"?
I will try to remove a few levels of=
 negation from the sentence ;)


File src/openvpn/buffer=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/79679f3f_a0e3247c?usp=3Demail :
=
PS2, Line 1138:         const uintptr_t u =3D (uintptr_t)BPTR(buf);
> CBPTR=
 here as well?
Yeah, code that isn't every compiled, so the build will not =
flag it=2E I didn't investigate all existing occurrences of BPTR=2E


File =
src/openvpn/manage=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/com=
ment/3d3c13fd_590c3be8?usp=3Demail :
PS2, Line 2524:             sent =3D m=
an_send_with_fd(man->connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,
> =
Not fully sure this is right, `man_send_with_fd()` takes a `void *ptr` here=
 so this will probably tr [=E2=80=A6]
Yeah, seems we do not run the android=
 build with -Werror: http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/367/builds/3498/steps/7/logs/stdio


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1904/comment/89d8721a_c7b40780?usp=3Demail :
PS2, Line 2531:=
             sent =3D send(man->connection=2Esd_cli, CBSTR(buf), len, MSG_N=
OSIGNAL);
> Should this be `CBPTR` (not `CBSTR`)?
Windows wants a const cha=
r*, with CBPTR we get a warning
"pointer targets in passing argument 2 of =
=E2=80=98send=E2=80=99 differ in signedness (expected =E2=80=98const char *=
=E2=80=99 but argument is of type =E2=80=98const uint8_t *=E2=80=99)" in Mi=
nGW build=2E Using CBSTR let's us avoid using a cast=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0=
f9e
Gerrit-Change-Number: 1904
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-Comment-Date: Fri, 11 Sep 2026 10:40:10 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eor=
g>

--ExlZZRtQ88k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><p>4 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/commen=
t/0c344c20_c1663d2b?usp=3Demail">Patch Set #2, Line 14:</a> <code style=3D"=
font-family:monospace,monospace">pointer if the buffer is not const=2E Chan=
ge all call sites</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">&quot;if the buffer is const&quot;?=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I will try to remove a few levels of negation from the se=
ntence ;)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/buffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/79679f3f_a0=
e3247c?usp=3Demail">Patch Set #2, Line 1138:</a> <code style=3D"font-family=
:monospace,monospace">        const uintptr_t u =3D (uintptr_t)BPTR(buf);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">CBPTR here as well?</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah, code that i=
sn&#39;t every compiled, so the build will not flag it=2E I didn&#39;t inve=
stigate all existing occurrences of BPTR=2E</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1904/comment/3d3c13fd_590c3be8?usp=3Demail">Patch Set #2, Line 25=
24:</a> <code style=3D"font-family:monospace,monospace">            sent =
=3D man_send_with_fd(man-&gt;connection=2Esd_cli, CBPTR(buf), len, MSG_NOSI=
GNAL,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Not fully sure this is right, `man_send_with_fd=
()` takes a `void *ptr` here so this will probably tr [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Yeah, seems we do not run the android build with -Werror: http://bu=
ildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/367/builds/3498/ste=
ps/7/logs/stdio</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1904/comment/89d8721a_c7b40780?usp=3Demail">Patch Set #2, Line 2531:<=
/a> <code style=3D"font-family:monospace,monospace">            sent =3D se=
nd(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Should this be `CBPTR` (not `CBSTR`)?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Windows=
 wants a const char*, with CBPTR we get a warning<br>&quot;pointer targets =
in passing argument 2 of =E2=80=98send=E2=80=99 differ in signedness (expec=
ted =E2=80=98const char *=E2=80=99 but argument is of type =E2=80=98const u=
int8_t *=E2=80=99)&quot; in MinGW build=2E Using CBSTR let&#39;s us avoid u=
sing a cast=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">change 1904</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib4af7639cdebe81e=
ba05ab04efe6e85e63de0f9e </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 10:40:10 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--ExlZZRtQ88k=--


--===============6652347185109014228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6652347185109014228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6652347185109014228==--

