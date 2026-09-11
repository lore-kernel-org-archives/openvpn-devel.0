Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AE7C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8tlFB6cC2aANkDogVKPyBD4tWLeDnRjoZsSDo+M0xs=; b=LGC7yk8v6aV7aKq6EnToFTNs8K
	OsV57S7jUgH+lGlOYc9sQIg+xuymXupu9sHO/gF3Dpy9yBzDs0DpIs8EG2ZKJvmLbZQM58kg2Tmwe
	GPc+nxdB2xcIb/hi5FIs+Hr2qfvAC19hEDdcMjEbyVUS6PcRqbl0sqcB7kOknpu3pGPs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52t4-00066w-Pf;
	Fri, 11 Sep 2026 15:09:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52t3-00066o-9y
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MxUy6R1AwsmvSYEZr9ak+XXgIHRVUK240WS+aPRZkOk=; b=hsCCT0BcHv8hZT/ce/iqIg8WmE
 9CWFMbd8hkOtLTqErMjNWV/BIRaFllCeTDaFV/7KzGzOQ9jnhwBmlQpNuUHoriQuFADcVDfUmJDcf
 QlPdo392AtnlnI+nM5yJbRYiHF6l4qcUw4d/h+BQg5JU7rzjpJfI7qWzVGAKxNzuJXI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MxUy6R1AwsmvSYEZr9ak+XXgIHRVUK240WS+aPRZkOk=; b=D
 KRbig7jmvnnhNt1G3YB7QKUU1A1ilhplnL/ezoudzCahKsCqDzRqrW44BvWD9rHE7UZA256Skdn7l
 AJAeB4SZnIcYu/MHwodpAVV7OF2dcPNq7+GosOX64tAXo2NjECweUh40D18wSM2CP9pSe8aMpf6Na
 RAsVAAWMfZOc4eS4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52t2-0000iL-MS for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:57 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e65b1cc29so16645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789139390; x=1789744190; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MxUy6R1AwsmvSYEZr9ak+XXgIHRVUK240WS+aPRZkOk=;
 b=N5cZ1MAqsw5y4m4gZEyZs1dFoWlegFpGdxJUC692mQug/vn4XR6wx2XNcUVdSznKxd
 kFZzXdXi7Tl1iM8P9W1/v5zF//V6o56DwmJU3m4icbAyrx9IuEfpRii8LMkCZ8OC4dK9
 kzJw+4iIgOcnnu4ps8+jyBFmXxccvqvXBgg6mdu68/AgKOGM1CVKkDwJfTjl7gYtImGm
 wsowdEqPosjyXO8cCzp22FnuJGJX2UpX9UvMw2RQ5WcU9QRRfeeeURMTRX/vVjFGCjBV
 rtbfWzZfbSSCEkGHuf9UgCF03ENbuqDVYLZOfNVgruqeIEE2LuWU+RO/hHrHlYd8PdxA
 00nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139390; x=1789744190;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MxUy6R1AwsmvSYEZr9ak+XXgIHRVUK240WS+aPRZkOk=;
 b=BAiGyhgx8G7sKKO4rpzLz37JdaDauKEEX2Nx0iLqGi0gTz3k88WYvv/jZXVWQBCCcS
 Amcw5yal0mVT7ZglfQ7JZbaAt8l97pIOZk4trbwlxdC22l+YIiXEWVMuntR64zQiY1tO
 aM9zP7wBi0fBOLtXhWEKveEdMNCHwnyEaaewrbefzmK1zIwxOQWzewCs8QurPRc9cclX
 YIZ6ShUlY4vuyRyGQEV7i9XC5ZSXcvZ96Bb9cBYBih9jT5EeQ6HzKGCh0bITrIWyCplK
 F4GI+ipNjjQrFMprdxFEwNTOK2cu2x4j4qwHZRQwUv9f6l3c3yigDkEh9D3oOcM/9Mgk
 HI0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUVWn+v//TW9tOL4AGbUyijltnGMq64rrrOpERfMFBhetUobieXC+BbmyaVLCk+BYIk/zrfkbtY8gu7VrT@lists.sourceforge.net
X-Gm-Message-State: AFuF++mcpHTUXcJY708JSVCbisIrA/IPTCM7632bRPo3lDGuXWgO6I02
 6WkFvxEkNNGivymO2e/zcLUz+shxLpnPT7Xe55nchttTKPZpZhBrK7iopwbkNhb3zpai86FJVwW
 T+tqLdhtoy4BnKkQAyTzVXw/r/AkPL3TCNEFqiSxR9EFHtnjFaK7DL/0Nu5h360EPrTHF
X-Gm-Gg: AYBFou2jNIFp3wKkBGzTV9Pzum0RsbH/YK+z2Rvdt5FoQjtyVkPCxDNI6QX6/10e2xz
 bA1ujGEPyqYAVTx5r2VE2op68U7y5BRNglJXjPyLN0fa1ShL49ds1x5v/zzM7fDV7+4GAvxEXT4
 BJ0Py49g6hVLF9FnG0T2HC9Qpdkj/1HGxeshtX3TeYhK26AYfkdiATAPWKy+eIDxTn/drkCq5oU
 JZ6t+M6Gb96C/klZa8IuxsR3Goq1PeIzSe6dVxo4GeGBpAHZ7MEZWYUV/KFrco/XSLtW97Da1mp
 aYRXiiaJ4YyragrjoNLqzUTn/509qQezlrIVjzWzxobaSZ1FzMZ0EZGT2Sb+tYVztXYGh0uMMAK
 kBg0yABwHrRfqQROEp87cbgLw8R3GuDqhceB0DCoXPLKoBtcPFv5W1DcsPssvkUuQ8hs5AKTqpU
 qZnuvbE2x9BuRbOa+aZFAOWQEN7x0NHw0EL69mk/awmX3dEXxpovTCrvRf6HjZ1jnFxqN4mgO3I
 gwUjORFXWabSPVaZzsgKakzy6bNuzmUc/m/RiS79FlVA97258dmbjg4QU0iloM+aGeXXcwIlP+O
 BAgwP9WK4rwqCpgegFJvj2vwWH/IcVqeRC8BEZe8Gg6pNUrH3mr6qkjXb00KvA==
X-Received: by 2002:a05:600c:3b11:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49e61645c2fmr90263875e9.0.1789139389930; 
 Fri, 11 Sep 2026 08:09:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm77427455e9.3.2026.09.11.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:09:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:09:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: b32e3b58e898f1e19c1c5d49019db566c749b810
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:48 +0000
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e8ca0a76720786f690303af8aa607caf73402ec-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52t2-0000iL-MS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various function
 parameters shadowing other symbols
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2919569900809667025=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2919569900809667025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZT/nnthUEvU="; charset=UTF-8

--ZT/nnthUEvU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1912?usp=3Demail )

Change subject: Fix various funct=
ion parameters shadowing other symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

Commit Message:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/comment/d0be69b2_0437cfdf?usp=
=3Demail :
PS2, Line 14: either renaming the global variables, the function=
 parameters=2E
> Missing "or"?
Done


http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1912/comment/e8753274_361af211?usp=3Demail :
PS2, Line 16: In one case=
 I removed the parameter since it only cointained
> Typo: "contained"=2E
Do=
ne


File src/openvpn/manage=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1912/comment/aafa5bd1_3b753e57?usp=3Demail :
PS2, Line 3113:     man_outp=
ut_env(es, true, management->connection=2Eenv_filter_level, "CLIENT");
> Sh=
ouldn't this be man->connection=2E=2E=2E [=E2=80=A6]
Done



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b56=
1ffdf
Gerrit-Change-Number: 1912
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eor=
g>
Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:48 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2E=
org>

--ZT/nnthUEvU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/commen=
t/d0be69b2_0437cfdf?usp=3Demail">Patch Set #2, Line 14:</a> <code style=3D"=
font-family:monospace,monospace">either renaming the global variables, the =
function parameters=2E</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Missing &quot;or&quot;?</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1912/comment/e8753274_361af211?usp=3Demail">Patch Set #2, Line 16:</a=
> <code style=3D"font-family:monospace,monospace">In one case I removed the=
 parameter since it only cointained</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;conta=
ined&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1912/comment/aafa5bd1_3b753e57?usp=3Demail">Patch Set #2, Line 3113:</a>=
 <code style=3D"font-family:monospace,monospace">    man_output_env(es, tru=
e, management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Shouldn&#39;t this be man-&gt;connection=2E=2E=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">change 1912=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ac9=
34da5eeed0424b54ed9b528a2bf2b561ffdf </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1912 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:48 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--ZT/nnthUEvU=--


--===============2919569900809667025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2919569900809667025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2919569900809667025==--

