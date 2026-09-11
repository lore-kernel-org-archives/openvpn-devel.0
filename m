Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2509EC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0GhWKp/+pEK45+QOZieb5VlVFNfGDSU+omth6Yg7S0=; b=VvhCUX5pdA6MxFGtoshZ5mX4uJ
	98EHRXPcpwrIYAwm8cqqpQ4Rib4Y91+PAb9l+Np3QzTlFYL+hTLfLDjxyUwIIg5v4Bf/12UoJDhAj
	Z2CUZ1pzbhc2pZTlVuRVAhjMB4A3fka3I7x2AkF+G08iLhfLlJqFlTp39b/bLVaHIWI8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51Qr-0005uO-Lk;
	Fri, 11 Sep 2026 13:36:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51Qq-0005uI-GW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EmTkH7vrzaWZJOWFIGXHAdaOh3MxcQ5pOUqTFEKxu3U=; b=jsnhaNBul5mcbQnrCVn9hz5Wct
 xZKanj9lAjwBKLPvRynnBHLU6nHYkxZk5GjXE7A5GpcakSVVY3zWCURzLZyO5PlachoU+8ThKOlcf
 vwvYtx7plgYPvx2HtqiRheGDB4/qM4CDxnRy5+xC6ozyFrGZWOAMW7HeafwzK3StQ5OI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EmTkH7vrzaWZJOWFIGXHAdaOh3MxcQ5pOUqTFEKxu3U=; b=U
 63ThSPY7xQfJNjOt4n8tWuuoGemnUVmNJbRgk+uPiSzcACAeByWuSYZ/6zhFf77adUQsG9PM20tZu
 bj2B3TPweoiWmHkfglo/91rGZAfLQW5hztiyLbsGt++nl+IINOk8LxiKMV30K6putIFydtq4vkpDx
 fOKKZYEwXURc0Xdg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51Qp-0005rb-PU for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:36:45 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so7206925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789133797; x=1789738597; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EmTkH7vrzaWZJOWFIGXHAdaOh3MxcQ5pOUqTFEKxu3U=;
 b=T4sgPW32l4K9OzRrJh7T9O62ySBVellu8Oh+BtenlklJtbT3rmLgxdjUKq9AqOul88
 xAvxfHOhqtwM+oITDHiUy1l4l7nLuzyhDQTApI0r3A5NFPzi8EFw2vCUSk8IBdw+CsRG
 rtv8A+o18kg54Zf9sVJV++6cGiBxMZnGY3R/ftavocwIfzUQqIrFBHPXrNx79vxjdaQW
 AeEI4TtE86CyblUYk7nOatQW+WdUcvQz2pNlQEEk6Klgyiejqtuhi6yU7YcORwo5CVgg
 XJW/I74YWRCrJ7hyYoUTprMYkgRTM6ImzF/AXZngqAsxGveOENjTsc5cQ1B6W/EOjBzz
 WHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133797; x=1789738597;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EmTkH7vrzaWZJOWFIGXHAdaOh3MxcQ5pOUqTFEKxu3U=;
 b=qwfSWm1WE7j5fMCCiuBLmYBNCXp7VUZTr7A02XwV00KJj3d/4XjiHIylOiCMqn/QIS
 Eq28freX9MmYlkd316MaJ7ySXcCZn+7Ep/XkJdrmYaPO/bx13BBNCBQzQGfn81pQcFUR
 oFO1DEVDfdGgNCMmrlzqoUqdUqfL/dS/9Rm8OwyYE7X39/1bbJtzFAVEmp8tcDBwARt5
 IgvHPnzNy7nO0ubZZbztPf0u7HdUjW4A3OzoXIiVBqXXq0WfrWLo/4kW+WLGEU60FbV6
 kkcv8RS5DsQJCJrhg2ulUEWy9YyPMjuepCi9tLtr12EEgnSoslbbTNpDPkvQYbmmRuZo
 aTBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ3EvPxKqGFZK6Sdi8YP2iEWTrEJUwuFGzpIcQlcMP6birjXl9O2EILX1t9Py5bZIlCGiehfEUMSuL2DaW@lists.sourceforge.net
X-Gm-Message-State: AFuF++noCAs0A7fWCSxN7sFxZkqVjiokyi9ZsexMMwpGWUL+c1wx4sPW
 bqWObLjNqtGqBjuO1ErTXA21JNdWotP9SlUmTSVyAP93MUE8Fw/pzD0Bo17jT1xqBll7CsRDk1u
 CmPnJDh7yz72k680+11tR5/N7TC/GPBl5l/w+nWNObSIBkm3kLv1jO9XtmiLCQaiwQtSk
X-Gm-Gg: AYBFou3DUzyc1ju+dMM8wTAOuM7V+HUcW6jOwN+NSOtLECwzZ1pBl5l9Bp/nnJ6e6gA
 V2TP2URTJ7bcx5M4wbBPuuBLQ4YAh2DLyO2G/No4qXdlGzfvd4EyEYVg/uijpqn3PyLdG9YuceZ
 NSpJQ9hLwrXX3v8sgu8jzWbt2NslAdsjHawRS1ZL3XxU8Mkey5sumcWCDNuKlLXXuteI+5wzU+M
 rQpoJANuy1nBsaGkQj1aFuuLxuQjemkCmzUhMQIikix8cPzl3AxapMlgZNcrkqtK1lBDs7kngAk
 MqznNunflOqVm8MAtDDdsQFQ/IDHR6doomzXK/BXUBsMmK5AfVK9Tg2wWxXNd7xrX7pJEjmxMAj
 /Awanh5x7G8CSNT2tQ/QMnPUwL4tIzOKupN6+D3P3K6hzjCHn+JjRwzvvzRQwTC5vwFbegsuYeQ
 UwuyK/G+0hDElogaVuToNwz7vWifIvoYT08Z+kF2PMmPTj36xSvy/idozzl5wSEh5mLtGF1vCvB
 wGjXcBex0w0MfJejbI4/6pffokv/2MuASRVcdF4TNoLxqh8XBLH+LJhxMgsLO3ro5Ppb+WnoJIh
 FZPvCTjA145a480dJ4x+W4X0yrkFlHhVfnXrR5McWvvIuNfBjYZxVUhuEaOnwQ==
X-Received: by 2002:a05:600c:3588:b0:49c:fc6c:be1a with SMTP id
 5b1f17b1804b1-49e619d530emr54013805e9.32.1789133796926; 
 Fri, 11 Sep 2026 06:36:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm41741125e9.2.2026.09.11.06.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:36:36 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:36:32 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 1cefec1929e5c95c671eb307517840e3c481b8cd
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:36:32 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4cc153f1183a366e9a2d3e6d62bfd075da1b145-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51Qp-0005rb-PU
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8896793278056891195=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8896793278056891195==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F7rF5wKFd60="; charset=UTF-8

--F7rF5wKFd60=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 23:

(1 comment)

File dev-tools=
/cppcheck-suppression:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comm=
ent/b2a212e9_d5110b73?usp=3Demail :
PS23, Line 74: # FP: const silently rem=
oved due to pointer arithmentic
Typo: "arithmetic"=2E



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f5=
8
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 23
Gerrit-Owner: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2026 13:36:32 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--F7rF5wKFd60=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File dev-tools/cppcheck-suppression:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663/comment/b2a212e9_d5110b73?usp=3Demail">Patch Set #23, Li=
ne 74:</a> <code style=3D"font-family:monospace,monospace"># FP: const sile=
ntly removed due to pointer arithmentic</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;arithmetic&q=
uot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da77077=
4b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 23 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 13:36:32 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--F7rF5wKFd60=--


--===============8896793278056891195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8896793278056891195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8896793278056891195==--

