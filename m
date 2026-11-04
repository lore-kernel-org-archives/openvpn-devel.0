Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70B606D820
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LVIZGh+C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fZ6fAG+L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SXQBA9AG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P2DgZijc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HzqBg26QGAmwenUrISRp0zCSQD23u27CNxTwFcovRLI=; b=LVIZGh+CPEJ9s77Xw14fC3jQuC
	X6hOKL1KKxveuNOSIw3ptmYMHdwwAB341FNqNVyDcPBrGu4C3aV2vUWBZVYYUWU1Lwzjifo3Iix24
	8DJgzmBvtcy3Wpp4LUbw9j1UPx+wzOpjPvwxxFmojZvZfGrGYhOmzok4ngtNI+EqCoao=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcif-000000004ps-03Ny;
	Wed, 04 Nov 2026 15:16:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcid-000000004pi-23Fn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f8UgP/8uY2zvz1Mgk46mnFCdyCx7fsWjNi/QgmRp59s=; b=fZ6fAG+L3ON0V4VxaGnleJSF7r
 trMGQ+Nt4GBQS2eczyt/FKwp91bN0MBiQ5zH0IeeXkPetrB6XyeuDfFWHeacGitIPWkhZJLyabL+j
 NOlbmYEoGmJqRNV5D/DOWJZyJgJRvmEDMHiJNQInPKRlMd2TnGneUEYVrHzEupFLsXDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f8UgP/8uY2zvz1Mgk46mnFCdyCx7fsWjNi/QgmRp59s=; b=SXQBA9AG1qo0GZuvc7am+eiFAV
 fkfmsSeoxwE5xbxIiSNMOhYl5QyOoZbYG0YaFDfokeGT3+2zwHsqc7G+UzBmNNscWkwTsyI+MSuWA
 uzmpV/ishXEnWQLfJUYgmDLYMs+iy5R5JIkDTB50fm5oEuVqRmdLQHGUl8ihVgXLPqEU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcib-000000006sI-2fsc for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:16:07 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso6346505e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793805359; x=1794410159; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f8UgP/8uY2zvz1Mgk46mnFCdyCx7fsWjNi/QgmRp59s=;
 b=P2DgZijcSlxSO6DBfoksCqH6IWbn/Iz9Vbtp4mBQUGoCTUPE+zDP9q/yX+Fr8d5WJm
 1SK4MTNNmDpa4nuxujPBhMMs6jdg1co/mlk1xxFSpEgDLUqvXnZM/De7u+Gf/HW1yy1t
 8yh/MHUOoJEg91prBd8jo9SGGlWsSok6scM8TqLeHJP1FGl7MlCOnt84lw5vNWgduT94
 U625+E79dru2kBc+eJr8qAgZnRH4LvR9Cc+xUaMaJ/dc2KzAHFT1edIug1MhT5qZbh60
 wmztA16IsuPjsP2qYLy4rNA7SMQVguX2YeFNz5FeSSVAjGBBQI30UdPc5LwbAIGPtE9B
 ukXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805359; x=1794410159;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f8UgP/8uY2zvz1Mgk46mnFCdyCx7fsWjNi/QgmRp59s=;
 b=WVmvrU0/Eq9uDBUEwolPqhW5/oD1bwCVv2c3x7IqAu3+k8a66c1QKBVKU6Dva6nJk9
 i0wjH0z/NAf7TBLqskajp0XDPtrpYMHXhLEHwGQqee0k1nExIWr6YVPF3kYAiiLuPfwh
 l95103MrwNc2R1QE98Qy1YqnjMIrWMCmYqp5s1iNC9Cz3At8DeDo3qfFQVoquFwJUv9P
 /hvVm5d6ULvKq9ksL31ENL6jqH0LxuqXx+z9AWIxJZ9tEG+0/27mZGrduJqlLbIWCDt1
 SzMyJq5Qn+cAsq8Fzjn7ppK69bW1C3pErO99BTcPZMAPzamZtc6Vdumr6Jl4w2sRqR5l
 PbCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZbmCzbcQzucxLLUoHNTaqtdeAe3IQV++hrxWPHx/cZ3pUKzxnq86c6/KR4hjzuSZV6i6IfwAaIJcCoaeT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9RLXabKPPnq+T08Y+xHDcLlzcwqFygDzI8VyrfG8DY90kFFK0A
 ZISC0Eo72ecdQkX7jfOc9wFxdjaTA032rOYD9Kf2dJZ7ahoQDtzuQSYGJ6TusFkqQfg0thlzZIg
 snFU4RWAuWsyliKCFFh8SZg39ah9moLoAy9Bs7iNUGaqlre7hzTSI3G46HwwuHvs4LYfg
X-Gm-Gg: AYBFou1W54qywmxoSnxgPAh88DMB9l8JBRHdEn5LqY2oc9LUci6XigNEcSFlyX8pWJy
 rqd9DivOhGPDB9faZZWne7rbQV5WPnzpL3qrL86SekIA6m3PSCJFCl1F7DuIFAfzkceLVdIndLv
 GZmepBn1FTa9YZfp4qLkm0XzSRLvOKGx9bivEx+Q0jV/Kxl/Ajhsl0eCGuM6h2GCZFXUqKp5EBY
 c9GrteTVT6kejtyzC+Yflxufa6sj6NPO9xoudVCsReaZTPV/WZAaNkeGinfseuhRVlppcWe7boQ
 6NNy0dkQsRPic0FO4EQe0yKWOZB45G+vfvyaxGvUjMt7YyYv8ZHk5c0OFoSMvvCcRRZdpfmpfWk
 4Jl6vb75Ke3bhjxBBU+q0Mt337aQYVNr/hNxGNg9EB6lZBNvWAkNpAxORuCrWE7MWmHZ7H/AbBa
 iGwObP5aM3k+ze73ydE1hnOArE21pbyNcnsIS/J64oXSPTamA5HbghtYCNUfggBvM0jw2B/okIF
 NpLrA9ebRXfvuiySMp3bPNZpcehQ1NcpjSnmI9tMEYUAaxsj81BImGOf8HyITWVy/plXak47Hag
 sZHEUYOdDfgOXZaqH5WSlTo6pf352yRkvayyCrbnVzn8+gmx6TP/JO9ZOaMNCA2XdCSyJSbW5hf
 bvhoT1T31oIY5wd/BKfEK2N6Q5+afqOt8EmK0bArGXgWrRx/wQGlhXp2bvq8Z77tDLteoSpHH4A
 /cKHP2XDAwIFh6ig==
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id
 5b1f17b1804b1-4ac17d1995amr372302255e9.18.1793805358628; 
 Wed, 04 Nov 2026 07:15:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm58856115e9.4.2026.11.04.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:15:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:15:56 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 784196dabfe07410b20b9197bd46d58894aef69e
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:15:56 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5891b00bc5c6f60cb632675594ebde79afb42ad-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcib-000000006sI-2fsc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6084894983152851516=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6084894983152851516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7FRZklH7NXY="; charset=UTF-8

--7FRZklH7NXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipako=
v=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail )

Chang=
e subject: socket: Let an optional UDP socket give up on a failed bind
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 11:

=
(3 comments)

File src/openvpn/socket=2Eh:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915/comment/bf854817_5c0fe3c1?usp=3Demail :
PS11, Line 343:  *=
 non-fatal level and checks the result=2E
Then if you agree that `D_LOW` is=
 not great in all cases, maybe drop a line about how log levels change in t=
he function description here=2E


File src/openvpn/socket=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/6973ad36_b4d4db36?usp=3Demail =
:
PS11, Line 324:         && !socket_bind(sd, bind_addr, af, "TCP/UDP", bin=
d_ipv6_only, optional ? D_LOW : M_FATAL))
Would `M_WARN` be better than `D_=
LOW` here?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/feeb54=
cd_fcb77bf0?usp=3Demail :
PS11, Line 588:         msg(msglevel, "%s: Socket=
 bind failed: Addr to bind has no %s record", prefix,
`msg((msglevel & M_FA=
TAL) ? msglevel : D_LOW,`?



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number:=
 1915
Gerrit-PatchSet: 11
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attentio=
n: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:15:56 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--7FRZklH7NXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>R=C4=
=83zvan Cojocaru has posted comments on this change by Lev Stipakov=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Eh:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/bf854817_5c0fe3c1?usp=3Demail">Pa=
tch Set #11, Line 343:</a> <code style=3D"font-family:monospace,monospace">=
 * non-fatal level and checks the result=2E</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Then if you agree th=
at `D_LOW` is not great in all cases, maybe drop a line about how log level=
s change in the function description here=2E</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915/comment/6973ad36_b4d4db36?usp=3Demail">Patch Set #11, Line=
 324:</a> <code style=3D"font-family:monospace,monospace">        &amp;&amp=
; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only, opti=
onal ? D_LOW : M_FATAL))</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Would `M_WARN` be better than `D_LOW` h=
ere?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915=
/comment/feeb54cd_fcb77bf0?usp=3Demail">Patch Set #11, Line 588:</a> <code =
style=3D"font-family:monospace,monospace">        msg(msglevel, &quot;%s: S=
ocket bind failed: Addr to bind has no %s record&quot;, prefix,</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
`msg((msglevel &amp; M_FATAL) ? msglevel : D_LOW,`?</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
5?usp=3Demail">change 1915</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: L=
ev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 15:15:5=
6 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--7FRZklH7NXY=--


--===============6084894983152851516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6084894983152851516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6084894983152851516==--

