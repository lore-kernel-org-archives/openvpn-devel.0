Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0E606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L4MUrW2X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kcOEoGwn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mxmoEa4K;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cwt9RRSj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ryHAnRQC0KG/Umo5BSho0gQJOg4SkI/NRNvUBSHfqbY=; b=L4MUrW2XLxxwgt2fPX2stcBVgC
	VvGMpxWkIf8c4l7Scckn/u0AsLkKffWOJhWwKVWeB9QC8pCvrqrObMfAP51bYZS3edX2ZAMhujTHW
	iCmJh/qlDjP5W0rLuO727KPQ5DiUhuN3I4ni0rP6W1knUcx9+KOKGTsSAZoSy0QjZA9o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJIr-000000002RY-2jy8;
	Tue, 03 Nov 2026 18:32:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJIq-000000002RN-3Rli
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jF5F5s0RlcuoAIPOjdVW4/3ReOKMFbXQdkR9FbeU0Sc=; b=kcOEoGwnsmWM+t1gsVJOEy5TWZ
 m1UJAFJdHqLM96ioFkOnhs2LHBVPeosuOH7TMTEwLKMPe7Jv9JAeHBo9BUln9tCIrNrYyYFcTgMPQ
 G0fKCtRAWTRvtib6b4vyLa30at69UauHhW0jU2d9LzBK7TdV06LDDVaf6Crj+4wKq3DM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jF5F5s0RlcuoAIPOjdVW4/3ReOKMFbXQdkR9FbeU0Sc=; b=mxmoEa4KcMQPbD0f8dhhs4jd+h
 pTFo2LxeVv3sNVrG5gaEWHhiMZ92EZjswOkdLSAbBiIx34h3hzHvWjDbpxMRlE4AiFisdsDgSI4UL
 92H3PX9YAhOpBsXdz6FbIHinNln5ARvg+VY0nH3T/hZtcYCbg0fry8F3drhREJZy9J8k=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJIp-000000004uv-3FZy for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:32:12 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so40448265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793730725; x=1794335525; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jF5F5s0RlcuoAIPOjdVW4/3ReOKMFbXQdkR9FbeU0Sc=;
 b=cwt9RRSj4Gi/88ptJTDx58NonCx054R5q+BuX0LI/DuxkQ/MiuUprJL41zL0PeLZx8
 p4AG7qiEpaCY1F1oAJp3pInw1RQHqNj8X2KlJb6vZvmF3BFc2odpOv6U3pMcrL9t81Gr
 qoXx9FAUbA3m5fs+npeKjm0yUBDKjv+ZM2Enqpxi08lFWpxsW9BOWUi+j6xraQ/Nmv3v
 dLuSS8dM+jrSLjBJBVJoP423fvf4c4xplvybs5sbZi/8zs4MuE+blpwIAv3szf5hQDSJ
 jSBtXyIV2DDp10UfDBHRICzHkOMz0mrvxwt4YwYAidMrpgYbeEo3lTH7JmxCUWlp8nS3
 OkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730725; x=1794335525;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jF5F5s0RlcuoAIPOjdVW4/3ReOKMFbXQdkR9FbeU0Sc=;
 b=VaYn+ROSowCjgiScvnvwEeuX0VcTg9SulniuDhggQ2JFTAL5DmmlNggeLdNsrsPKxW
 zFSHW+8gWOsRaqkrX0Mk1higgV1AQwNTxukyaWQ+ZnZ4iyN7ynOfA0dnvUgjwBtP81Nz
 1DgYWfGn+BuKiBYNm7KRARh9Glsmb5WnLe3cy/hgvNqDpGkTrc5nmdPsu3CtkNJQb+sS
 1pPAoEexXziDToTtcEu1pMnk3hkxUtBORPdUrHSKQb3Ndmh7fTGeq5IA8UCqbkGQRxeU
 6c7UuPfwMKbl+c120uOAb/wZJJ6P8WdpwKsM/mXynZGlR/Fh1mEYtodE6wnsB85SLk7r
 pHaQ==
X-Gm-Message-State: APuU4Z+rtEzMiyIT6Qe7R0ts4qZg45pIzGvO1M42RXnH1aBFUbIB2Bms
 qCUliwKcDqrctN5lv4J8F50qzfMbqEDdAoOgQn04vp76HUKWVzxQzX4gjLGOO9hgUK6EigZe8kU
 +sv79ExMsP96QrOiiRgWAVagnLINoHTITiss/g2TkDvLJYX8t+YZmi1U+bVIGOMYG65fZ
X-Gm-Gg: AYBFou2r8JJ2ERaMwBaa7S+FHFM65kiT6zeUAxFy5Btr5iT55s3XyPlAwDYaIvBvjml
 E770kClbDGFQ00BmOGxP2Xp/EzzJGtn+e9p1TrRHMHBiiPR+9+YAteUkXxVX4d4L3J57zA9c2f+
 6U/eUNehI6eHXHYv1syTcDCfJHNpTdHe2b3bRx7YWAu5+tO4MLgADwYVfArmKslRFwd8dL9Ts2c
 Z+pMxWgn6wG/FIoMne8M+iA75o0ATckb/bBbJbTrczO8faWHTIHy+qKBxtW0NsLFjee/+jqW4G0
 xg9CoMukA+Kj2ar3HQZ9gB2LvPc6h3+JU3WEahvxvyN7X87A4wX5OwBKXUqJGPSLH3eI8oW2uDM
 fE649mU6Zv8AInkT0R9w5ejHQjj7qGeaij0F8oHG3zQBvLQElfKAhpaI7jk6/Hdljl5izSjSPwd
 VhJuOyI6AVkcshluP5JwSD9n+9OUbci32HZWeV0/+ceBML9fse9LNksyAHVwFDG3i1aJUyFpBFs
 KeDdDBhSdLVhVqPEFqBwDPuwxUnGZc+XALNv7J01XdUA2B5R/C74fA1oSVSjGjNlrtV4L5xMR0W
 ZMqE06ZUM5DhvqxUk8naKaRGnBpmcS734WFvQZHTRQO5UZ/waSYppmHtMtZOiYUyKZdUg3GvKA4
 dhA/kCdzTqRBCmwWGbi7b0RrPWaMZPcpxXIr43Km/QGrlcYm+qrL0slwONHj4rVSo0ujx5x67GQ
 AolssDXBTJBAYoDw==
X-Received: by 2002:a05:600c:8b0a:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4ac1709a200mr333085015e9.16.1793730725031; 
 Tue, 03 Nov 2026 10:32:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879fb29sm69090445e9.4.2026.11.03.10.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:32:04 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:32:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
X-Gerrit-Change-Number: 2090
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2090?usp=email>
X-Gerrit-Commit: 09cc40a6ff9e1d81db463a7769c464dd2baecf1a
In-Reply-To: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
References: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI0NTYzMDAwLkk5N2ExNDA4NjI1OGMwOGI0N2UzN2YwN2YxMDM0NjBhOWQwYmI5YWZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68d4551dc9a9cf2e1e8070b4e9d15013ceeb8de7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOJIp-000000004uv-3FZy
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 inverted inet_ntop() check in GetItfDnsServersV6()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3350210304991753798=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3350210304991753798==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sM4Ibe6icZM="; charset=UTF-8

--sM4Ibe6icZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2090?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: openvpnserv: fix inv=
erted inet_ntop() check in GetItfDnsServersV6()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix inverted inet_ntop() ch=
eck in GetItfDnsServersV6()

inet_ntop() returns NULL on failure, but the c=
heck treated success as
an error, so DHCPv6 DNS servers were never returned=
=2E

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT"=
)=2E

Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
90
Message-Id: <20261102170238=2E111437-1-frank@lichtenheld=2Ecom>
URL: htt=
ps://lore=2Ekernel=2Eorg/openvpn-devel/20261102170238=2E111437-1-frank@lich=
tenheld=2Ecom
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpnserv/interactive=2Ec
1 file changed, 1 insertion(+), 1 deletion(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/2=
090/3

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/inter=
active=2Ec
index e2f17f0=2E=2E484f27c 100644
--- a/src/openvpnserv/interact=
ive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2217,7 +2217,7 @@
       =
          s--;
             }
 
-            if (inet_ntop(AF_INET6, &in_ad=
drs[i], pos, s) !=3D NULL)
+            if (inet_ntop(AF_INET6, &in_addrs[i=
], pos, s) =3D=3D NULL)
             {
                 *size =3D 0;
      =
           return ERROR_MORE_DATA;

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2090?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Gerrit-Change=
-Number: 2090
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--sM4Ibe6icZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2090?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnserv: fix inverted inet_ntop() check in GetItfDnsServersV6()<br>=
<br>inet_ntop() returns NULL on failure, but the check treated success as<b=
r>an error, so DHCPv6 DNS servers were never returned=2E<br><br>Broken sinc=
e 0f3b7d17 (&quot;win: implement --dns option support with<br>NRPT&quot;)=
=2E<br><br>Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2090<br>Message-Id: &lt;20261102170238=2E111437-1-f=
rank@lichtenheld=2Ecom&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-deve=
l/20261102170238=2E111437-1-frank@lichtenheld=2Ecom<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interac=
tive=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
90/2090/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvp=
nserv/interactive=2Ec</span><br><span>index e2f17f0=2E=2E484f27c 100644</sp=
an><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/sr=
c/openvpnserv/interactive=2Ec</span><br><span>@@ -2217,7 +2217,7 @@</span><=
br><span>                 s--;</span><br><span>             }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (i=
net_ntop(AF_INET6, &amp;in_addrs[i], pos, s) !=3D NULL)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (inet_ntop(AF_INET6, &am=
p;in_addrs[i], pos, s) =3D=3D NULL)</span><br><span>             {</span><b=
r><span>                 *size =3D 0;</span><br><span>                 retu=
rn ERROR_MORE_DATA;</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail">change 2090</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97a14086258=
c08b47e37f07f103460a9d0bb9afd </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2090 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--sM4Ibe6icZM=--


--===============3350210304991753798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3350210304991753798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3350210304991753798==--

