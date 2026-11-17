Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817C606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J7JflhFT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BqtIg1d4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k6Eif36j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dTU7V+C+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oraqw9dGKqMeXly/4L7xYkya+30RrpPA1cDT2hPp16k=; b=J7JflhFTIm9fTRFoqdUSJZnkrV
	fzP2dboK8TKT+O25IpuhcIzY0mEsP+vnBoAtSpdctqO3+v5k0MJ+zYbGbKPl7jTx/1tacnbFvSuxT
	6Lc6hxqn4/QUOj67upA9LwOJ4ACUdeu8TZGsOQe1NKdyFEFPLj1BZt63TtizTKD9jy+g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMGs-000000005cZ-3a1R;
	Tue, 17 Nov 2026 16:43:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMGr-000000005cR-3efl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HVpCaAMPfyNykRXVdmv2VL4YfwyIDPJIgo2sl4JZ/ys=; b=BqtIg1d4R6C/Mt6Q/7yAZbMvvC
 vvyPmOCfEJwT7Tu+JEUl4IqucT83T4ELM6i4df+LoFLGJxnclUYrb1E5+JmPCIkbmDImwp1Tgz10Z
 5DL7fkCYl16VLxM1JHHCKFVKicjG/Hkd/Dof/mqJlqkldMq42JYrsj95zjw7ylLTdUTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HVpCaAMPfyNykRXVdmv2VL4YfwyIDPJIgo2sl4JZ/ys=; b=k6Eif36jv/d9Xn54v5Xo7Bqgss
 DM326SCoIxFoT0amu3BDZ0oHuVVDTtD3c7FDRfOGLTh5ebIxVIu6WjVUiGjgjQi65TZ7pLpsaV9kl
 PMTTydES1jADSoEOND48uBRXEFZceMfzA17VP526hhaRPyVF5h5RI/+sbGvfRobB5Jfg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMGr-000000007DN-0RLA for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:43:01 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so959125e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794933774; x=1795538574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HVpCaAMPfyNykRXVdmv2VL4YfwyIDPJIgo2sl4JZ/ys=;
 b=dTU7V+C+v5YdRaJvqraS/mwRda+AtLP+WdTJPQRPsi2PQ9cP6vVoBbZBytoqdW18wA
 nVLwzkIVogwAUW8lBGog6rgLTwIs8lRx+1lbtB8eRIRiaV+h8CS1GNiEbA7xa8YefMus
 uDMpst/sZh6Ncqq31VhKuEjJwSrR4A1rAPGhLDoyTBwZmEglfb4iXKP3NT++3wMvrMk0
 Ej6ml91WgFnp9NPCoVPU5eIFuqvStEntNxHlrJWXqiEbQ7IHleGtknM5tecBj/DDcnTx
 SII1vxN4yyjYAg2G/J/IfVd9k5K3Lzp0HiCHBnI86bfuz1xuw/QTG4VX+p7lyfx9RLJm
 JViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794933774; x=1795538574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HVpCaAMPfyNykRXVdmv2VL4YfwyIDPJIgo2sl4JZ/ys=;
 b=qnTn69RagiBT+uiwh9i19oLULo01MNdPGqzvgGydz/F3M3JBvHIFOcIXHeH4cbEIQo
 Y/Uf9VsgSCcggf0XJAW5pGWF/3+Aw2XyjrSpRML/UkGhTz1BIRZQk3cHpSlqgSRg/cyR
 WC2oJNiHgzyIRuo1hXGLZl2eNQAeutDwGmCp1uqTUkbThpc8lVldvj1a7pGl1G20Fb8p
 MssR2fFsNlEpO3VVrwIq2HGoXW+eADDqwsQ4UqRcC7oZTkJ6W1lIECYWRyhF3B2GExV0
 3O9fA2olPgsHDVBLbVs+KroUgDA6MXZExNk6toO6Q3vZcixHgx9ZdQxx9KS0eVcQFAqE
 Yk1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFQ6T7erQ5p0O0ypEhIJaAbmL8cImYO/ecOP+PCL1ayjYubkSA26KuTgU8JcqSesZ0FBYtFsnda6Svy6718@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+j867CI55bSK2w5hNuhQFwR/0MOEYBrzYZXt3OAfshl9drLfIj
 HUYZgOEGYtZel6mSDd1FdUNRok9rRUraOo9dgLEX7GfQo2KB9seeemD/55MPzKki/qECkPArFME
 4X1HPaoaQIQVM0RytPg+DUtr0tP90Et+fRnUlbgZKVVIdJ2NZ1dSwi/zrWTkn1Rf4hXknJs6M+s
 ttVGjVog==
X-Gm-Gg: AYBFou2Q4aHv7ZVEqSs3bmDbg5FuDmXyMfoLUI/c2KHf/1Tzmdxu7zprCXJI16nToVM
 4jrdZ4H0Eavc89WJs0eck5mSM5ulwCEBeB2BvA8QVkHcE6XwZhMoNIoSi8e5TWBwhuxDPkSsyX6
 YyhPgtQ2e7dPTjyYxAHTEeu3Y38X4NbwPUGWY4OGI+lMAbNpHdxhBBsWFI2vORnEun/HOpQJwYR
 ZX2lkMV5r5JCcrTEliAunCQG9FXR86E10YJhq4C2XZT3TZtgoblfYu/AiCeQWrR+NQr7NW+jSPQ
 vHSlEBjfS1LfEnOovLCUCXJPNGZVybrazPHkMkqI9u6X8l2i5CiExogvu/0cWoNXefp3R+ZQXy/
 EtSgf/NBm9VdEJCpMQNcHUMzIyQAcozZY9IorqnBSOpC++Zvk/DDjuG2FEjlSo9TDuikH6gzDMh
 9+kbtQAqxQWXJ7ROEHcg2X12lz8kg8eZ9gLDXmv5iTbSKwvbY1O+Ju/l7zJ26heG+mtH8HellU4
 ZFoQla4zcJAHWW8pRXFkCAcF9c7JM65SZonEHAgRqo+wbSkFgqaDy9pF+kBqFmhq2WB95H572pf
 EYYEGQH79iIh7+EgA2smVqkA4DfS8MAX4wtD8o6Rb2eCwGE9CN06wfSBahvzJ+cfNpujjqPxabm
 5p7poyP9cNKoVl9BiR7ZZl8AfzM3mkqusow+tOqVFXImtT7hDNPnojQLU+xfbjU7JsH/9qsm223
 xm/aotWldHiLOFVwM=
X-Received: by 2002:a05:600d:8449:b0:4bb:5f07:10d7 with SMTP id
 5b1f17b1804b1-4bb5f07134dmr205355265e9.26.1794933774281; 
 Tue, 17 Nov 2026 08:42:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb734b9f44sm106271925e9.1.2026.11.17.08.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:42:53 -0800 (PST)
X-Google-Original-From: "Aravind O R (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 16:42:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: eace777a91aea4065622707b07668aaed6b3883b
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 16:42:53 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0f5952e4c6564cf65b24ef3a2b6d3aa6e682a67-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTMGr-000000007DN-0RLA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Aravind O R \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Aravind O R \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9079658781701489379=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9079658781701489379==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AruC0CUS7no="; charset=UTF-8

--AruC0CUS7no=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ravind O R has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

This is the autotools hal=
f of adding GCC/clang hardening flags, along
the lines of what the MSVC bui=
ld already does with /sdl, /guard:cf and
/CETCOMPAT (2612125d)=2E If the ap=
proach is acceptable, the CMake build
(used for mingw and development build=
s) follows in a separate change=2E

Three points where I would like your op=
inion:

1=2E It is on by default, with --disable-hardening to turn it off=
=2E A flag
   set in CFLAGS or LDFLAGS still wins, for example -fno-stack-p=
rotector
   or -Wl,-z,lazy as OpenWrt and Buildroot use=2E If you prefer op=
t-in,
   that is a one-word change=2E

2=2E -fcf-protection=3Dfull only mar=
ks the binaries as IBT/SHSTK
   compatible=2E Linux enforces shadow stacks =
only where the kernel and
   glibc enable them=2E It is cheap and matches w=
hat distributions ship,
   but I can drop it=2E

3=2E I wrote a small macro=
 instead of importing AX_CHECK_LINK_FLAG and
   AX_ADD_FORTIFY_SOURCE from =
autoconf-archive, because the probe has to
   treat linker warnings as fail=
ures and must not override a FORTIFY
   level chosen elsewhere=2E Happy to =
switch to the archive macros if you
   prefer them=2E

The testing is summa=
rised in the commit message=2E I only had x86_64
Linux, so the buildbot res=
ults for the BSDs, macOS (arm64 with
-mbranch-protection) and Solaris will =
be the first real check there=2E I
can share the container build logs (patc=
hed against master, with the
ELF checks of each binary) if they are useful=
=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3b=
ad2185c4cee824ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 1
G=
errit-Owner: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Tue, 17 Nov 2026 16:42:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: No

--AruC0CUS7no=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Aravind O =
R has posted comments on this change by Aravind O R=2E</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is the auto=
tools half of adding GCC/clang hardening flags, along<br>the lines of what =
the MSVC build already does with /sdl, /guard:cf and<br>/CETCOMPAT (2612125=
d)=2E If the approach is acceptable, the CMake build<br>(used for mingw and=
 development builds) follows in a separate change=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Three points where=
 I would like your opinion:</p><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">1=2E It is on by default, with=
 --disable-hardening to turn it off=2E A flag<br>   set in CFLAGS or LDFLAG=
S still wins, for example -fno-stack-protector<br>   or -Wl,-z,lazy as Open=
Wrt and Buildroot use=2E If you prefer opt-in,<br>   that is a one-word cha=
nge=2E</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">2=2E -fcf-protection=3Dfull only marks the binari=
es as IBT/SHSTK<br>   compatible=2E Linux enforces shadow stacks only where=
 the kernel and<br>   glibc enable them=2E It is cheap and matches what dis=
tributions ship,<br>   but I can drop it=2E</pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">3=2E I wrote=
 a small macro instead of importing AX_CHECK_LINK_FLAG and<br>   AX_ADD_FOR=
TIFY_SOURCE from autoconf-archive, because the probe has to<br>   treat lin=
ker warnings as failures and must not override a FORTIFY<br>   level chosen=
 elsewhere=2E Happy to switch to the archive macros if you<br>   prefer the=
m=2E</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">The testing is summarised in the commit message=2E I only had x8=
6_64<br>Linux, so the buildbot results for the BSDs, macOS (arm64 with<br>-=
mbranch-protection) and Solaris will be the first real check there=2E I<br>=
can share the container build logs (patched against master, with the<br>ELF=
 checks of each binary) if they are useful=2E<br></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">change 2213</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8fe=
2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2213 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind O R &lt;ara=
vindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
ue, 17 Nov 2026 16:42:53 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </=
div>

</body></html>
--AruC0CUS7no=--


--===============9079658781701489379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9079658781701489379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9079658781701489379==--

