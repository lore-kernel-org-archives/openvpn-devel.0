Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DABC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lr4zx1dNtPynXqW4GhmixuUOtH+GEG3KEbzYEQRlRpk=; b=Jg6GANyxqbrwaP+foQ62e7jNCw
	5KPrgDPC33Uxtix2YzSpMEduD1yZRNrdtwdOx9Udak4N7tN9s1Q9oCz5XJjTnyeOYOhtIlw6g8iHz
	nsyqkzk/OT4+YQaPLxk4NcoHrToGJDAhVTesxqe3gI92iChEIZ/TfNJkryWdrq1eqJcE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzqfc-0001nX-1v;
	Fri, 28 Aug 2026 07:06:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzqfI-0001n8-83
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vCbjHYBB41uXXp5Rj0xVuVhMGEfDSgoPkCshYMDr5TQ=; b=JfxThmcghn9orpWNzKU6lItx4m
 Fd1B798PHqT2ZwD+aCfmB0VMAKQ2LWKeUJqgxAJpSEN8iWCqnZBL9+bWXKxPg6wEwBPibrGaRUuFl
 /h3MwvnuppdjN/AW9lPUxNfd5gYnQpCRq3bf7FLnLMdkwSzz9N3Ki9kfVtxxFbRDgNYw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vCbjHYBB41uXXp5Rj0xVuVhMGEfDSgoPkCshYMDr5TQ=; b=k
 21cza88+zzmTmqAMjBjTMXhDjrqmFK7e6TKh90jUJzkNQeJciOWtjaY9uwLbyCPu5gumCOFwRjIjo
 BYhLNhhEkLn+yb5VkWjtuycPkg8aBhryniiMWiz8ySMnYHNV8EpON1zvpOD6RB5OIo9fN7yJV2cSw
 RO6f38FBBEwz6fhw=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzqf6-0001Cz-NF for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:06:06 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso2942225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787900758; x=1788505558; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vCbjHYBB41uXXp5Rj0xVuVhMGEfDSgoPkCshYMDr5TQ=;
 b=T4JwjKQ20Bic1MRRtIYuBZvakD0CbwUJ2dc+oHDsVwZSFeeyGe0Fv1FaTGEzOP2pEX
 2EHU3p+/F7ETFoRYWlQxIj+4A6w5671y2KohBKhqQ7wydhSslqS5IR8yQXFA2FMIPdrc
 YqSSsyrZmVnzswP2yonWu7VrY4liGys/r2/Yz9UX5m5iFxisYdilE/F8IVelpiHp77+C
 8mzSyhGyZmRygMdGmpB7j01YGjh/tHuCg3qzxDaE+m4TYkqBK2Wd/3Rrfr9e6nFXdIju
 Nq0Qpcczg586YxeQq5Rk1jFcQLFPtu9yhkwSKQ9Efv2xWET6UVD3YlcaWVJYJgpBaAFQ
 jDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787900758; x=1788505558;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vCbjHYBB41uXXp5Rj0xVuVhMGEfDSgoPkCshYMDr5TQ=;
 b=dPjYovf/gc0V6e2vZ5s7HtOzfsZohido1UUwZ9jDIc4gIUj2XzRNDaixdbBOrJEe1s
 9n0nEcPAf/QcMCLysm8dgVpon3vFyhrJeCW7RldTnSK3WFIUtfrkZv0tckfCR7/k10e0
 rjAvZssG3oydBiNsX4BBfHKhHRB98VJpHhcnb1TPk3hj+kY4MKChI7QGfol+y1LqbpnH
 L00GFTYXh4onLXOHmYrOv8MLQINCk/HjMbr67comgORcRCEw6r3W/QMPDXkDtiC4yf9V
 OJrewnzXegN3O8WoatN+64Pae66Ew6a6p9WIsc071tgP3WV+jQlwGaIHxoZCi/FcGkGV
 XuIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP1WaAl6x5RamWhfyttU6wGc1vSWQcmSGMaS4zv4eYeoVkK7sJ5Y4XDHQ8r9VCyuWbvpOJRaPP4kJkw+HG@lists.sourceforge.net
X-Gm-Message-State: AFuF++kdEcJu0PQBRFP6tn8Qu8C6UN4fyjjy3QO2TyN67+ak0tDeaOi9
 UNoNhCVsJtw3oGyiOEJw8JHQMHLN78iy6VrGQXoZ1IvDB/Xq7gqQo81xhm7cIPqxZs/U0CzGRUI
 39a1xLvNWWa3eFlHHs8ie3bMITvk2t5G/El0AUDdX2RutYsX85Kwg7wm1zTxHA/opgUYB
X-Gm-Gg: AR+sD12wocPk5SRN/2+6purMD9vJbgwL5tuT2wfGPzJBWZkGRbsfBwnpwa5+JTpPtNj
 8ardgCy00HZy2GXRRczxonEKZW6xeyWH9uFxbpbIe8eXZN/p0VWsL0Gk78ib/5zDcYDIDfwfrDS
 Ps0Q/BBGw6dxppW1RAKNaS4uuqIzucyVAvoRa0giP6KPVHAfaqwXouWDY+lfWtYnS6sHfyvYU/b
 /CQUubFewXePYkZ21ksRgYbcZg5xpH6i69VVXBKS+Cu9wndZbQJiFej4bei0kQOS8c1xHADPe+D
 YRMV/N7OdFNKgaq9SJQltUuJn+qlw8dY/LEna0KkAryR7vPVhnlyWZJKf+fHzf5zu1U5aULZdN5
 MChlFm2AVqjrn+0V2xTFvjaFY0LqgADwfUNwXSXQ2hli8srUIWWZsj0HgNjYQ91kGHjaDWndWrP
 /XbVFCtS5sMf7zezLT/j4HUDT0Ke6kaKIfFHREIjOGcKCuxc5edYx5S0QWRvc3UxWzMX/CYf618
 +mRH35WnLfMPC2tvrE2A/OHNLqtRliZuOwQDPVbCGk155dukK3dAlXGbF0NfIVD8AJSA5A6THoq
 BB34drSHaM4l2Rob+x6ZcIoMbHYSO76iUtLLRanTz64YwZxsfFg=
X-Received: by 2002:a05:600d:8449:b0:49b:96a0:5c00 with SMTP id
 5b1f17b1804b1-49b96a05caemr22188085e9.13.1787900757985; 
 Fri, 28 Aug 2026 00:05:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c44feb966sm4248525e9.6.2026.08.28.00.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:05:57 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 07:05:56 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af300510350e2496a17f0e3e07ae22107bb42d5a
X-Gerrit-Comment-Date: Fri, 28 Aug 2026 07:05:56 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8be5a6bd174e415f609f15358faa3aeeb3f9e16-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzqf6-0001Cz-NF
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7008700348427824854=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7008700348427824854==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RHBkiO9fsXE="; charset=UTF-8

--RHBkiO9fsXE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, srkyn=2E

razvanc has post=
ed comments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fds=
 in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review-1

(7 comments)

Patchset:

PS1: 
This cu=
rrently doesn't build at all under CMake=2E


File src/compat/close-fds=2Eh=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/b5a8e1be_189d30c5=
?usp=3Demail :
PS1, Line 13:  */
The rest of the files have a more comprehe=
nsive block of text about the license, we probably want to follow the exist=
ing convention=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/=
e7c13955_06de8eed?usp=3Demail :
PS1, Line 19: void close_fds_except(int kee=
p);
The new function lost all previous (Doxygen) documentation explaining t=
he need for it and what it does=2E


File src/compat/close-fds=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/0e85c547_3db5529f?usp=3Dem=
ail :
PS1, Line 12:  *  as published by the Free Software Foundation=2E
Tru=
ncated license text compared to existing files here as well=2E


File tests=
/unit_tests/openvpn/test_close_fds=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1881/comment/a7daec1c_2276922f?usp=3Demail :
PS1, Line 12:  *  as p=
ublished by the Free Software Foundation=2E
License header doesn't match th=
e rest of the code in length=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1881/comment/f95dff6f_c2a250a7?usp=3Demail :
PS1, Line 36: run_case(int ke=
ep_target)
The current convention AFAICT is to use cmocka for tests, which =
this does not=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/1=
14c5b35_7564e0eb?usp=3Demail :
PS1, Line 109:                : EXIT_FAILURE=
;
Might we also want to test that fds 0, 1 and 2 survive?



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa28=
9dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 1
Gerrit-Owner: srkyn <da=
vid@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Com=
ment-Date: Fri, 28 Aug 2026 07:05:56 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: Yes

--RHBkiO9fsXE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, srkyn=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>7=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">This currently doesn&#39;t b=
uild at all under CMake=2E</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/compat/close-fds=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/=
comment/b5a8e1be_189d30c5?usp=3Demail">Patch Set #1, Line 13:</a> <code sty=
le=3D"font-family:monospace,monospace"> */</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">The rest of the files=
 have a more comprehensive block of text about the license, we probably wan=
t to follow the existing convention=2E</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/e7c13955_06de8eed?usp=3Demail">Pa=
tch Set #1, Line 19:</a> <code style=3D"font-family:monospace,monospace">vo=
id close_fds_except(int keep);</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">The new function lost all previou=
s (Doxygen) documentation explaining the need for it and what it does=2E</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/compat/clo=
se-fds=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/0e85c547_3db5529f?usp=
=3Demail">Patch Set #1, Line 12:</a> <code style=3D"font-family:monospace,m=
onospace"> *  as published by the Free Software Foundation=2E</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Tr=
uncated license text compared to existing files here as well=2E</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvp=
n/test_close_fds=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/a7daec1c_22=
76922f?usp=3Demail">Patch Set #1, Line 12:</a> <code style=3D"font-family:m=
onospace,monospace"> *  as published by the Free Software Foundation=2E</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">License header doesn&#39;t match the rest of the code in length=2E<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comme=
nt/f95dff6f_c2a250a7?usp=3Demail">Patch Set #1, Line 36:</a> <code style=3D=
"font-family:monospace,monospace">run_case(int keep_target)</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
current convention AFAICT is to use cmocka for tests, which this does not=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/c=
omment/114c5b35_7564e0eb?usp=3Demail">Patch Set #1, Line 109:</a> <code sty=
le=3D"font-family:monospace,monospace">               : EXIT_FAILURE;</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Might we also want to test that fds 0, 1 and 2 survive?</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1881?usp=3Demail">change 1881</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Aug 2=
026 07:05:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bo=
dy></html>
--RHBkiO9fsXE=--


--===============7008700348427824854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7008700348427824854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7008700348427824854==--

