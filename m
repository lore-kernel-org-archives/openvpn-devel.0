Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4199EC54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8Ysf/VsIVU1QnbbsDJJI1rvQDFIdd2LUspb6rdNc+A=; b=IRpiZamAspkaoAdnlu1qbWuYqH
	dmbQoq/cHX19Doap4XMqdgXSHwkH+zm6JP2i5kfGfBAE0KpKOFnQ0o/IThBvmo4ZTkIqDScpjoUWw
	paIJJq0Aq+x8wf9d8wCO1p9Mis/oFHbHgmGwUrYTQXxmZTIso/a3aUjmp6HjMbTefJcs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojNC-0001jX-O9;
	Tue, 28 Jul 2026 15:05:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojNA-0001jQ-5z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ngmyGZ34P9F/JkFDgjtGXQcaukXi+uyLJn6otXnz2ks=; b=F9/48C5dvQB1DzZttEYa53/u6q
 BtkFZ1kUVK91s5sv6QuQllSZc3IIjCSCgz6or6zl6tJYuRyJUvrrdRi+/CI7fr90DHW1tEfFi6k/Q
 SZni9dJTDXWeblkPZ7qvEgsY9Qjr9am9Y/Lle93sGN8YTTq8FIjpDqJECULi8QLS8TPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ngmyGZ34P9F/JkFDgjtGXQcaukXi+uyLJn6otXnz2ks=; b=G
 132SX3bPZAnRDTL+QuSwY8ywmzMmi6C8m+zvZ6QGG8tIXKoobYoHA7+t1gXndoZJfuaR4l/reXjE2
 XmYPvrhNhh84P4EDJASbo+aAaBccroCbodP7ywuE/d7lHPKlemKNHRkDVJwg2YkGiPQvno/IB53wF
 6bfQChLf5IPpRXec=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojN7-0000Wt-24 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:31 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47640541585so2591314f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251123; x=1785855923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ngmyGZ34P9F/JkFDgjtGXQcaukXi+uyLJn6otXnz2ks=;
 b=J5FQjXWaWwWP0PTGIDYNwsC1T3CUFt24z8/OPKhECErXQao/2VlO1hRXof6TCd/wFL
 QpE8MmxunYMFYQYRi1a1pBhfWmjeVDEj2TGT0IMQ1HKBanXE0goDpdCY39ZTmwYH0DUQ
 VFCxrbpMMThlSlLMEqw/TUUcOgk32izQAJ0HwhDQ8Ch/FWpZcJnfWaQPFUp/2LY9sFUt
 tT+dS/dW7mWbrbVYdY4JcbjQYxgOcX6jBIJEeRxv0/TQldax7hI8MreJIlDTT5/I2y/I
 BQZ2iW7brgGf0csWsgJRc2YTVkZTF8nQDXVLrab8PLvvReW9weiGEZjrkltwkybu5Cj0
 UBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251123; x=1785855923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ngmyGZ34P9F/JkFDgjtGXQcaukXi+uyLJn6otXnz2ks=;
 b=odEalZcJxZWk3Zm7GdMUfCYSLkbtOeFYT8UQ0PEjoCYEQR7WSpL2EMWtcGNolLYwG+
 LgrsQFELBvSd0k0nV+l5q3cTEQ6Vc0ahCb9M684gU/2pZ0oUtV8j5JTKWTei5qN24g1P
 bAgIbvEFpAPB4J/r4pxDtoBAzE6nJuBjcd6c13kuroiIhV3nS2dmxGGJoL+62zXReCKJ
 4O1LuJTtzH8Xl3Oo2hrOJ+icyqZEZA3bjdZh8sE2ZlH8k3XZwkb1dOWhFHtiS4XsP3S9
 XTJNIBSkTcF6By49tPxuv4ob03bNzcDhvwFpL2MsShzcSUUhoVyMftVCfZaNllxfwGaf
 91NA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK4vfnKLGm0UZ0K357KIhUeQ6r6pMfLblTt52xhW4H7jXZr977mmbVXDwdqdbuGSozzxPnG3cAYtfsLDjn@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9gV9C9WBzwwlRRojHZcsM9WGewQ+ZWhOs5d+KxhfOy7eUOSiD
 TvN+w1BqAQqyFdrZCwNKYeqQiEgcVovCrG7rrNMJQdR1o+fQTwWSKCc4nLZdQ3N/hIMShhSz0sk
 BkuYmW1P5s28anHJn42nbVfiqcDdF8B8mcT+q/QTNGprPODVuqLFXhCcVD5/7TFiFXNUO
X-Gm-Gg: AR+sD12/XEX4WSK7A6Q9rB3lkQtW2xsMgJVQfjzySntG3WQwMqF0CvcLZ8KzuwOuDbb
 iksgaCY1cBUjQp++D9c/ylf6QZVaq35ovodScTfSLS3vC/eTCgLCTlaSnb+ICBnEwhKh2gfnMGD
 Tm3la5WE58guTne0VBzp0mcJ0RXR+7RF7vYugbxyPY4IRLueWnAPJOrBBjangAk9p61amEKsUQX
 EIqSiOTrYNv4CLWzoSVWn3+ArfrW9Ft90/2Jrdibvc563Zm4u9cZbzTaVxIPKgnm2/rCHbrZtm3
 2DzQel0dHEvA9h6QgTJ4CokouHkFjSm8MO99KoTeqlJe1qFqTvVr3Zq5avjFLH4gUPEpEDT7FbS
 sYyLCYZqqLFJNt8M4QAbQza59UtOeAPwQTTbrbQyfmEaRfFJx5c0fpCtnloRp6q+CjQ4P5ePENw
 e9Gbhi/csZPQXM1Sna6dpkmTAyjbbFE5rk1ga1ckyXMFmpoCrdbSWllgVZQzNKzKWubBnFntN63
 EkPPX78lf3CPTUk6zEfz6EE05VDpBw4yexx5JFXecEbnoc5UtuXAF1IsoM1EKjaB/kY
X-Received: by 2002:a05:6000:2403:b0:47f:959f:f69c with SMTP id
 ffacd0b85a97d-47fb1ecafa4mr2916951f8f.7.1785251122723; 
 Tue, 28 Jul 2026 08:05:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm58034128f8f.22.2026.07.28.08.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:05:22 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:05:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 7d80f4557b644c45e9d40edeff4c64e1e19ca1d1
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:20 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38498f8f32e64d85717df7691f6cff262d5cfb2b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojN7-0000Wt-24
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1960279807281253530=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1960279807281253530==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eldnz9Ob7Nk="; charset=UTF-8

--eldnz9Ob7Nk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client PROBE_REPL=
Y parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 9:

(4 comments)

File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745/comment/4f18c478_99a430d6?usp=3Demail :
PS8, Line 1=
91:         }
> In the happy case we do not check that the length is valid =
and inside the buffer
Agreed


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
45/comment/b29199f5_f8ba17ab?usp=3Demail :
PS8, Line 196:         }
> for t=
he other case we check this=2E
Acknowledged


http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1745/comment/e97eca80_b488fab9?usp=3Demail :
PS8, Line 198:   =
  return false;
> Can we have nicer formatting of methods? I find this styl=
e of everything squished together not great [=E2=80=A6]
Acknowledged


http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/360ffd19_947eda0f?usp=3D=
email :
PS8, Line 207:            && oob_probe_parameter_read(payload, para=
m, value_len);
> I am just at this and I wonder if we can improve the code=
=2E [=E2=80=A6]
Changed the API to return the value as a buffer instead of =
a length=2E One
buf_read_alloc() now validates the header's length for both=
 the matching and the
skipped TLVs, and the value_len parameter is dropped=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f=
5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 9
Ge=
rrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 28 Jul 2026 15=
:05:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply=
-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--eldnz9Ob7Nk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1745/comment/4f18c478_99a430d6?usp=3Demail">Patch Set #8, Line 191:</a>=
 <code style=3D"font-family:monospace,monospace">        }</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">In the happy case we do not check that the length is valid and inside=
 the buffer</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Agreed</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1745/comment/b29199f5_f8ba17ab?usp=3Demail">Patch=
 Set #8, Line 196:</a> <code style=3D"font-family:monospace,monospace">    =
    }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">for the other case we check this=2E</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1745/comment/e97eca80_b488fab9?usp=3Demail">Patch Set #8, Line 198=
:</a> <code style=3D"font-family:monospace,monospace">    return false;</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Can we have nicer formatting of methods? I find this sty=
le of everything squished together not great [=E2=80=A6]</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
cknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1745/comment/360ffd19_947eda0f?usp=3Demail">Patch Set #8, Line 207:</a> =
<code style=3D"font-family:monospace,monospace">           &amp;&amp; oob_p=
robe_parameter_read(payload, param, value_len);</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I am =
just at this and I wonder if we can improve the code=2E [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Changed the API to return the value as a buffer instead of a leng=
th=2E One<br>buf_read_alloc() now validates the header&#39;s length for bot=
h the matching and the<br>skipped TLVs, and the value_len parameter is drop=
ped=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c=
48f48f63e05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:20 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--eldnz9Ob7Nk=--


--===============1960279807281253530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1960279807281253530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1960279807281253530==--

