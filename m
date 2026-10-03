Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A95CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7+AEAGiqp+6cxx1ZMbjbTB8JCyWo4LTCh32EI2xxjw=; b=aEhFiu6EW+fDMPGuAXOvnYqWdh
	ZAye0FHVobyMEcTRT3vZEoC1NgEYbZ0Hjxmu4uUOUAtV08lSw/FoviGE7RFuMWhggL9KM3zvNRsMV
	gyMGUF8VJxPf6sV/+ZrSqC969xnKY1sW+reyXZIP/ehTJtdKPyot0Wf4okRiwpx8dhWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3vu-0001D2-8k;
	Sat, 03 Oct 2026 17:54:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD3vs-0001Cl-Th
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q+7jom6eRZFY/eWFxjYKe6jhEi8Sos/ush603cRJepg=; b=RA9iv4E0+GKvBaMHD84qU3QDaw
 cfPcgv2V30Az/OxrDGt0bBRP+U3KVO3CxFBJ78GMBLMvSQpYxEN4YlxkA4agV839jTwAQhFvTXfJm
 XaKxo8dlM0CNYKdYvc+MVBZmGlag7CVbFcfcBw6oztTqulzYvdRM+JHeivqbElyk8zCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q+7jom6eRZFY/eWFxjYKe6jhEi8Sos/ush603cRJepg=; b=m
 +cLnCgCYR4ecRsMi1hzGtPFZZKJz79OTXP8yhGwhCRxy7+7jkEmZwPb9YN59HQVyMGtduxM2USQ0G
 nIf+AN/oqLM/LEEJPupejLlNEQ6viKDZcdo16ynbNGdUm5MvkHaRViaLlIUmakq1AktmW+9FSWg2S
 mBIwREnd8jUnQlvk=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD3vs-00077F-I3 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:54:01 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48aff58e6abso250952f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791050034; x=1791654834; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q+7jom6eRZFY/eWFxjYKe6jhEi8Sos/ush603cRJepg=;
 b=UVokkE/lTwUab4QBe+dDb+EetbLCAvVNwVdLeWw0av4y0wWBntXKh6zLlLf9Jn0YXH
 wPwWIO0E36zHTSO50UMkZeNTvjYnxvFUHxUQHD7aKUxEJGG9jkXcQGKqoZl1KiMIyGPR
 l/bvsSHHtxHbj4PlO/VQWgpFGeEL3lUQlAD2RrR+EGiIhcP8jEKz5HBJmQqDdXkGpUIR
 niaqEtqzjQ/wEm7MEyur6neM4pAV0uwqrQK3Q3bWOACbUHgtIV5/3czdxW7V0kVBlCTv
 iG5AIJGVr0gF5MxfAV2KNvt4qACpY9HibVeyXzvt5fzU1fSFaBxZoPJ2NTFm3usaBr8R
 F2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791050034; x=1791654834;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q+7jom6eRZFY/eWFxjYKe6jhEi8Sos/ush603cRJepg=;
 b=2p2p9SrFSSkI9HyqOso8e/04w8c6bzYqD0pgSNndn1hKS1zmEBqjGFcC/di9b6MUgo
 9SHBhYcaHSTYUqALuOMadXRLM2yKttBFum/z4IxWZ4AEFWbU8BWIX5VH3zIAOFXYZKPb
 4GNIagjkc+XO5Cqn5JZIKh8l//jtfDBf7ed8n5urf1Gzk71RgRM7aTiCHFlvN1GXZef+
 ShYPR3GJmqnW2hZ8KAO35tvOruswm6fVvZaeKQ3A9umflMiRp3cSgR2wIBDEP/ECD8vp
 muGE2Cfo2KOqfG560OCmmoGWV0JDMDr5DiGBZbvrDC7wdXZDMHZCGQzg8XjzWPzxrQxY
 uVdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7wYVgKW4lhiIdOA0LqDl6fNxAwSXf2WCvhSQvUQL/u5TkrS60fz8g8A2/0e+9PuZvTvmmQ+JZ7Zn0qx2O@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIaXiuV7Beh9vrEXHpkrBU6ykICvOtPAnpDEiXsj4SwV9TZq7Sj
 jmU/ExABcFaJ+rT4+tf9lKqfLPoyMdvu7XDZu2uSeI3Ek35XWVbIEyJ31JISZsRCHlRlK7BNu/v
 IDhv67uXGPoJSC+SkIHUaz8sMkYQ6BUlfceZSBdpIX0q0gimcj2/obC7AKaae3WumPLhP
X-Gm-Gg: AYBFou0QK85Y1TYlJNDZrNlITVmU88tovS68kVXJcmTGqVQAA40N1X91cAtNdFz2RsI
 VkIi77ni0ZlXx/byVmVZY5kf674Tp0Zy3qkHQoj6e/8Mr0yDTbEwdTscSN5QfuKD1vsd3Wn78G7
 xKD9snKclBP6NIvUiPJnXPMpFMSmM8BhkO5NewYaXlPXz+oL2+QsK+n6Zyx8+MHoUFVMzIH+vB+
 e8v3ZLLTINcRMzNrcDGm9qxLm+Hpug54HJmyosGqjMjWLAw9d7y+vckiffelVO4loY+xxYzcZba
 TMqxEk7Y6Uy26YyYuznmfeai8V4jypbdandTRpz/b5lA27dxCxRuRzjzXuNZcaoDHi0aNyLNsrw
 Y7nW799zCmk0lIHp9onlGIT/ht1jF3NzhPeCnNTOZ84NAlO9sSMxn/ThAL6rJIRYWgXWKLtPkRQ
 GsezPMgCBBii3xG8iLdnhsFDS/pZmIHIZSy1lrBDn9unzpMrc9cw6e4DyGwrNUGWWvIAP4XHwPC
 xw75p0BxOFyIbtwaQ56lkrufp1o9I2W7u9Fo9vrZfCxrS6LMyukSGJr20oM/0n+0JGCCj3pzsIg
 gHs5hoLGA460/tiVq207bfbBY4w6ecG5Hp6CfszDaPqHfoCTzyb6534AFe0o
X-Received: by 2002:a5d:5f06:0:b0:48a:f076:28e9 with SMTP id
 ffacd0b85a97d-48b1273e7f4mr10727108f8f.36.1791050033780; 
 Sat, 03 Oct 2026 10:53:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f07cdsm13142363f8f.10.2026.10.03.10.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 10:53:53 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 17:53:51 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
X-Gerrit-Change-Number: 1966
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1966?usp=email>
X-Gerrit-Commit: 3f42df7820f5da15192a73daa5d767531a590e34
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 17:53:51 +0000
In-Reply-To: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzc0NTIzMDAwLkk3NmMzMTBmOWU2OTI3NmQ0ZjIxYTRhZDMxYTI0NDkwNTUzZDZkNWM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db62695dd0a5cb4915c6f64037677ceb94a37a05-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD3vs-00077F-I3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Review
 suppressions for constParameter and constParameterCa...
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1677646724295274765=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1677646724295274765==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5TU+NvLg+xg="; charset=UTF-8

--5TU+NvLg+xg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

Gert=
 Doering has posted comments on this change by Frank Lichtenheld=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail )

Change subject: c=
ppcheck: Review suppressions for constParameter and constParameterCallback
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1966?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76=
c310f9e69276d4f21a4ad31a24490553d6d5c4
Gerrit-Change-Number: 1966
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Sat, 03 Oct 2026 17:53:51 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--5TU+NvLg+xg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>Gert Doering =
has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch set =
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">c=
hange 1966</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1966 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Sat, 03 Oct 2026 17:53:51 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--5TU+NvLg+xg=--


--===============1677646724295274765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1677646724295274765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1677646724295274765==--

