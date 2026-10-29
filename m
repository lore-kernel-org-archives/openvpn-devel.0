Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E346606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fJZ31v4m;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RQNYLjDO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IjpgsJ/K;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eZRDar9A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S/Ex2ER526OmriKXP54+Zf3fUQ4TYJTQeq4ATDNV/5Q=; b=fJZ31v4mLZ0+wGz87V7WDcZ8BR
	nJVz2WETz6SDBJWeGqSWWrDWccG0SFIPB+hQH0oUcOJuu1tNxObdC4pY6NK8JLpIY4rKfhN74nvnE
	uVVTwe+//3prsCZUEiKx2vU3IWKIVvD67P5gFpW5SQ2i7bktVSzea3bUWj/WYZiA8Tfg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTnH-000000001ge-1wqR;
	Thu, 29 Oct 2026 17:20:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTnF-000000001ff-0CT7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:20:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UePiLm3XPpk2RbA7XjDO84j4NvUX2F8UP2oRVuvRzkA=; b=RQNYLjDOsLSf50h0uFCPJfolZ4
 V4faRN5JsFjF/PeXq58Geo8GKb2pO3jGSoH1kWAvqdwIiGObw0OsK+tH8j1kqVNaYUVUDTZsvg3q2
 C57EYs23z6w12PkTATp7hFNmbXyH45bpU/XvRzZnAlqmbuyX7QNJ9mMmiV2eb9Vp49wk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UePiLm3XPpk2RbA7XjDO84j4NvUX2F8UP2oRVuvRzkA=; b=IjpgsJ/Kq8jE9NldpttN2qan1g
 rF8Pq/VNTjLmRnMOw160ds3BtHtgYEMsqIEeO5CjLQciUG/cR2y/EPJHEKcXxWUKi8GUK9I8Ib2nG
 wJDGnsaVCWeO7o2KjMYjr6W4lVbR5bzXkSRtAGCNtKRjyDsi4T+O1641/4ZylbSg+hbI=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTnE-000000006Iy-1bMP for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:20:00 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2145346f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294394; x=1793899194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UePiLm3XPpk2RbA7XjDO84j4NvUX2F8UP2oRVuvRzkA=;
 b=eZRDar9Abn5TtEX2TyBYGE/0MvNveH8AhTJTZlIJ0tiPS5uPp3BJ3BwZOZC7h+bUUT
 Lkr3EVGhxOL+7gE04kHOpbDtVoluj6BGsddYyvo5SXZ/lJ3bw/HmGyIZZ4JsYHzuZqOI
 o448EUD7GwYF9wq+4wvlX6VdmmHnYKvCQP9i6pbatKHsCxD+nDr24nula5uS1oD+N+3r
 S0dVI4EOCgkkvfR5hB8mv8qKoA5u8W1mo2St81OBCWx3SN2bM4p0968u0YX3sdZs7wXp
 Cr8TwqK/UVgQsE0g6lBzFMyQTSPbMSTLMGG9axLRIowjAw5wdsEAam4YdGYdOUahSV6X
 unuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294394; x=1793899194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UePiLm3XPpk2RbA7XjDO84j4NvUX2F8UP2oRVuvRzkA=;
 b=eJlwpFvuZasgiDHEZobz5zuXENZn3nsbszExsjOu7d+libEzbb5ES1UGAc6BMgZA/2
 RcEk1A3Vkr0nsa0SLTxOQpebiXUKfQJOeQir/0OR80Ag3u8lzO4DoNlm8tU27MroEqUr
 HF7w8X5YP2uORNWvgCe6HmpMixJ8BeMMTGtDiwDOXRDA0Sov44jRFyGt9BtxZk//YoWY
 mlL9a2LYuqgzUFZTxfYUUf6Pgk21FS8oP4bZ/9BGEmYjeNLmsk9Q8gHyGVmq8N9jci0b
 Vi0hkcBRymyQNW86K25zrOjUWH5Ahunb5Ch0NT2oSCCfZ4+zUbB4xvTKtTZ+Xla2OTaC
 7l7A==
X-Gm-Message-State: AFq9FYL3MgnRQFdLffbTzKPmVK/zVsp/ia/wXyKdF27rWapJ6APaxmhA
 IpEOVpCO9N1nSkNj2vy6c8ZIyjIBu5IV4Uhu7wpt+yUXdjrRLqcC5XE95kLucbz5OmGDwfKXNNJ
 lKq3CYThFV78M2IZcrMcx0FQOtp27NLw/D4WNeY0myt4wz5J8fR7fBCmrd2roth9MijJKNATZI1
 zQfcwwyw==
X-Gm-Gg: AYBFou1xzna+I9lxmi3vUGCeo/ORw8EQMpzAkTQWqAF/1LvdEI1FMpHwcYlQuaWxfCJ
 i2TSzYQWWDX0Beuub/elMdGNvKXx1hdyN+On7wGFagJ02DI+wbRMI34GnBAY2J7G726Nc28kX5a
 zEvDKjKnwCiaaKHPQmS6Fv5vWgkHYSVxX19Ln1jde8jI1TaY4NrCxwUpHCh97oRe4xvjM3RXHqL
 WUfkVzieZGX/SNacYrSBvpvgjG3KWBxhhu4BB1/UdSCBI8ieParZIpmZQ4lOK3igRgR/mVoB9EP
 RGje47z7pGRyJvRpg5SH4nDWS+OsWlhe4OeIxnlBfXR/Xltm9VVYHBe1FkNtzfAuRrVx7NtG+Fc
 NVgcYpkOS4VTYdmAhXSNqXZgPPYxsv50DghlRHsjGsDIdntgxebb957x4fM92rNmbMllpgHAuwU
 WLxeKlm/XAqNSdOH8WqoryjLHPddI2Y/luuU7x0WX9xKyRppsXc0fhuyGhhdj2Ilwq1gOKAi6+d
 LWsRrGkptjaGw6KjtztFw8PR/UH/hZrbOLFHBUvBdW/xKnFYjznjTNTe5J8Bezwt41asmuyxh9w
 NxMxylKdJ1lBZC55nPFXqv08gd4vy43h1bfGnXLErEzqy6KythJnoJexFbDZRAnk7mD4VDX4lwB
 jkPg8LAv72Pn1aGtKmnay5A8tuUlCW1oeRxKsPbIbzWwqjuVSFyF3q19YK4pbiHete3U7v8tddY
 a6gjTs/hwgKDXyn4w=
X-Received: by 2002:a05:6000:26c8:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e6e3040a3mr118675f8f.20.1793294393545; 
 Thu, 29 Oct 2026 10:19:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfba641sm358831f8f.50.2026.10.29.10.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:19:53 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:19:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: 50b033788abbd0a65d9a8c4c22cbfb923309badc
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2687b57376f80722cecb7ce67e47d95842329c41-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMTnE-000000006Iy-1bMP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2866398493092658704=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2866398493092658704==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+8KFVzB1o6o="; charset=UTF-8

--+8KFVzB1o6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Hello R=C4=
=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

   =
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail

to look at th=
e new patch set (#2)=2E

The following approvals got outdated and were remo=
ved:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Do not hash re=
al addresses of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Do not hash real addresses of TCP connection

With neit=
her status report nor max-clients depending on TCP
connections in m->hash a=
nymore, remove hashing of TCP
connection=2E

This now allows an obscure cor=
ner case of two TCP clients coming
from the same IP and port to different I=
P or port on the server
but as our operating system can handle this case, w=
e do not have
a problem with that either=2E

This has a small added benefit=
 to keep the number of entries in
m->hash a bit smaller=2E

Change-Id: If8a=
e9cbc971f60800a998abf2f97da0384c023f3
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 11 insertions(+), 2=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/67/2067/2

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 90270f5=2E=2Edc1f896 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -2455,13 +2455,22 @@
 
 /**
  * This sets up the cli=
ent real address (outer tunnel addr) in the
- * hash map for data channel p=
acket=2E If the address is already taken
- * this steps fails
+ * hash map =
for data channel packet lookup for DATA_V1 packets=2E
+ * If the address is=
 already taken this steps fails=2E
  */
 static enum client_connect_return
=
 multi_client_connect_real_addr(struct multi_context *m, struct multi_insta=
nce *mi,
                                bool deferred, uint64_t *option_ty=
pes_found)
 {
+    if (proto_is_tcp(mi->real=2Eproto))
+    {
+        /* F=
or TCP connection we neither need to be able to map incoming
+         * DA=
TA_V1 packets to the multi_instance nor do we need to ensure
+         * th=
at two TCP connections are not using the same address as the
+         * OS=
 takes care of that=2E */
+        return CC_RET_SUCCEEDED;
+    }
+
     /=
* If the address is already taken up by another client we fail the new
    =
  * connection */
     if (!multi_check_dest_addr_allowed(m, mi, &mi->real)=
)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If8ae9cbc97=
1f60800a998abf2f97da0384c023f3
Gerrit-Change-Number: 2067
Gerrit-PatchSet: =
2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>

--+8KFVzB1o6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by R=C4=
=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">Do not hash real addresses of TCP connect=
ion<br><br>With neither status report nor max-clients depending on TCP<br>c=
onnections in m-&gt;hash anymore, remove hashing of TCP<br>connection=2E<br=
><br>This now allows an obscure corner case of two TCP clients coming<br>fr=
om the same IP and port to different IP or port on the server<br>but as our=
 operating system can handle this case, we do not have<br>a problem with th=
at either=2E<br><br>This has a small added benefit to keep the number of en=
tries in<br>m-&gt;hash a bit smaller=2E<br><br>Change-Id: If8ae9cbc971f6080=
0a998abf2f97da0384c023f3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2E=
org&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 11 insertions(=
+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/67/2067/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 90270f5=2E=2Edc=
1f896 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -2455,13 +2455,22 @@</span><br=
><span> </span><br><span> /**</span><br><span>  * This sets up the client r=
eal address (outer tunnel addr) in the</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * hash map for data channel packet=2E If the address is a=
lready taken</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * this s=
teps fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash m=
ap for data channel packet lookup for DATA_V1 packets=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * If the address is already taken thi=
s steps fails=2E</span><br><span>  */</span><br><span> static enum client_c=
onnect_return</span><br><span> multi_client_connect_real_addr(struct multi_=
context *m, struct multi_instance *mi,</span><br><span>                    =
            bool deferred, uint64_t *option_types_found)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (proto_is_tc=
p(mi-&gt;real=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 For TCP connection we neither need to be able to map incoming</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * DATA_V1 packets to th=
e multi_instance nor do we need to ensure</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * that two TCP connections are not using the=
 same address as the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * OS takes care of that=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return CC_RET_SUCCEEDED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /* If the address is already take=
n up by another client we fail the new</span><br><span>      * connection *=
/</span><br><span>     if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&g=
t;real))</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2067?usp=3Demail">change 2067</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: If8ae9cbc971f60800a998a=
bf2f97da0384c023f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--+8KFVzB1o6o=--


--===============2866398493092658704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2866398493092658704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2866398493092658704==--

