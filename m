Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5D7C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bVdDFD3JTjG/bpp6wGsjAiLOh3c8WYVY47rbAGMWtU=; b=YSnAFW2XlYP1mM48ZmlY8KIYOO
	4u082DifWFMS4dkx9uYd0svCwU1SCOePoBfVKL47vOq7guevQzHNGRkcWnCUEhzKkFE+pIiN140n5
	wtArIS9ougf0qEdlqtwedvDfaF7f1WUkVnMSMO2Rf0N0+m6gvV4PZoXLyxKuk+iP8X0g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnHaO-0005eF-W4;
	Fri, 24 Jul 2026 15:13:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnHaM-0005e9-Bg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1iZVg6sCK3glL0tmWSQrJrizNtGnaCqwjhZy/MUbPZU=; b=MFxKbERvU1PojILNlPmMKl7r8p
 Hi69lbGZmOm7zRfw1Vjr/T68RPPLhhlL1SeOBlmsIe7KSF9rxhmYfX7G/LxIuGWAV4LBTGiONLWNE
 k8kj78RdO1FwOB6B+poE8ONk08v+aUefyLTuirr7Ls+Vbm0N5fJBcJoG30n2DE3XApIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1iZVg6sCK3glL0tmWSQrJrizNtGnaCqwjhZy/MUbPZU=; b=f
 nDjjTXNIju282Lcd2mvgxucRF48fVZESSERybyJVAMX3krNWoIGJGArtle715pH+hCCsXkZzaKkiq
 SLt5nmbFfJumEfl3TCZDuKKwf9cSddXxOmay9+4JfblvjOVXalcS7M5zB42M/mPaIrH4TOZ98Nhhg
 O6yis4pm925bJQ94=;
Received: from mail-lf1-f53.google.com ([209.85.167.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHaK-0006oY-Ao for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:13:15 +0000
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b0f19bea2fso592369e87.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784905985; x=1785510785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1iZVg6sCK3glL0tmWSQrJrizNtGnaCqwjhZy/MUbPZU=;
 b=YI+K3m/VYJSc6pnXaE6UUKH4iCOPfahEuLSeBFcP/X4T3ex0N4OV7FtQd8VgIQHY/1
 GLNethFSFnyqsMs2ZK7TmUpe1ZftLzM6alZnLV9ODlMnFN+5dyLbJ+AmNjYFX5kcVp5q
 CQTOYeS43dGx8+bB+oPaCUR6zDs4zkKKbZ9apdypgvCyYHgB4POK5cfBxM45i+RgY4+6
 5f2YLQ8msh2ZLtAnYTbBiwuWXmQhDrtFWVpC0XKO+o28tEwXuFiLo/wTUr91Ued+hgvf
 TZUL3Y35BbxmuiUMWg31NPfFyS0tiBAgeF61IpFzM41/q0mOyLV8kwJRYU6wuLMjlANK
 yUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784905985; x=1785510785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1iZVg6sCK3glL0tmWSQrJrizNtGnaCqwjhZy/MUbPZU=;
 b=KDltfHwtMPMkSLd7GRn/xXYnnfLRp4lipWVI5Ctt604NjwIOzhlrJPzoVCwRf6SSVX
 wKoBsgj+/ok7CQyOH9QFEnBBzPpuGUKMhS2ggOEJepBc0LuNsZMzNZMNGEAq0WzAPWPI
 A+bWWV/+WsQ4ZvnacscSFoENs3MJSgeaQwZrq8KwFUqwGXTpZo0fsbGMSe4lo7Ve3cQT
 HekErpVdczv18wGFKn7ACBUeNMCYW5SRyM8GABNwj/qqGkXIhh1E2RN7CRd1yL8KVe3s
 83bInsRQZrpf7BnDqALtKOgRvz6s9mORa31nkfyfJ9i45SXIc7c9feYMGkPHXSroSIve
 cmhQ==
X-Gm-Message-State: AOJu0YxZKpvf2/tRMZl7MSSSeIjW+I+mWNPgXl+JEMrvp/rMZEJYAu8G
 cNmjfdyArXgXsfRnKwA4jq+ed9S5LtOjO7Xfy8vIwFy6Tg6Nyz0LLk4DTGex4b6QXnAyYzI88+N
 VbSfMf93iErVWH4cIKh8qf9yoZ56NSX4cU0Rf+9V69f/8H1Ig8AQNxv8o6H70fLi5H4hD12Lbh9
 ojpi4WMQ==
X-Gm-Gg: AR+sD10lgqN570TP7T8m+nG5OIAlG/1I/QAmbD9WibU/TcC6L28wBnXCdGnKoz4LURZ
 oOykHoxPztmLZp9AmJ4X0g0MbXCH/G4HXwdrRj/xSaMrVRfhuekZ/xZPNjWNKkZwTomHOLyQuZx
 zIXVkAyHo32qgcfwxwpnhRZ4MXDbDM+7vDwAvq2Oa61OZZBWagaayUqa7DKoyX2l6Tt3dd2rG8/
 jpn+VHFNs2CBAvYuSIutmFg+GtdUXd+81dDiKWQ6WPmYEOJ40YobfeSa5BFpBbDP8X4gyBdacil
 BWTt4dOTdJruQPBhpuQgeS0nXEprJPcI45zr4in1ZRGKhACab7kx5Rk3OF+aGfyRswrbqHlg6KJ
 AUTZ/yGt+SycyimYZRORYF/PjFrSYsDpYGVfkbE/rJCodZTTMR/DaS0WRwp+sxuCULDOY9ciOyg
 K/SmU5jNZRPZ/C3WO7RG9fntYJe9guxpkCsSp3HfZNVfAxTnBi6ylI7ECMQ4B9T4sAIXu2WeOpg
 xLMeTku1iIZba2W59blnbsmJjXUeHsdFiJte0SqZYZn8HBckengYIU00ZqdFGdCYXpL
X-Received: by 2002:a05:600c:524e:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-49573c8d44fmr82996825e9.2.1784896915556; 
 Fri, 24 Jul 2026 05:41:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f99fa7asm30682545e9.2.2026.07.24.05.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:41:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 12:41:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 51fcd9bd4059a7059e9852f779acb26aab98836b
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 12:41:53 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dad64fcefae14a0d9fa5afd20e727b35d0c45f5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnHaK-0006oY-Ao
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5732214982635813209=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5732214982635813209==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3NgyvdYm1NI="; charset=UTF-8

--3NgyvdYm1NI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 11: Code-Review-1

(3 comments)

File src/openvpn/siphash=2Eh:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/1c02cc50_f4e264bc?usp=3D=
email :
PS11, Line 112:  * @return a unit64_t containing the result of the =
hashing
"uint64_t"


File src/openvpn/siphash=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1573/comment/d24e6b1f_a187f58e?usp=3Demail :
PS11, Line =
29: #include "config-msvc=2Eh"
config-msvc=2Eh again =F0=9F=98=8A


http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/93231b0b_647ee4f5?usp=3Dema=
il :
PS11, Line 46:     siphash_cryptolib_init(8);
Doesn't that need to che=
ck with `siphash_cryptolib_available`?
Should not hardcode "8"=2E `sizeof(u=
int64_t)` maybe?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8=
07f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-P=
atchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 24 Jul 2026 12:41:53 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--3NgyvdYm1NI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 11:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>3 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
573/comment/1c02cc50_f4e264bc?usp=3Demail">Patch Set #11, Line 112:</a> <co=
de style=3D"font-family:monospace,monospace"> * @return a unit64_t containi=
ng the result of the hashing</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">&quot;uint64_t&quot;</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/siphash=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/d24e6b1f_a187f58e?usp=3Demail">Pa=
tch Set #11, Line 29:</a> <code style=3D"font-family:monospace,monospace">#=
include &quot;config-msvc=2Eh&quot;</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">config-msvc=2Eh again =F0=9F=
=98=8A</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/93231b0b_647ee4f5?usp=3Demail">Patch Set #11, Line 46:</a> <code =
style=3D"font-family:monospace,monospace">    siphash_cryptolib_init(8);</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Doesn&#39;t that need to check with `siphash_cryptolib_available`?=
<br>Should not hardcode &quot;8&quot;=2E `sizeof(uint64_t)` maybe?</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0=
ec9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 12=
:41:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--3NgyvdYm1NI=--


--===============5732214982635813209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5732214982635813209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5732214982635813209==--

