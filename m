Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4006606A33B
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nCxwPhPc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MY48KKa3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KOg+5aHD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FhhlK5ia
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tS15XJT/bkxPuzS74fXRzl2KC10W4DUfSjXHnQ09l5g=; b=nCxwPhPcwbe+yA75TZYGYVnsuH
	2eLyIxNTPT9THJzoQf0tZzREM8H2/KV1LKnjkjlRmEivTIcWMYkUq2DlAOTL4cp+Uyy63adoJS0ox
	5INy3qsrvgfqnjxMoU/OEP4HQhdVZhluc/XeH+1irk30DJRxIxae+YL8I/AeMR5uAWWg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkn0-000000002Ng-05aT;
	Tue, 10 Nov 2026 12:17:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkmx-000000002NX-07IN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjMo0xagu4llAFh4JtU1aKh+16ohMocbQes/of6hBuY=; b=MY48KKa3y4KILq7uTgff8kd+AQ
 mtsNLc8ualyRTffpSlHcRPpWP1Q8xgoYH/DR1L9XCOoXCWr/IoMsxv3iMyIduY7/2ya7QYwUI1c4i
 mokDjAHDy1+0rHUBUdHH+lA5cwKi8FXFyBqXTU3F2qbhLKfOm3SkMx+wiDTSfqtaxBWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjMo0xagu4llAFh4JtU1aKh+16ohMocbQes/of6hBuY=; b=KOg+5aHDaxKYDWwaCP3Tf3Or0K
 eXl8eBdjbf1Y8mh42ogI0X86FQVJflOhMMVpwciKGP+xUcvcXD7+Ui+gcM++JHaQBsgXo20YqLpnD
 GY9jI++xQdBJOxg/EgLISzoy/vtyEvcsv5gr+ep5g0iLIMKPsxzUezKAV42RKaPY88uM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkmv-000000005LG-2eHN for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:17:22 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4919a880834so1200936f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794313035; x=1794917835; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kjMo0xagu4llAFh4JtU1aKh+16ohMocbQes/of6hBuY=;
 b=FhhlK5iaxI+iRGJWynqGiXUMfuJATtZNDA/4lBZcrGU6UZ6infv14qgKQQQ1dOFQcI
 cHLXd/xUrnxjhVS+qYo/CgpJ96R9jVi9DWBkrZhemo8+MuwW4x8GBlvDzsTQKrri2gaL
 BUHFjn6V7hYB+fk48P2AF/AUtZ29jr7AIttultL09q2L4q8AuHBQLsdWcS4eRfqPOW2E
 OfqLimtpfffvbLKHHoQOiQWGtL121DiKkZMImZu3m+jR84gQAha62oVjdhQfqep4O/Gj
 FIsQY5xCsbudsOl1DZYxciFBJaYrJ64qNdeJYKS/SAg2Nj87IISYYwoiADeukKrkksj5
 +cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313035; x=1794917835;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kjMo0xagu4llAFh4JtU1aKh+16ohMocbQes/of6hBuY=;
 b=wVKEhbFmZqxDIche2oFz5v2EietRuMVkeIC6Y2ayXWrqSV8RJ1bnSTddcUuBiSXHik
 coPQTkFH58b9ta+NvEMrNcdL66dOEEFhLgBJhojdY0/KWMSF/yaogppcwyuV6KXVsUfl
 jX/YacPI/bZ2DqUg6lUi8e73uDEgYGE8ZUPp46HC6HtfI/jw+oYHHlDzIKXiL50l56zX
 xOQBKs6XJ9NXiDKRmRFJiKwqZMyc/gLkR1AB/NhEeCtbPMwwTQmEAiRzThCmc3JeDO/J
 kMf4PZvc1yUfPmqqEypKs62MHej6HiAMW71sDEgt3czX9V6TFjY8VTRt6iP1/Tpk1Ubf
 sc1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGFor1n1krqleBs2LxDbleKRissO9RpvxVNyzYrUawjajO+UbVz+Ges/gfbMI7ADUUYAzbqYYCXB8tqfRs1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8nXXJ4bvQA63e/RSFQgSiWaeFLMHuRqQFi3qqlfibbaU524rKn
 xVNknnLd7lg0ZYGh9VuTJLkQJLDdqyb832mN++L8qDU59iL/7qbCMWYY+KVvPMUFphYIZOQF624
 asLVsk4woQj//WjTQHsg1rtGggNRWHbFrgErPmP7rgztYWaWYLb23epel+q5tiTUAGwjb
X-Gm-Gg: AYBFou1KS/IvH9xGG6Sf3a3pDgcxVZaFbXHyA7j5T9i1wU9ObSqPLSmBAAYF4lWieyf
 +0ahBkpxn5pzjjx2mSXa934qJw2JBGUILD1c1CgcPAtFxXkNPLBb0DjnvYLsRNpI3QVUOuJaGcJ
 0j++LjNUlmXJy78J84J0X7QWW1T9jyNcfB4JanXP4x4QNg7ispDBREbEwTYVF3X1HKLqCj8L324
 1nr/ih3MECLABY6RyJeh66dYTHIF3Bt9m62b0Mj/1ygny5qAvH0HOLC3lSUrZxWzbWwK/7FvKch
 J5uSxn1cVXefqI2jRpYjZCyTXntgXnifu0Efxoa12oW844Mnl8czqoZxchyC/Yw1vtxW70WaU9I
 kaucGv+HL1GWPDGUALQvkpH7pVR4dsVC71jWh7xyoU9R7flgZKXIe5PMPcz6gYujOch9YYI2hAK
 28zrJc0M76TnaQzizMlKYDJpEOL5S8ZopwjgjqGdyODrqZWhWRUveZry25DscuHxzAUMg8KB03a
 b3t32b+U2R+0mCZBThjFR0E1FwK9IKEFNtUDselcobO+pI7IMKl6sR9VaRmDOwdTZNUXekzADVV
 2GpJFJLT9pLOZd5LiiZl5eFlti9u6dVG1g3nidZIUvrQVwKLOhbwZjebtWzFL9YlfCwPRz7iW+m
 EIC9AdFIBVz1Rnwf6KF9fKmeTA5NpoWAl64Vgk0waaIAVf7CmdGlETjUg7J5BSyisrqfSWYPUsh
 xqfQcezfMh7Al1TL8=
X-Received: by 2002:a05:6000:25ec:b0:490:f775:b00b with SMTP id
 ffacd0b85a97d-49830f6ae8emr4447242f8f.52.1794313034490; 
 Tue, 10 Nov 2026 04:17:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4989a2a505asm3221887f8f.13.2026.11.10.04.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:17:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:17:10 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 3f8d4f6fe041f8005cc926cd887cc0a2a6fe27c6
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:17:10 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00be5cc01984670e6c5b46af93bdc25aad38a179-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkmv-000000005LG-2eHN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2394674240052602330=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2394674240052602330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wTt6Xq4lTUw="; charset=UTF-8

--wTt6Xq4lTUw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2:

(1 comment)

File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2158/comment/45fbdef0_3eaac5d1?usp=3Demail :
PS2, Line 539:=
     const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);
> But i=
t is a difference between two pointers, so it feels appropriate to me?
You =
might be thinking of `ptrdiff_t`? Which I agree would be better than `uintp=
tr_t`, but it's a signed type, which makes `size_t` better considering wher=
e it is being subsequently used=2E



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2158?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Gerrit-Change-N=
umber: 2158
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 10 Nov 2026 12:17:10 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Frank Lichten=
held <frank@lichtenheld=2Ecom>

--wTt6Xq4lTUw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/45fbdef0_3eaac5d1?usp=3Demail">Pa=
tch Set #2, Line 539:</a> <code style=3D"font-family:monospace,monospace"> =
   const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">But it is a difference between two pointers, so it feels appro=
priate to me?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">You might be thinking of `ptrdiff_t`? Which =
I agree would be better than `uintptr_t`, but it&#39;s a signed type, which=
 makes `size_t` better considering where it is being subsequently used=2E</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d=
1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2158=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 202=
6 12:17:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div sty=
le=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--wTt6Xq4lTUw=--


--===============2394674240052602330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2394674240052602330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2394674240052602330==--

