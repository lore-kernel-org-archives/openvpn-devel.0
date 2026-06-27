Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24397C43458
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20ZvSEXjG5eB5CfEv2fQAe4WdfxDvbERKAYuiqYUt0A=; b=M4T7noDWVEWH51sZUcqE4xo8wx
	CQ1rzGKNy+bSFqxztPlckmfaxxd5ieQK3lxfarS0SvGObn8N9nCXG1qjAw7R7KF1Ih6tLcN8iPLkT
	uc8AC0Vj5+NAa9t9Hd4Y0HJK57bjjNYhjlnaUKTrDSDzxEGd6PzasiaQ7cXdhYgn6fm8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdPwp-0001Bc-HK;
	Sat, 27 Jun 2026 10:07:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdPwo-0001BW-M5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RDA3MRFVlfCwetyNHyFAjqiiUMXipbZfKzpCTHAwUb4=; b=Xu4IlQdYQKbLXY0ydS1nCF9br8
 uKhT2T1hV3bIKDc7JScEU9FQrUyc/C8ZPke4flNQ02eoEfgxRz6sez3iz9X03erQsJAEj0KGrRhR2
 L6BLzWXS8pFbrkKgdl1QrDq+ZPCCyfgZcMemaqWPETnbjK2ElLEZMbHdsYrrGm4igCzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RDA3MRFVlfCwetyNHyFAjqiiUMXipbZfKzpCTHAwUb4=; b=k
 QAC1DGjjBuQj2T9Kdq0EglIc0X5rTc465BcfkCL3ufgN4tIwYfaRgksMGuwBADVNNrdHiVFtPRXo/
 uPZrx5530kXkh8RMNT4crfiWWe+okq/TC98Irozak6Od5+fwoVdQzQNpJFxH35w4GumZ1SpEcuERq
 J98aGrWk7qAHEEQ4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdPwm-0003rb-2o for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:07:38 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493a432c84eso73245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782554850; x=1783159650; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDA3MRFVlfCwetyNHyFAjqiiUMXipbZfKzpCTHAwUb4=;
 b=Y2YBcfaQR30evFpgqwwJX0iFOLS1IYScmq+p2aZWkmzb1R8Fy6rWcK7/0ZR3Q3+nLu
 1yV3WNcjyM6yhVB5kSvPDPWd1OQkLSDJbIMMUr2bB5pQ+18Gca75YPvdBU2XDuEvyqV9
 k0Xlk6BNNytzJrf/94pqxZ7Qe1WGCN0ZZ49T+E/uqEwakGdt11eygCoBc3To2w8Kx8M2
 CgL9AxVJLfmMowyW+6Xo3CJccBooXPkP8F+x7zYY0UrN91itfMCZS4CtcR4FH3HqmVXk
 C1AzNnPHGhz3waDYPHgf+jtP6o3Li45wSXu3PaieVdAzaqLt679HidY5AJjuaskdSAb3
 UeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782554850; x=1783159650;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDA3MRFVlfCwetyNHyFAjqiiUMXipbZfKzpCTHAwUb4=;
 b=CTC8pEakF7D/4F5TPmlpYwcgEoTaJQ2QS/2L6gE7FjTKkW+hDjsOQWPg8zQPxrqMtt
 b5gvdTekO0VR3mhT+97CpG2ZxGh6vK9NEim0nwXUcNvbyopxcQdYfpBuOFMua+AI1mcw
 4r5JUhFJHqJaJqkX7oyUwFHDjV+TZDf2iY5Acbmm4/O8HzzKr46uQK/x4R0aDsrrymEc
 rfzx8F9R8DEnmjBxc12Px9Zp9W4qf1GWZp2u43qE4anSlQyO3yHOdardHI5E6OsXiiur
 vCSFriG4vKoekvMxqcMKz2u68LZ8EqAlAmeNwm8WcflHH4xneuQD5vULYSf5VPo7R9A+
 DD7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ86XXTBcqARO5DX41033+iTiizrRhmitztZt+zi7wWjAUaNtbSh0Qrup6whhlPQFtchuTAb1HGm2CB6qfSE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyi2Fs/1UuRrTkiABurKrThjqz0b/3vEaFk7oD35K40NIlqu0bs
 TLXjbBVIxQ3XgQSrlrwNScCtzsBiQMnrb95qHZZyNYG9JQ9wyElygYDlYALemfrDvzd2ZY59nym
 FivQnNaSCCvCgNk+SeogP6SRAfJW3pqWYPDLR8FCbAUyqMOZ+K8CIAyM1WXioEVOuwhN9
X-Gm-Gg: AfdE7clYAO0/3WIv2/UDCx6eMd0vKsGuSF/ZBxGBkF0V29sIFBU+3OBTAf5kfkhS+GR
 JiBCMhVBgWkc2YajvPsS1Nb396Jq9El7flWmPwRwB6CV5SV4+m4CqSA9CVYnvEwZZTYXm6H+mA0
 i04Z8Jf4PrCqn6vUV3I+n+CxNJ3A4/VeAL62dr2gxbc0NR1genOUtom2LXpJyD2EmQQTasTrEpq
 aXgsQ6U/GfYKFvfguB+ZdTmWp30e8qvPGDa1bAn62AnEOccAFqDKdeurxkqeD8XfrlGLLMIXCyx
 Ql69hepgu2+QquNfnUVLKxPannHnVSUdzgJO/j+oBpegCYMBpXkVhDt+u/Eh8RSUgt8Kt/fipva
 B+LUjzU54iOOMDOgG7wbnuUAwBvwsKMDxXXce8MNKGwi9cmyb67hUFZW4XXLf35/aRn6IyqUcBd
 3Qo1mWbLUqLXCcP8Ul9Db07Nn9TAhZ/lThsb0Phd3BHMfSD/EtC5MT7pajtgsu2FlqhxqwqJD7y
 ORKE4qZrxGVgjpYFSOxvWFHRsADtjKt81tOQc6BC9g3Oc8DNVtETIRhkZmuC2ys9N4OydLW9YPD
 n8Y=
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-49266899f6dmr114163695e9.17.1782554849929; 
 Sat, 27 Jun 2026 03:07:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c286442sm67479055e9.1.2026.06.27.03.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 03:07:29 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 10:07:26 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: c1033d72f7c595c4a5a59f026441edef43024197
X-Gerrit-Comment-Date: Sat, 27 Jun 2026 10:07:26 +0000
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0650dd90032d0623d5cad75be4076f7892280874-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdPwm-0003rb-2o
Subject: [Openvpn-devel] [L] Change in openvpn[master]: openvpnserv: rework
 ConvertItfDnsDomains and tests
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3237913248786596039=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3237913248786596039==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RLQQ7z0MsD8="; charset=UTF-8

--RLQQ7z0MsD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

stipa has posted=
 comments on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1730?usp=3Demail )

Change subject: openvpnserv: rework ConvertItfDns=
Domains and tests
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 5: Code-Review+2

(2 comments)

Patchset:

PS5: 
LGTM excep=
t unneeded (anymore) malloc=2Eh, maybe Gert could remove it on commit?


Fi=
le src/openvpnserv/interactive=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1730/comment/b0f3ec4d_3289bc90?usp=3Demail :
PS5, Line 36: #include <ma=
lloc=2Eh>
I don't think this is needed, since malloc is in stdlib=2Eh=2E Ap=
parently it was been added for _malloca/_freea which we don't use anymore=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8c67633ed3d82a=
6dc50fbd8fa1af2c50fc45d938
Gerrit-Change-Number: 1730
Gerrit-PatchSet: 5
Ge=
rrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: d12fk <heiko@op=
envpn=2Enet>
Gerrit-Comment-Date: Sat, 27 Jun 2026 10:07:26 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: Yes

--RLQQ7z0MsD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>Patch set 5:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">LGTM except unneeded (anymor=
e) malloc=2Eh, maybe Gert could remove it on commit?</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1730/comment/b0f3ec4d_3289bc90?usp=3Demail">Pa=
tch Set #5, Line 36:</a> <code style=3D"font-family:monospace,monospace">#i=
nclude &lt;malloc=2Eh&gt;</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I don&#39;t think this is needed, sinc=
e malloc is in stdlib=2Eh=2E Apparently it was been added for _malloca/_fre=
ea which we don&#39;t use anymore=2E</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail">c=
hange 1730</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1730 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt=
;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sat, 27 Jun 2026 10:07:26 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--RLQQ7z0MsD8=--


--===============3237913248786596039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3237913248786596039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3237913248786596039==--

