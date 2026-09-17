Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F0FC982D1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QUf350F5kJa3F4llFwQ5Bt+9KEFSgfGzBu8WabB7Ucc=; b=hJ3o4/ZHP/EYkRbq9EbBddOKbG
	DGIC8EVP2nB6oHxBTjkHU8hWaxvKJ+uBtnllQRBSZbv1eFuOSc4oTHhHCPj2Uc9nbz5zPlRxLSU0H
	w6MDQHglnu8C8Pa5uO3istDlHQLi0S1V15vREguRroOkDcD3eDefgmWj/ovHw9e1KXLM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7COb-0007Lq-IF;
	Thu, 17 Sep 2026 13:43:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7COZ-0007Lk-Se
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3wF7DYDr3/7GDKEuyFrC64/DoHsiPqEOXGRuqeDlEjA=; b=cpNdCu9pY+uKU/z0wgQo8wEJNU
 yNnSPUtXJ3EQojT8O5OGrZVEzJ57UkxsZAd8KuZSXS1cI4biRtu3q8FVAkXVMt+DMvIZSsS9E1p75
 Vgl0VANbgZnBIn4HF0T2vcilajR0tLXTSenEP7bbHRhQ1pTfkjzSyp2sgV3R/+zAWS8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3wF7DYDr3/7GDKEuyFrC64/DoHsiPqEOXGRuqeDlEjA=; b=E
 5w02zuzgZZJlbG1KbPAAw0vrk7yjBeYsAXP0L4MceHyfCevlGxJ8H+0X7nUwc4CflueepDjyyADaj
 8ayaAr9IoobiDaS3mu0+8aSPLxHNIFhfX72RMAB5u304YDG9Q7AFhkGXuQ51RhTwgOMbC0A2NzKT6
 Qi5iEx4rF/cwS9Sg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7COY-0002FZ-7Q for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:43:23 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so11394845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789652596; x=1790257396; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3wF7DYDr3/7GDKEuyFrC64/DoHsiPqEOXGRuqeDlEjA=;
 b=ZSZCjqqPQiyuBteGT60JW6/yh/8c65wdU+66/RSsF+vo3wqMhL3TM453Lh9pZv+45W
 YfvOP2ypvbaBjaDkjOu/OCe6Ihc+BY+vn1+WllNGUtSozwhrRjQMbqbZ76GFVn3te/ed
 S9RQA/GE4UtURPQ9xd62+r1wyZee74UHpTocceKuC42CqbMdEe9HO48FTD4WGISuOBRm
 rvKva0nnhxmrZ5+IfE5/DqflBlrbw+L+VW7hXJv3x+ktlGD43AfgY4rRMAaciaXoovt+
 yKF9jN0wh7OjhuPrR1CN0fB1EV/QfvqU8pQH4tUt/XA7EPr9D1x851L5G+mWOyYc/aHc
 zXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789652596; x=1790257396;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3wF7DYDr3/7GDKEuyFrC64/DoHsiPqEOXGRuqeDlEjA=;
 b=IB3wXYOHC8ZsJVmRInbmSlZoaoWSjWyAWXELjyAAdXe7sutjbxrfjO+pP48iZc/O5O
 5HMixjX/Px+agMN5PQixcLvP9MMzFSFhnMJBCTqQVBWc431fD/C+kN3ZgRRigJLMjZ1G
 MUhzC8ObKe5UOn8nBQ5aBBldu0NX2VnVEokyp6oOQmBg/O2KJQgTVCm1x+EvQqeKHtsm
 84Na21EQZqiNN8g1AuxLnKQFDK1i4l3u8Dnzo05xBQC7u8lrCcPk32k09Oz7TFTlPxYg
 AahDPX9izqrvpslLpjcTeEpLUE0Ta0AnSP9YMzxR3uu0b0Rwdw/2IQFzT3cgkfuSppSH
 D2lw==
X-Gm-Message-State: AFuF++nn1HN+9kYLhjjE/bS4XWlKAsvAcgCp9KoDLXesP0pjDPE9qjKV
 okIudXy+hWLV6D+9dRFgNGIJv156q09RscyMsdLEo09ukB1aMS13S5/sadIY3bib453D2wEFxer
 SwhUJu44NEuS3T40PnqJ7U+QMLSh+XP+eEo2mGBZDt0XEQAAeUnpUoIq0lRIqOMCKPOBi
X-Gm-Gg: AYBFou2gaMZxRI3k2+Zw5Xt1eQY/OhVSnONy+hVbDTjX9GhuQJfNGDP4F9Ppw/lV3Vd
 Ha1YevKlz3NYhOyDGfn1ZqqBBI3lC5vbNw8fkFvBTwS+wGhLo1p/UYVIdTX5SVzd5jiWNKqWo3C
 ZuPDsCQT6tldM/L6p4OhN08cRrdXibI3oX037V4oNCPfzsF1ZiyD0mauMtunwXLveZGnaj+s4c9
 BB1MIvmOhlDKykizFcH3v+sLyrG1IdIjQe0e5xgAX5SPtowo4Wa+r+FRwkAjIVmGqUhgb1cLGee
 B+j2HNDsfCEDoA1w/zsMZLqy/m/xB5UG1XQbXHmuAPwTs2Cmzh+a8eeIqJr3yKCCu1GpmjZ4Z8C
 6HWf6f+CIUmufZY8O6kcvzdpyjg3hpiZVyFCQhgW5/RN67NT+I7mH5LNZU+CStE+s88TX/DrSeh
 1ZvRaSLVrUeANxw7GwaZxi93ybRbtXJsZG9T/2UeNIT4MA/YXX+C67PccJAZzKrLheUPeHrGWeD
 dbLA0siUPNSS5V6ptOasmfN9K+X3m741oP2HA9mdoNdJfJ6IdJUEAKZ3+Iq1ExEG/nJ3l4oRiVb
 oVCGaqPrjoS0vld1e14wLgIYqme9/mgMJfR2D1NhpYweSgET/WJ9sYitHP3n3w==
X-Received: by 2002:a05:600c:4705:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-49eb7346f99mr76995565e9.19.1789652595577; 
 Thu, 17 Sep 2026 06:43:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f6cfsm15994803f8f.13.2026.09.17.06.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:43:15 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:43:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: b3a00b7062b771c60dfb37f94f2da087c53385e2
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:43:13 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d2f305cf405e1524f77ef6806fe41aa1076f6dd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7COY-0002FZ-7Q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1061854433461352677=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1061854433461352677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pW4SNlA5CjQ="; charset=UTF-8

--pW4SNlA5CjQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919?usp=3Demail )

Change subject: Document notify as auth pending me=
thod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-1

(7 comments)

Commit Message:

http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1919/comment/81df49e6_18e4367e?usp=3Demail :
PS1, Line =
11: a while to completely and enter the auth pending state=2E
Typo: "to com=
plete"


File doc/management-notes=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1919/comment/7c7971cf_e43f632a?usp=3Demail :
PS1, Line 800: happe=
n that is outside the control of the client=2E This might just a
"might jus=
t be"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/b6f1295b_71=
ad7cef?usp=3Demail :
PS1, Line 800: happen that is outside the control of t=
he client=2E This might just a
"some out-of-band authentication happening"?=
 ("is" is present twice)=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
9/comment/413363d8_befd70d3?usp=3Demail :
PS1, Line 806: For the user this =
is
Is this text intended or leftover text?


http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919/comment/9e01335e_02ec94d0?usp=3Demail :
PS1, Line 809: bee=
n defined yet=2E
"So far" implies "yet"=2E


http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919/comment/8bc2e051_2520c182?usp=3Demail :
PS1, Line 814: An =
example message for a message for a server that does some checks against
Is=
 "message for a message" correct?


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1919/comment/d34820c0_2999ef0f?usp=3Demail :
PS1, Line 822: this message=
 is not negotiated but can just be sent as a gratuitous message=2E
I might =
be missing something but IIRC the notify pending auth does require action o=
n the client side=2E Did you mean something else here?



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda25=
46
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu,=
 17 Sep 2026 13:43:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--pW4SNlA5CjQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><p>7 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/81d=
f49e6_18e4367e?usp=3Demail">Patch Set #1, Line 11:</a> <code style=3D"font-=
family:monospace,monospace">a while to completely and enter the auth pendin=
g state=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Typo: &quot;to complete&quot;</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1919/comment/7c7971cf_e43f632a?usp=3Demail">Patch Set=
 #1, Line 800:</a> <code style=3D"font-family:monospace,monospace">happen t=
hat is outside the control of the client=2E This might just a</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&q=
uot;might just be&quot;?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1919/comment/b6f1295b_71ad7cef?usp=3Demail">Patch Set #1, Li=
ne 800:</a> <code style=3D"font-family:monospace,monospace">happen that is =
outside the control of the client=2E This might just a</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;s=
ome out-of-band authentication happening&quot;? (&quot;is&quot; is present =
twice)=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1919/comment/413363d8_befd70d3?usp=3Demail">Patch Set #1, Line 806:</a> <co=
de style=3D"font-family:monospace,monospace">For the user this is</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Is this text intended or leftover text?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/9e01335e_02ec94d0?usp=3Demail"=
>Patch Set #1, Line 809:</a> <code style=3D"font-family:monospace,monospace=
">been defined yet=2E</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">&quot;So far&quot; implies &quot;yet&quot;=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/c=
omment/8bc2e051_2520c182?usp=3Demail">Patch Set #1, Line 814:</a> <code sty=
le=3D"font-family:monospace,monospace">An example message for a message for=
 a server that does some checks against</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Is &quot;message for a m=
essage&quot; correct?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919/comment/d34820c0_2999ef0f?usp=3Demail">Patch Set #1, Line =
822:</a> <code style=3D"font-family:monospace,monospace">this message is no=
t negotiated but can just be sent as a gratuitous message=2E</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I m=
ight be missing something but IIRC the notify pending auth does require act=
ion on the client side=2E Did you mean something else here?</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1919?usp=3Demail">change 1919</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 13:43:13 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pW4SNlA5CjQ=--


--===============1061854433461352677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1061854433461352677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1061854433461352677==--

