Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711AAC4450A
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xv1WOZMj18PGg+0RT2aEEqV2BBsJ7oh/UsdKpRRw5Ho=; b=iTIAw2IBGDZdb+8JPwo71/HIvl
	+h7dCD8iKuSUCN/bygTs1j+pmygdR+d9xWKwp7IOkJHWCJ2pvb0D3JFOfRvJ2+wkqX9+NMFH6hE1C
	SsDi2/+lvy5DU7tADX/13sSMbMSk59bGUFRgg5QeAq8egroxMfzZsLzseylcM5avTGsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkJoZ-0006UN-Js;
	Thu, 16 Jul 2026 10:59:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkJoY-0006UG-FG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 10:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+rt4bqRIznHOkTJD1ZOvmRsnxty1drE7mZZjiRb3HiE=; b=NvWzSWYt0Eh2a9uTpUt6K8BThp
 Pr+qJ6RlJtSSKtBolKmt8ZO2I/LBpc7ex7hokc7ZcvkeILl7Rv3RPI8Y8/c89Wecxg5YgIncgW5Wr
 OEger2BWTjdwcU4y+SWhmaPWOvhiJy51LTssROrUKD1Uj04ykDvt65cRH+J47Fg1Grrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+rt4bqRIznHOkTJD1ZOvmRsnxty1drE7mZZjiRb3HiE=; b=i
 OKzjmivjr1ESdOBuYkEAZbm7ymmwb8oj6kNIx/aAJNJwVMZK+bci9jLl+TTCXDZ/QSEaoXiuGhIm9
 bRiRp2jiTxCaQMaYgAoHC963yKAcpPZmpQh9rl/pjy1fjXxh0Oj+gDs6a1TbihqlUt0uVlBzGgjck
 w32nMqt4llEqTO5U=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkJoX-0000cJ-TT for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 10:59:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso26373325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784199566; x=1784804366; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+rt4bqRIznHOkTJD1ZOvmRsnxty1drE7mZZjiRb3HiE=;
 b=M3MXNHbUD1AbwWyqRNYjaqqFrWWucyoomImCn0tbfmv8v3wNXNga8jxEzBhyMdJf1Q
 97g7AbY4WgKqMHst0PU2V3nFO47sO60uIyv1CCvbsYypvpyjUSf12DwwHpF+zsjwbFAI
 DAwk8t8QqIiGt96tIZZ+39czPrLB3v7AS0N2WXBfnRLCW0toAVafh3zW7vc7mjq9Oj9j
 7qBNYJzchVLw7Mo7VkeejmCZxpGAyNNsU/+1fjMuE0WTkfJCPVRzk0mZX21Wktm2nxAS
 v/EUvtbxDlRtfFBHss7dUK8DYU9Kw1kJ0ftKo9yex5QJvEe22YcyTDHhpeZu6o7BZxSq
 R+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199566; x=1784804366;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+rt4bqRIznHOkTJD1ZOvmRsnxty1drE7mZZjiRb3HiE=;
 b=Fd87h5Wxy6AVV5Prl/tlW6rRuYE7crjd81exjAYki55lT8cJ5o753snVJtMnfUU9V3
 efpdAWmv7e6CxZvTp5WkM+UkJIULN00zi9wSYD7FZUvN3EBmJZYxcDh+XU/zj5Q0NiH9
 DdpTnCel3fhLfmvHKDuaBXQ0DoHOvim9Iio/W5A+CusnPtybg93sPdyrJk8x3NbS5rPL
 JMUvCD58f/lDKXKfzYnj0duoS4JOMj6QawJnQxqRRQd51P317vqkFEzEPqyj/2Npw/5t
 FvN8eciCiZX/8SXyGJ6kMXYLay5fXtjFmwlJYk8WC+IKUrzo7STanpkZwy/hJV9b0DOa
 WURw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpiu3LFI/diYM8AF8gIG5HeuQmBAsVFG2bI+LusL0tQRAtnOEuq58NdyttWIXyZIoah721jZZa1Vx1FyL/a@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzyZvrqFY5mVVBYUR3qfYOHLyxNfWepNpe7RfmV3HGhGNvI/Rgm
 l2oq0qoD95LPaXnw4OaLhIFskAAP9peWf1KdC3jhQLxNIU1rEZ9onX2KoHXMAePo/qV5qKA/6cF
 tm8vERNfnBxwxw8l/vSFiO1Wjxko8A2KouKbzaOU01sPDa8VhlQsmTKIqQf99ftEeBo/D
X-Gm-Gg: AfdE7cnhwOhrxfAPWT6sG9wpiqUM67Cus31z0DdroYjPzdtbqTAtfuZAuOhlY5ESb6J
 OmtFVdYAjj+0CanpeZTllUhqkiIDmtIsWUkRIbtUXyCDlrt46ryWFZKbuROZrMPxz4LrL9BAq4N
 pEh5A2XO9E7SoyBjXiC+Kxwc8ski4afUR8NUrRgkz9xzdWrN02CcLlWSUnytYCk7DAcVLb8eekB
 y3ezj+aM4kcWiwJ7oh5oFDaU/bAAGX26yQwxaATcHNKFulX+TzJ/gD4hGjXqmAWapCiUABLMcnc
 xpa/eepvHcTVG784Kpae1/14uHU/UkwCWHoD+8q7sSh9eki1fdHKEAqHSzzEmKPo2q1geU02exE
 4XsYwNG3Qs4I61yX5ZXSD5q6J6tqX3XwzmaqDK7K1U8m4a75Q6gs/gBKNhmVMIKYQGwmywhu2JR
 Fv4A6FXrSlztm9DBRa6y3rmAV6Elb6TzNvs6JlFOBxz3NvmM8+ZXs48Qras4cWmgc0KR9t5xNxj
 1lkdBbMrjPzDmZ0+0AoZ45RSeWHJudHJXb4eCFuJX9iIHBoa65uAMiwhmxbc+rF24UB
X-Received: by 2002:a05:600c:3b18:b0:495:4689:7147 with SMTP id
 5b1f17b1804b1-495468972dfmr1893535e9.12.1784199566169; 
 Thu, 16 Jul 2026 03:59:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e93295sm49802345e9.10.2026.07.16.03.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:59:25 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 10:59:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 4860795e539180ed0d6bd1e38e73c8376f653cf7
X-Gerrit-Comment-Date: Thu, 16 Jul 2026 10:59:22 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd21109b77e20afdaec512c19eed6bbd46e4b3bf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkJoX-0000cJ-TT
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8495093997202360700=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8495093997202360700==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dHSyKAkQ3Y0="; charset=UTF-8

--dHSyKAkQ3Y0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1790?usp=3Demail )

Change subject: pool, multi: persist subne=
t pools via --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

File tests=
/unit_tests/openvpn/test_pool=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1790/comment/1147dfba_d7ec3fa8?usp=3Demail :
PS1, Line 226:     int fd =
=3D mkstemp(template);
```
C:\Buildbot\windows-server-2025-latent-ec2-msbui=
ld-amd64\build\tests\unit_tests\openvpn\test_pool=2Ec(226,14): error C2220:=
 the following warning is treated as an error [C:\Buildbot\windows-server-2=
025-latent-ec2-msbuild-amd64\build\out\build\win-amd64-release\test_pool=2E=
vcxproj]
C:\Buildbot\windows-server-2025-latent-ec2-msbuild-amd64\build\tes=
ts\unit_tests\openvpn\test_pool=2Ec(226,14): warning C4013: 'mkstemp' undef=
ined; assuming extern returning int [C:\Buildbot\windows-server-2025-latent=
-ec2-msbuild-amd64\build\out\build\win-amd64-release\test_pool=2Evcxproj]
`=
``

Maybe use platform_create_temp_file like test_ssl?



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f=
05
Gerrit-Change-Number: 1790
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Comment-Date: Thu, 16 Jul 2026 10:59:22 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--dHSyKAkQ3Y0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_pool=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1790/comment/1147dfba_d7ec3fa8?usp=3Demail">Patch Set =
#1, Line 226:</a> <code style=3D"font-family:monospace,monospace">    int f=
d =3D mkstemp(template);</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">```<br>C:\Buildbot\windows-server-2025-=
latent-ec2-msbuild-amd64\build\tests\unit_tests\openvpn\test_pool=2Ec(226,1=
4): error C2220: the following warning is treated as an error [C:\Buildbot\=
windows-server-2025-latent-ec2-msbuild-amd64\build\out\build\win-amd64-rele=
ase\test_pool=2Evcxproj]<br>C:\Buildbot\windows-server-2025-latent-ec2-msbu=
ild-amd64\build\tests\unit_tests\openvpn\test_pool=2Ec(226,14): warning C40=
13: &#39;mkstemp&#39; undefined; assuming extern returning int [C:\Buildbot=
\windows-server-2025-latent-ec2-msbuild-amd64\build\out\build\win-amd64-rel=
ease\test_pool=2Evcxproj]<br>```</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Maybe use platform_create_temp_file li=
ke test_ssl?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a65b7d=
a01ea0e785b7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Thu, 16 Jul 2026 10:59:22 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dHSyKAkQ3Y0=--


--===============8495093997202360700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8495093997202360700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8495093997202360700==--

