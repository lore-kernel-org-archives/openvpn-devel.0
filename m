Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF31606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WpadVPCS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ME+qkcZs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bGnZAi5l;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BqkZbRpM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z2wgUekiaKhc7zeKpkjoBpfytPDMzhb4qcj1nKiG7L4=; b=WpadVPCSWgRK+Qjvw/fOfgi7su
	+a2P5zZFLhI99iaKSNI36N83w0QbxYkuG3ERLWLHKnKdU/k44ngCq4MeoIi+myRPSthz82p/+zToi
	NYNwV+kyghqrmVZuAyp6okmWYoANAL/FqXZExsahh5oFYgSA9mvsqHaAAI/zandYVSmA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5tm-000000007TM-0d7k;
	Sun, 22 Nov 2026 11:38:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5tU-000000007Rv-0zJ1
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LFEq7z2CZZVcBgPrBWOW5nd9iFDN+xaguXRCv7xzA1Q=; b=ME+qkcZsmjQdTPXkzQLDGJhqMR
 la2WD0Dfcwhk1nHvWuJ98NnYnUbUeP1LY6kJBsy4m1N7mRufQKPdXeFb7xRahjn7uugr0SZaKX85b
 91JsMb6n85p6H4wX+7jiflCSrMiLqc7Lascyo6PKfhDi+aQajYxtJsMLqcwE+y6KIYAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LFEq7z2CZZVcBgPrBWOW5nd9iFDN+xaguXRCv7xzA1Q=; b=bGnZAi5liZ1vRO/MhHRgbvkilq
 jt+AAAkdICFuC3tMrc0lRXLHJOa5sSOFqf3qi042iYIiOo8EgMfqLZuMfAkYkaVPRZLnDDNziyG2k
 DwOFYQSbM8KCtWEaf9Hpy3Z6viqlEz4024+s0bvsRVNmCrUXOFTkEnuC2iQPawj08p/k=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5tT-000000008H4-1TdK for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:38:03 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so1625823f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795347477; x=1795952277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LFEq7z2CZZVcBgPrBWOW5nd9iFDN+xaguXRCv7xzA1Q=;
 b=BqkZbRpMdZMhR/ugefmvJXxk+BPusdMv+cODJTau/P0H+BZW7qXt2BJT6OFmIY5XWQ
 Kesc9/CpsdDjLUFT+ek3cssp8hmu6WyVk7yMM0DM3XGVxPHgVW1roT4ozqgj+ng1vtHq
 bckrOxiZKO//CRwg1gnjyM4n0G5CdOzwp6UeSqIgKPjWoQ2BCgLDOc+zySBDhChtd+ti
 q2YUCqLkaYIzgDen7y7d5XKUfNNkgQ3EtYzBfKNJKnL3t1xfsZe6vEUlI330qtblen2Q
 Q4nyEgJqxsPbspkgFdS1my05YFgag1XTe3s6PFzUgWTnreWRWq9h+Y7pRlGAc01EzoLy
 M1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795347477; x=1795952277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LFEq7z2CZZVcBgPrBWOW5nd9iFDN+xaguXRCv7xzA1Q=;
 b=a9VYM87XdBpG7W2cFPGhoT/tqw9FQxCh92eJRHz1AL1bREk7ccwfJSWpYwRxRpFVvo
 VAXOQaVyclHtt1X7Rv/kh2kMR5R03y9shQmINW+GjJunX+jqc1e5m3i4ovYswNdHJPmS
 VhGPLq6ZT/BhcKCDgpjaj7uKuKmOodjujcP9F55Hjk7APJg8yPa5aozBWCeLRH3Wi1z2
 eyULGSVgJsgAQUrN+grrVjtx3htM6+8+BjJxDhVD/EiAhXvmd451ZBsYBKKDi18tPw3O
 FLlTJTP9RKw/AlQgoZTI5HM7J0VOEebgVJ9kA3AoyDpS6ygH3xyRlpyXXCUAQsaDfAtt
 iQdg==
X-Forwarded-Encrypted: i=1;
 AL+hErGvuyO5K5toTQemi3H7H3lS7lkiue4nIn5Y3BCOwgDO3tHDXmVSApB84Bxzy5bNa5/3oOzSsooKMR3tmY1o@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Zy9iacJ9vffEQ2cphM3o4KOrQ4y7G8cnXjPVQ5ZpuRcJnXpwg
 D1xoJVqrHooj1lSzHhY6FgP0MRQIxu4zNS2feM3r9BZ/6WGuKSk8np0OemZrJ50iQzCQKMpy2Z6
 ChOGKCIUiw+5a+1LPDHVIGvFvd+9jJl/gb1EkhPMou67uxiHg5sRYdRh3kL7JCx9iG0vG
X-Gm-Gg: AZFdTZfemEw0vk5+y4SsIptklnLszBzBhx+AQRcgVxVYvyu2mE4uT96laIMqJoMWy2a
 xxVqRqM5OUbnDzjcHSUVurd8YCglOSt/RE4VYziODULMVr3miCznnaHDd2xo3/PKJfs7GbUu9Q/
 88Es0c+4SFVvF0wj4WZmceoa2SAL5/pwxmfPmQCcNTGSO7i28cjoFh+6ilRu0QJ8lQrta8vcPDA
 OkrGolgW/CDZjNFB4FBdQRfYx4O7984Xd9MseAm02Dk4li2MFlbm07OSRKApgaQxM8b13OszFMM
 5fSzDWQgvb0inLkzyZ9hLp6eZf8V2Bm7OooMnka5xIzWTQgcB7cnFbAqSScRNxLj2c2Yh7yX8eG
 W44Q8g4Zfk7iRnABwfG9E53ins5fmRgRF9Ue8vozi/udz1JKAF0CZImJqb7rUsebP/Ml6KmT6Rw
 VohaaIZZ2TioeHbI9U8mD3joySZsU0xQpZn3AeUuW5APSsXUM38b88JLbzHwWAQb16tqAS6Rofr
 dwuIgvjOKASy3K+hsawJHg9pxXf8Suo1EemcyNAd92R/I0VleOTDkC6tomoWsLKtZEYj5OYiQC7
 nPKO0hMu06GyLtj4kPHSd8DjnMHDfvCzwojHk4TGy10leBPjAcAYbFNqTBFJR5KWht3LGRnkWbf
 APWRbXL71iBqrjAXwYX5kSC1g+mZ4C9GzAY2vNrlnODZRucIaUcg5G1f3Kb13BukHGDNUlhfuwx
 p4jgmQkhnh1jaHSik=
X-Received: by 2002:a05:6000:4558:b0:4a6:4ac6:d952 with SMTP id
 ffacd0b85a97d-4abb3a4d510mr10801270f8f.31.1795347476564; 
 Sun, 22 Nov 2026 03:37:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm16300235f8f.49.2026.11.22.03.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:37:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:37:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
X-Gerrit-Change-Number: 2231
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2231?usp=email>
X-Gerrit-Commit: ddb0c3e5ac790725e0c76f0adae8b65537ebbc01
X-Gerrit-Comment-Date: Sun, 22 Nov 2026 11:37:55 +0000
In-Reply-To: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwNzAwMDAwLkllZDY1MjAyZDI2OWRlZGZhN2NlNjllNjJlZjY4ZDc3NWVjMGRhMzZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6dfb83c2bd6b6da85c8b381f7940847943378cd0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5tT-000000008H4-1TdK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: use
 report_command_status() for client-deny, client-kill, pus...
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9104653937959131349=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9104653937959131349==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7GI86HfvbHQ="; charset=UTF-8

--7GI86HfvbHQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail )

Change=
 subject: manage: use report_command_status() for client-deny, client-kill,=
 push-update
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2231?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
Gerrit-Change-Number:=
 2231
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Sun, 22 Nov 2026 11:37:55 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--7GI86HfvbHQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=
=3Demail">change 2231</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2231?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2231 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sun, 22 Nov 2026 11:37:55 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--7GI86HfvbHQ=--


--===============9104653937959131349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9104653937959131349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9104653937959131349==--

