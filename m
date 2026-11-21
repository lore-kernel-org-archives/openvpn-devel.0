Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD6606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DbOv98hD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m6inLzmR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FIUIYciC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ek4ifGBt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h37SCcnXFJMlh4yAC7rVLy0qzMzgWsx9IlajUnaHEFc=; b=DbOv98hDTysEdFKNW4pZ9gTfV2
	fLf/xExmRdyKarP4bsHVT+LVW+xD1D79M1XX7mK8cSnrUSeFfyJn7fV+SNCxCCOodGL0gjCTwTkV8
	cnAWoNEQBpFM9nSJASh0UBL6iRxOgSzcqWQ4vbAxN+JdMxDNeW39BpZIqlqefZv1fIYg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUncU-000000001NT-1xVg;
	Sat, 21 Nov 2026 16:07:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUncT-000000001NN-3b8P
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 16:07:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Acm5m2ta4YIfQ/35jNL8Er7lPHIrWf/IUSNf/QDFnA=; b=m6inLzmR/a1DATf9VIOFidLmnJ
 JM+T3d4ToTFwi+kRRW0rMpibxMQf1RRziXyjUIqkUKl0uSI/Pljb16Tu+iJbmI1JNhXn4+U4nklzK
 YBQj5a5f5AQLzq3y46TmymjGq5bsMuOfnvkxg4cU+I6TGallAAHBq18cssGMtU6ex7Fo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Acm5m2ta4YIfQ/35jNL8Er7lPHIrWf/IUSNf/QDFnA=; b=FIUIYciCezmJg53quyDptyiF4S
 4q+wl3Prhl353pQe8FLviXh2/+KJe2+a/y8KuQ7AIZjS81j7CJ21DjVezlvbxTpF9dW0auogtvhX9
 PtHJfyeDiveVCaJTXI9Uvesr4w6RrDSkCPWlxWdaHvDxHfxk8IWnfHNOST5W3ofTMz3k=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUncS-000000001Te-1phF for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 16:07:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso14251935e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795277230; x=1795882030; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Acm5m2ta4YIfQ/35jNL8Er7lPHIrWf/IUSNf/QDFnA=;
 b=ek4ifGBtsfET1qFGkXdyatnSuaH9CJcLpyShwDtJ0ohdQ/yvrHd+ZI73c2ZHAXtRV9
 Pq3qyy8DsGGFKeV8W+/2Yc7xNIgOynqY4MgT/8zVv5OcovdQZwdpYajF8kbIQmexeNZv
 BA7tnllT0u877M1XFEOxUu2+Jv6saVPL0aG4FO1v44Z8VWjTW3abhfYx0YVBG7ZmblGQ
 BmJ1SfpZJ/h0qIsPGeYabYjwf8JlwfEGEsP9ip82cTSPzzyH/85QIojy99rJNBdYfBXk
 qFNf7mYvLeuBmxjMSdrJw1TeMbzHiUAVDhoggsMAoAQXFW66TDsTptSRNhz9sNsxuf/E
 zJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795277230; x=1795882030;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Acm5m2ta4YIfQ/35jNL8Er7lPHIrWf/IUSNf/QDFnA=;
 b=YG/pWU2ONBRq3B7P15tzuTDYaGomSHkvHtic3m03AB4tnV5uaOkpLVSvkbNRsAaxOU
 h57I0VAb8aPC7LfnXHfVH3In5E3DWh3bEeWO3nuFVWq4VO3lQLS5mZtRqhFub5BdOt/C
 JHPi7z8Q+jxrPUHKRFyen3nVAPcQXqsj6vzPiygYo6QwFZsbA4tc6A6KQRSqbaAwaNhc
 jWNg7h+TUEajPG2s0XM490bF0xgiBHxRAVwg3rAieu06sOOxTkpoUWdPM+rblAR9Wlsu
 cQGC92LxolP0IZD7I180d3LYtAtJRrwwtRKbT+r9YYNmkXYgP4oJ/n1gv+YueqCijTVU
 umkA==
X-Forwarded-Encrypted: i=1;
 AL+hErFgCU2BXvNgmkN/PhmjWAEArWzLfRQm3Jj6g9NlLkBjY0FPLZ2UdMCqKJKkxi7yFuzkI5g+/9sQzMzoDMyM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+/DEZdM/RP+SlNx/XK8JKhyd5q0Va3hE/04y2YYb05JeFaBmxe
 WE4uh1hUbBZMQKH+Z9FaAqA8fcCv1xqS8gVFdDksFx/W5QFwNdHCIkSZIWJjK/0XpG4PFM3Z57a
 pvF7/A3wxPSA2EiziWwMgW4GUkgMv0McARAHOLg3i2jJDcAfXGtV0ho4KUdJlVnu0ZhULzs6lp+
 BCbJnobw==
X-Gm-Gg: AZFdTZdfQguHm6CwD/Tu4UMTqN5JcN2vpT/MNS12+tfZF/54GHkMBYSHgVFY+37suMO
 +xu3GZVJJQ+Gyq5HEfaKOqmzmy9e9+2Eg0wuPUDJpUZDkMSB880LKhkkOsyQ6C1PP5+7wJwT8u3
 QmH1GK4cCy4n3IfjSxnT7k/A4pWz7rrKlOhAHV+ofc3MM0Tu1okIbrcxpwSbSAuxiX5t+PNunB7
 10TJc3DkiNm1uxUWGORrg7w0dEcd/5UsaqgZNiWSxWhWcBBqPfZgVgOVkJPiyj5HQDJw5Bh4Jso
 zK2HQedJMQLhSbFynBbWnoNxzuNgCwXLcTjPN1AsG3gCMS/NMUtfOG8GDfS1cvg1SOSJCB0eZxM
 Ft5+kxX8a7jrn5S2vcKCnvZ5QyMLVDmy97HmAzJ7eu2eepzaLX3YwdWTt633ojuKYEzCJ55RDLw
 VcFuAlRCZZaS/I3neyitlwyI7lGIqZeDHMWylVDjTDy9XMm01z4YqxMICe0ThFLfrt2/wXYiJwE
 K/b0bkLBKdVmA3fd+/EaUrQRObwHO9BCyeFHcAvnB7DaQqJ1Xq3T6ba1QSil2cjsjsJGI7oXH0h
 ibfXb9ilU2PFUaNHMcqCkJs28AdIPLIURrplZ6SixRtC8ZM5STRsemf9P0CLTUA5oIw7S+4Sv0S
 jN5zdzXYruCjcJxiFiFkBnBCXtXM9fB31RnjsJ5UFJcOx9xZqPrenDjCSlFFdqJVb06i2XyidFX
 vFQnddBHlFmHa2DLE=
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id
 5b1f17b1804b1-4bb88822242mr162995935e9.28.1795277229787; 
 Sat, 21 Nov 2026 08:07:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm233288735e9.10.2026.11.21.08.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:07:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 16:07:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: e212b83177d7b3503a280ac35f39e1d5a264b0be
X-Gerrit-Comment-Date: Sat, 21 Nov 2026 16:07:08 +0000
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <610fe8c6c014a0fe943b29e408864e0adf8f0745-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUncS-000000001Te-1phF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2388968129822127544=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2388968129822127544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SQPEDcATVsY="; charset=UTF-8

--SQPEDcATVsY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail )

Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=


(2 comments)

File src/openvpn/networking_freebsd=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2153/comment/9e60e4ea_cef78388?usp=3Demail :
PS5,=
 Line 32:         argv_printf_cat(&argv, "%s", inet_ntop(AF_INET, &_gw, buf=
2, sizeof(buf2)));
> when we're here and reworking things to make them more=
 nice, let's do another step [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2153/comment/275cdf0f_8f801883?usp=3Demail :
PS5, Line 74: =
        argv_printf_cat(&argv, "%s", inet_ntop(AF_INET6, gw, buf2, sizeof(b=
uf2)));
> same thing here for `buf2`=2E=2E=2E
Done



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64=

Gerrit-Change-Number: 2153
Gerrit-PatchSet: 5
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sat, 21 Nov 2026 16:07:0=
8 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: =
Gert Doering <gert@greenie=2Emuc=2Ede>

--SQPEDcATVsY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">View=
 Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_freeb=
sd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/9e60e4ea_cef78388?usp=3D=
email">Patch Set #5, Line 32:</a> <code style=3D"font-family:monospace,mono=
space">        argv_printf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET=
, &amp;_gw, buf2, sizeof(buf2)));</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">when we&#39;re here=
 and reworking things to make them more nice, let&#39;s do another step [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2153/comment/275cdf0f_8f801883?usp=3Demail">Patch S=
et #5, Line 74:</a> <code style=3D"font-family:monospace,monospace">       =
 argv_printf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET6, gw, buf2, s=
izeof(buf2)));</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">same thing here for `buf2`=2E=2E=2E</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">change 2153</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e604=
3178935fdd05e6ea78c411dac5decb7ac64 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2153 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sa=
t, 21 Nov 2026 16:07:08 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </=
div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--SQPEDcATVsY=--


--===============2388968129822127544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2388968129822127544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2388968129822127544==--

