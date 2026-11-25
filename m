Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7A606A337
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LO6YJPjq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kDD8v8uQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kmYIBqf7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XxosYIgA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=myYWjPXNGNyyWNU5YryYjOYhYMXfe0hsJfxwW0nOghE=; b=LO6YJPjq4L9aePNHTKaKELxKBP
	jv1DOZD4QqMnYPO1OpUdpLHtr4d5SKVfVjXjrDCwtBTmsAzji6qa5OijRqkjb2qq3kurDElHlNQ1G
	SeflTWr9AaRW3NEbUKVkwY8ABTa006m1CtyG7VpI+gZUwZss9vn5LbjyCsdWeVvQf4Tw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW9dh-000000003F9-3n6F;
	Wed, 25 Nov 2026 09:50:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW9dP-000000003EC-3eo7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9hsI46mxO4bwJfgv0eHdORMMgntkFfM+9HoNWoykUcg=; b=kDD8v8uQ9qAI70HHfLM55FfXA3
 iGrMIkKPYuCQQmkE6y9Hk4DypNoNGNu8QY345km6rNlPtsNLSo/L3lkAI46fEJY8BgqdHwMKS0Mhd
 7Iv+1W3XdsLqKwHTZ37nhUq3WWMwpCybRxu/XCvbWQDcu/uJJtqxcmR8Ybm3JbeiJcNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9hsI46mxO4bwJfgv0eHdORMMgntkFfM+9HoNWoykUcg=; b=kmYIBqf7nlCozUGj/540U2LlAl
 heJGqHpbqHtuiGH93G7ScGwgJknm4J1U9Gu1nOor+zkjl5XZ+HHaKg1jn496TQgPa1SHI99oF9uPV
 YvBsY5t4n5XfhGUxBTbHtmicaGmHmolrcUQfuYpx+y5Oxr7BTwswLpidXNhjUfAN6S5s=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW9dO-000000004Be-1rAm for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:49:51 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so59075625e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 01:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795600184; x=1796204984; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9hsI46mxO4bwJfgv0eHdORMMgntkFfM+9HoNWoykUcg=;
 b=XxosYIgABojZRkeiNWS9r3+sqO3/pYeS63DlE1Dc0z6xbGQhaEH23Ew9qQ+VuZaYRW
 jrISRbFuQevLlOzmVjTVrjvd/9TWEs4EhojVW1KKrEqrPODwJeyNV56Zw8UceNzhvIB3
 6a/dRGUtPKOFBafkkcoEyREXyjR93KbEVa/QaW9SgyfSxpXlDw6m/3ssA4UpIJB1Hj92
 /1Pxh+MnolbPJoun4/UeZT5Nnk2zPFI40utVNGXjv35L+i4uKpiiRVp3NsRYB8b9cKyt
 iY8mCkkKDSZf5jJqlBoegEumWq7baC+B8ht5l1M0fpdlv46rt66u2l2H/Cs89joqnhnO
 wEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600184; x=1796204984;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9hsI46mxO4bwJfgv0eHdORMMgntkFfM+9HoNWoykUcg=;
 b=IUkjpjWFxiKh6QSkkIKPVjTsOWRPGX9DQ6C00YVK9vUYOoQQgeBCtsIG/K1B8LZIoz
 rYAPPkVVuI8RXdohNBIOo0HC2G7J9SIS5MokNFeyNDt+IxQHztPMXDTZ+2zF3GzG/Vo6
 rpP7rMGPn48iZ/Am9QzJ+nYk7WyNEe1LQ7LB1TNJAoQ7E3BLz+TWtULRi4CrBjOykTE9
 tp6G3sjmSGjNYZK0ndjnvJhIyzn0WlrXVJt7SyNBsT/WoVWI9G/iumjn2fD3CJKQYpYT
 LoD0TcMYjB+LfhBCOOr1hkPyM1FcdtxbVP3wA0sj7js8srHNUMJwiJoPzisy5f8p2zFq
 jpjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFTn4fEfwmoce/Z3sRdZkrAn1BsVsX9Qt4CBsU35JjN01EKqJK26SGrUTk3so1Jbcaxmv+ErV8YdtuVJdcf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+AIcgvGcLUH2O0CgpCeSI9gUWxn9tGuSGU79Ac+xmERmvQ81mn
 OAcahHBTArq0DDMOEbLSgZFVvkn2b/yNPtzBRTyLkRxQoGGgW+3GTBAbFkeMv2wCkkabNVsJKl9
 Bi35tDR8BMq1z26mSYPU/ibnN7kJ1UStlDGvD4YK9qkqyziMxSZmWmL8wqAkjAsGWqit2FKUT74
 1y8MnPgA==
X-Gm-Gg: AZFdTZeulKadly215HXrhGXPCCbFL7Jgp55z0ScPFE/OQFPfAFJeJ8TM0y/ZJbchLoL
 6uzTl0oAhHJBow6LdVnTHSVIcaYE9zCwYdEi5dxGOEnFeECJRSIGTq8Z2//HWCmMyGHmRZj6Zqb
 JeiPvEJd0TpEVYQUVL5sJnm5DI0TfZhIP/ON4z/1ptqoqN4YWG8PIofsd3Qto6Mb+mJm7gAOYxW
 MPNYQCx+DpysFfqOAsdzUL39N4N6Kaj+ACOtTMG/sRS72+AjqDisT/sMWeV09d7PyxzITzunM9g
 Ann4mlho0GSm32vkPXCfbG8sDpkAGIhjp942YPjNt40N2+pAgLT9ptre4MHnun/26VKrw/uRVZS
 rAig4A1ce700+G4ScorzZXggZQU8Cr3kg+1Q2cIg0GV2CAt9U4TTCjcHSlJf1Vy7B+w3w+YbIfU
 A54sXSZWYqZcxzvIYAiuDomYJyg4EvKnmAQK/A/Bzm4MRvxhPBosi9WSkl99uCYapVA5LrMrByI
 OAjZGLlrX+vLORhzP5X4BSqLrovfPQa6dy2oTTc1v7kHj2oCDbkGp27yONSdZFpYNZEjkhpnBpS
 O+m7xo9BCHBWpwopxRSMD7dqx29a08Tbwftc96+6i5rAse2xUuNnMc4FUjkDRZ0jzN2F6z7Ulmp
 g2dnV0+ld0SDGcb8VmEpSNLv7mwA05aJk0E5I8nQRYtsPmrDe3SMuAuRtPn9gMB7+y4SU1/WaT4
 9m7JiB5G8SeR+nbMM=
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4bb8880f0e0mr352189215e9.5.1795600183626; 
 Wed, 25 Nov 2026 01:49:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm24936608f8f.15.2026.11.25.01.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:49:43 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 09:49:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 53542aefa682e59d804ae353be9731bf15ed9dfd
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 09:49:42 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <658884b9e4810eb9b5e7a14d4e31fe199a5d6a3b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xW9dO-000000004Be-1rAm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2285964687269911887=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2285964687269911887==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xo7KQeEmrlE="; charset=UTF-8

--xo7KQeEmrlE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Deri Haerudi has posted comments on this change by Deri Haerudi=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: =
dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comm=
ents)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/com=
ment/8ce168d7_3139dc37?usp=3Demail :
PS1, Line 19: the unprivileged process=
 controls a file root will execute=2E
> (b) is not really achieved=2E [=E2=
=80=A6]
You're right, thanks=2E dev went into the dns-down sed program unch=
ecked, so a crafted vars file could still run commands through sed's "e"=2E=


I took your first option=2E In PS2 the reader only accepts a dev that sta=
rts with a letter or digit, contains only [A-Za-z0-9_=2E/-] and no "=2E=2E"=
, and otherwise exits with an error=2E '/' has to stay allowed because Haik=
u names its devices tun/N (tun=2Ec), so the three dns-down sed calls now us=
e \%=2E=2E=2E% addresses: with "/" as the delimiter, a dev like "x/r<file>"=
 or "x/w<file>" would still have made sed read or write files as root witho=
ut needing any other special character=2E As a side effect, dev=3Dtun/0 no =
longer breaks that sed expression=2E

The message now says what is and isn'=
t covered: root no longer executes the file, but the C side still trusts th=
e path, and the values are still used as DNS configuration=2E One spot I le=
ft alone: unset_search_domains in the macOS script still uses search domain=
s in a sed "s" expression=2E I'm happy to look at that in a separate change=
=2E


File distro/dns-scripts/haikuos_file-dns-updown=2Esh:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/94050c53_e53c2ca2?usp=3Demail :
P=
S1, Line 53:     [ -r "$_f" ] || return 0
> This should be `|| exit 1` - ot=
herwise we are letting the script carry on with `script_type` unset=2E
Done=
, in all five scripts=2E The old "=2E $dns_vars_file" also made the /bin/sh=
 scripts exit at that point, so "return 0" was a behaviour change in PS1: r=
esolvconf_file and haikuos_file exited 0 without doing anything, and openre=
solv fell through to "resolvconf -d '' -f"=2E



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
Gerr=
it-Change-Number: 2341
Gerrit-PatchSet: 2
Gerrit-Owner: Deri Haerudi <abcde=
ryscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 2=
026 09:49:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--xo7KQeEmrlE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Deri Ha=
erudi has posted comments on this change by Deri Haerudi=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2341/comment/8ce168d7_3139dc37?usp=3Demail">Patch Set #1, Line 19:</=
a> <code style=3D"font-family:monospace,monospace">the unprivileged process=
 controls a file root will execute=2E</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">(b) is not real=
ly achieved=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">You&#39;re right, thanks=2E dev=
 went into the dns-down sed program unchecked, so a crafted vars file could=
 still run commands through sed&#39;s &quot;e&quot;=2E</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">I took your firs=
t option=2E In PS2 the reader only accepts a dev that starts with a letter =
or digit, contains only [A-Za-z0-9_=2E/-] and no &quot;=2E=2E&quot;, and ot=
herwise exits with an error=2E &#39;/&#39; has to stay allowed because Haik=
u names its devices tun/N (tun=2Ec), so the three dns-down sed calls now us=
e \%=2E=2E=2E% addresses: with &quot;/&quot; as the delimiter, a dev like &=
quot;x/r&lt;file&gt;&quot; or &quot;x/w&lt;file&gt;&quot; would still have =
made sed read or write files as root without needing any other special char=
acter=2E As a side effect, dev=3Dtun/0 no longer breaks that sed expression=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">The message now says what is and isn&#39;t covered: root no longer =
executes the file, but the C side still trusts the path, and the values are=
 still used as DNS configuration=2E One spot I left alone: unset_search_dom=
ains in the macOS script still uses search domains in a sed &quot;s&quot; e=
xpression=2E I&#39;m happy to look at that in a separate change=2E</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/h=
aikuos_file-dns-updown=2Esh:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/940=
50c53_e53c2ca2?usp=3Demail">Patch Set #1, Line 53:</a> <code style=3D"font-=
family:monospace,monospace">    [ -r &quot;$_f&quot; ] || return 0</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">This should be `|| exit 1` - otherwise we are letting the scr=
ipt carry on with `script_type` unset=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done, in all five=
 scripts=2E The old &quot;=2E $dns_vars_file&quot; also made the /bin/sh sc=
ripts exit at that point, so &quot;return 0&quot; was a behaviour change in=
 PS1: resolvconf_file and haikuos_file exited 0 without doing anything, and=
 openresolv fell through to &quot;resolvconf -d &#39;&#39; -f&quot;=2E</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82=
f42d4371 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2341 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 202=
6 09:49:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div sty=
le=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>

</body></html>
--xo7KQeEmrlE=--


--===============2285964687269911887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2285964687269911887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2285964687269911887==--

