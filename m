Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F2606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IreZId7f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MLQBgIRW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NOdI6aqv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BenRtza8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=847DMBRS3bTSDeyOQ3Aucqe75QbHt4tng7Q1nscv7uU=; b=IreZId7fpzEz59COIwHMbA3Xk/
	MVafCIrtVAYu+5AUzeML8CJHegeexUzN8+YmKKl20wCw6BWa7Bgu8LLMzHEPpT9oH5QQzlwApVl1g
	6yrPQbDZDh3dFE8ioDnjpMAX4CgNC5dX0+nXgAHq1l7jcOx7E0h1khEL8hSwEbZFWADU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrnJ-000000002bq-2fzf;
	Mon, 02 Nov 2026 13:09:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrnI-000000002bd-1Dil
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iX3Ve9IRk8o8SjaYgMkCK8ahNvWkZCxOYhY8tEkxDUY=; b=MLQBgIRW5oPkDzQCvWHozUOlCx
 IT1d6a+2MfGTbIj+xdRgHGxRYbhdORA26FwvYrZEtx8GMiLrfyVZ60CV+mLgqtbpCMxAszlP/KHEV
 lM7247dYz5HLFbfaFeD1gQ7S4iArwZfFsk+IPr82nBwSZk0VxvP4Bp/OCwbY3E1qQxQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iX3Ve9IRk8o8SjaYgMkCK8ahNvWkZCxOYhY8tEkxDUY=; b=NOdI6aqvYnKRF03gelMykeimqN
 hDHuyHWUed/Ph+WwnrmV7t1ZgixLWzSXLaOShAveQuyL6cmpjJ64avtQb3bhM1DKEvZKy7K4X095c
 0udb3rTUVHMNxou19SgPSCC87Li5KQFkuOssKXKzWGkjUCds51PINKiQ4wia60FAggq0=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrnG-0000000080m-37UC for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:09:48 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2445839f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624980; x=1794229780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iX3Ve9IRk8o8SjaYgMkCK8ahNvWkZCxOYhY8tEkxDUY=;
 b=BenRtza8C1d6hDAFMmEWFM6em488aRVruKqeXiEbAXS0TSy4/F6Lf9hFQvV3kQVWfF
 +imo7JLZc/M+xnBHUVinWUTya8pBQcSYjqJJKdM8DdiAssVw3bKyYlyYWnJV4cag84NP
 jn+T0DLHAw0JT54ayvdXmcQDjSIuBY5cZcgbP1W9iSp0EbHLN5IT4Ap20PMzVhCzA15f
 ovRW/3XHtQrG0ntTXphoXx/EELZtdn9i1vA8U8mXI91vOfLdupaVjHELxMwzZtZQ+1W1
 daNhinT5aMc1nyVgXMCq0JoHLGNzulmumEbx1vWF1hsx3T99Ri3jE7KFVnIAqsx6GCyE
 i/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624980; x=1794229780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iX3Ve9IRk8o8SjaYgMkCK8ahNvWkZCxOYhY8tEkxDUY=;
 b=IQMjsQdXY9igFP6pMEYiF7CvoooUgWMA9KcqeaIMIwOvWd98IgHHRy8CMBeP0CEUKe
 7g5WD0aN0Mliq9auv4L3C8IiVjmuUikA4ai6uaVrErtmWrFEV01nBYnLU1ll2SOgpH3h
 sg3UF0WWQA6z7y6/HJksI8h9jZji0tZEQAH7fE9eMi0ciaGnL6usy+ZLCyjPf7cI9HXy
 ihtC3f4vh8c2trbGLxEebCngME56WrZAZr4IRWOkOrs3LBnBZFJkEm55d2YN6sAUfKTC
 VrKHXxLICkt+W3ZhAfodcfOA4RApA/MytJ1Qo7amteH1R7eW5DuwCNI1iWtI7zHnet/P
 HC2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzRdczEf89eV2dftbkqUm5ctJBK5vuSoSCAmTdlpnmQsMpi+6WwdfzyLryvMjk1A0F+3HmRGkRkRZRUaNe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/IL3ojIsHNtcvOya/iIh4uvTtyjO6+noGATLAeyioY3k2HGG81
 9jmHDzjC7FAdWI0rSX+PqW3tm5au702pVvBZVNsJPi5OiK0yLQHgHCVzIblRCscESYrd5ruperA
 5CKVUOyeIbFtdWV+o0ncyX6MBtdTpBilHeI2jDR5ksGtdE6p7Z03R1LxR+6nWUYMVO6Tb
X-Gm-Gg: AYBFou23ypgqoyrKHQWlO/UK4NWGJaNb7suDFQHdP+bEySG72bz2nsdjakZvzu4jySk
 ruINULeE1t2OwkVIPCTavzh6hL1yrxSQXde2bO93IGG+j8Th0siW+fVEDplYXENI7ZxBdYonazQ
 OFNjJn8gksuZi57dzrQCIQKAS/P7AsrGTzfAv4XRqxWeDDa42icdfHV1b0E+QzjhyR45xATlhSV
 W0dViI3GtLPvJa0UrLEW0/B5iIgCMsmus/R0kenye/maTdQc5kh5w95fH6/i8dA+Umurwme+0Td
 Zrs6vbqs5bnG0rSSowm+U5OYTwBPYw3PxG3nH6wd34um0GD8CoU9FOpC52FaajPFMAbXd6M4XMY
 ROzbCAhR9D0pyhBYQ7aZR9WjoiDtYe+5ACdmeOFNVY26udwxzLVBF0WV12C4+nG0oFxHJuAV5HZ
 n85eLJ7p0IRnYmzsjiqwELh+1wBDVuMI98p5J3YmrO6UE+P15hlvIjw7RkUqXrjexXatZ9vzKDl
 MuhOHaSY3ZQFi9kYaJoaWrFSEg2GjO2cL/hWGYGt0akTfguyrqUbd+uXIuHehIZ4k1qhwE9pX4J
 TRD1MNPgVacjzmDxdvLwHfFn0sFF7JbmUcXTxajaxNEWRjVUiCqmRRE+n7c5NfRDaCvyj1qNXSe
 F8TdirE5RsBpUUbAFXs2rwwMcNJ8A81r0/k+/6BWuA+AJYQ4hPrn6kBRjQKa8ArwfQofKbQNHMh
 DoDZTXx+2fyRLtm0mSvYgMWV/3RKpdNDorhGc=
X-Received: by 2002:a5d:5d84:0:b0:48d:f99d:a0d3 with SMTP id
 ffacd0b85a97d-48e6e526679mr22108462f8f.46.1793624979822; 
 Mon, 02 Nov 2026 05:09:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728ddsm19805476f8f.9.2026.11.02.05.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:09:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:09:38 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: ededb5b3b364d350fbe8fbe023eaf33d42ca4c29
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:09:38 +0000
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e05080d9d43c4a0ae296e31829aa6cb46efcd76-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrnG-0000000080m-37UC
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Check for
 null-bytes in certificate subjects
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3559669691976507660=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3559669691976507660==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZLB77JF/64Q="; charset=UTF-8

--ZLB77JF/64Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

Gert=
 Doering has posted comments on this change by Steffan Karger=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail )

Change subject: Chec=
k for null-bytes in certificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Patc=
hset:

PS2: 
yeah, we move onwards=2E  The build fails are unfortunate, but=
 as the builders are being upgraded, 2=2E6 is falling behind on "new SSL li=
brary support" (without warnings, that is)



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: release/2=2E6
Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7=

Gerrit-Change-Number: 1998
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger=
 <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: S=
teffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:09:38 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ZLB77JF/64Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>Gert Doering =
has posted comments on this change by Steffan Karger=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1998?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">yeah, we move o=
nwards=2E  The build fails are unfortunate, but as the builders are being u=
pgraded, 2=2E6 is falling behind on &quot;new SSL library support&quot; (wi=
thout warnings, that is)</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">change 199=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1998 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon=
, 02 Nov 2026 13:09:38 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--ZLB77JF/64Q=--


--===============3559669691976507660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3559669691976507660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3559669691976507660==--

