Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4A606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Jt+Hc7nD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mmFWJ1rT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Dh1Y4f8g;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vy4hjERc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=shhju2U96jS4MoS8+3+PlhyuYg2oIkMKlkLhgYsQDes=; b=Jt+Hc7nDtVconeWILmgiP5AvVj
	cR+25qI/KYTLa2iKwHcUe+n+l+sA0ROpbnTeYDc4UQW4SZhrqHFtBRAuU5SDq+9l42xFKyWhwdGOz
	sE7+XaEf6/Widpbs7lK51xIc8sKSSbsz6mwJI4QsEQGVsqpsV1cG83KBxzoPQIUJayok=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKJxp-000000003HY-2HOg;
	Fri, 23 Oct 2026 18:26:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKJxo-000000003HK-0Hig
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NUR4VVh+q2dRvoh+iWeRWYuB1S20jG5EtdjiTu1qwVU=; b=mmFWJ1rTVbsPDpWGP+cOYdffGp
 TIaW3HA4g/rV121qaS323MSdQ+KhJ5ZIEeIxpH2ICSiOme5GGko1gMuzdraqyKIrl28R+jzsFlCKe
 /GnoWCQ1A2LZ7wh/2eWfqboztkCGmXlvXgRKi/IQgbwqgoLOgmjrYelKRXyNKqa38s4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NUR4VVh+q2dRvoh+iWeRWYuB1S20jG5EtdjiTu1qwVU=; b=Dh1Y4f8gNqAk9blISLVgOpYu62
 xxAqd5XfqRG+2YKQnbJRvBx2M0UD9zsKeTEC97c+6AzU8itVNsXnwZAQ7fDY+Z307BMQHg+d5VXbP
 jyp4v5Kzr3UqXOzQlwuPFmAv621HF2ZotvxoDxsPEL9Y3yc2EpXAdqV15yfbUQNl6Brg=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKJxm-000000005YX-3VLm for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:25:59 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so958373f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792779952; x=1793384752; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NUR4VVh+q2dRvoh+iWeRWYuB1S20jG5EtdjiTu1qwVU=;
 b=Vy4hjERcW1t+PDdw92579k/RapPMdvg8TmDdbOrU3PKdbL1qbJIfEMm6RB4hvrrROM
 Z2qyVr0OGJ/UnL2nB9kLk1kxaKaYoaKk6fRWzAJ9BZrLREEoKmuk7CdvFFBiAGAIeNhh
 aRCRnbXfvDr47f9r5T3pKegWChq5fOf0XPOSqvhmoStDAc7vo+mvfHiT3Ya66OhIVyTa
 txhj4aJekaRLk98YK084B5+phkY4UQA2Qlg35BHh0LTv2mFpR+WuTO1H1pRYbjRbIt2u
 cd0Kle62sEuZkbuuPKgmsC9LYW75Gc/rlEOedUQSTaZRsmdx8ToEEySfpUcU/ChZU200
 GsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792779952; x=1793384752;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NUR4VVh+q2dRvoh+iWeRWYuB1S20jG5EtdjiTu1qwVU=;
 b=dNZS5Tn0CjoqWtRm2/aR0qg5mitin1g5NmSqgTKVzewZN5oMayOWiD4w5JZ1ZgYZtw
 pHvpt+jIub/Ud9p1siz5Z45FebGwqTZNmjY0CHeKfQgas6FgBWCezJ5Y9GEZB0OcEMdE
 z9d7rVg6dP+aAQQ1zWP+yMubDVHXntOXeWPTiWIHuKvm3jw3vEFlFYcTbxRNgjBYZi0y
 al3zTwV+MhiqC+5SbaLzlTH6MEc52MLXLWtMCDT9ROzmETTOeftBVztwO32qN/vZNFWS
 zAKT+xYh11lM4TpjTodBTr9nFpEuQEYnsj8RbtkVbywyqOQh+zF/V008FY1Mle9wW/14
 +O8Q==
X-Gm-Message-State: AFq9FYKDWAWRDYWyM7kHHIYE/K9CFTAl8Ak8EIyvykmXyQxE5EBWGj3H
 kdpjNiUggURAK9DZeCytAdZuroBQ0xsQZ1XUvyONEeDsT6dos/dxyT7qJDqCAvsRJBshqnn2lup
 aV2fEeWIU9Uibg91E/qRvgVpL2VVZvKkQvcWcrC3Z2x11H5OmxFM9RljQ7ntYI3UPnkAcFMwVYk
 ojE5FzRg==
X-Gm-Gg: AYBFou3vDDHw+Q6NMv8UUL1l3DqKYSCdifxZAHhZ4kedxnW9AHUZaNLuwSxvoC2ALzt
 7XnplTPn2q3mZyvRzbqYwksykKVHAXYxMRlgJdgSGHAXp9yOQGxWsC1ajRkvYYw+nuQAqMACHbr
 0Ab5Gv4/vFAnXMEKzxoy2VJNmvfyIdZ9BVbmhJ0RmP8zLwePnxR4bI506le1ZyKjw5ZAgsdnLL2
 xHJqBN15kxmhdy2sE2xHBsw4t4u7sPU2vQMtVanfryH05hzqeb4cK0nMA3NvY4BJ5V36qKxMb7i
 YXVeasKoOPonFn9nVndWQPYTCXKfvJLcrzrgyaxhRzVm/i8Poz+fDi5iqV2x+Un9w5oQ73lL8nO
 UHVxoZ80rhkGuNM4V2xJtQWPdIRjvP7R7qxPI7Xh9r6vgWuZHNqTngfQJVoujHOe8ggjHopvVBW
 U8RtC0jCNN5RSTA3Dck367w+HVPgyY8naI7Mfd39usBVFZOG25hAboWpl7DGzjFKrKLM2AmYa/g
 Lsr7Dt84tx8OfEU3OxiDkHyI5DuIs2yxX/5/m6c4Q4KxkysCNWaStBP0gop+W3cj3N4fpUIpLgC
 z1t2tXGZD4ItomvFukexXtRpeAwUKTXhXKhiDlT+cV/Lg3/YaaQzT5U24OQTR+4CP4MHsyw6qA5
 FZsiMBAGYd2Vk3IISmhqrXJn7ivSX8DPCGE+gC7XmfawUYagst+lCGwqbdwGkkcc=
X-Received: by 2002:a05:6000:29d3:b0:48e:adc:b97d with SMTP id
 ffacd0b85a97d-48e2d142df6mr8143390f8f.8.1792779952044; 
 Fri, 23 Oct 2026 11:25:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f9d0dsm1813145f8f.22.2026.10.23.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:25:51 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 18:25:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
X-Gerrit-Change-Number: 2030
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2030?usp=email>
X-Gerrit-Commit: 0d7c91a11c99f254b9b29630a8bdf760a883351c
References: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNzc5OTQ5MDAwLkkwMDgzYzZjNTQ2MGZmMmFmZjYzODU5OGFjMjZmOTlmZDMwZDAxZmQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3f1147afd30266eac5680817dbd7bb5517bf70c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xKJxm-000000005YX-3VLm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interactive:
 validate message size for dns/nrpt/wins handlers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7220185452760991705=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7220185452760991705==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4lyYY/RatHg="; charset=UTF-8

--4lyYY/RatHg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2030?usp=3Demail

to review the following change=2E
=


Change subject: interactive: validate message size for dns/nrpt/wins hand=
lers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

interac=
tive: validate message size for dns/nrpt/wins handlers

HandleMessage() dis=
patches every fixed-size request only after checking
that msg=2Eheader=2Esi=
ze equals the size of the expected struct: address,
route, flush_neighbors,=
 wfp_block, enable_dhcp, set_mtu and
create_adapter all do this=2E The dns,=
 nrpt and wins config handlers do
not, so they inherit only the generic gat=
e (header=2Esize <=3D sizeof the
message union)=2E

The stack message objec=
t is not zeroed, so an unprivileged pipe client
can send an undersized dns/=
nrpt/wins message and have the service act on
uninitialized stack memory: a=
ddr_len, the address array, family, the
interface name and the domain lists=
 are all read beyond the bytes that
were actually received=2E The service r=
uns as SYSTEM and takes these
messages from any local user, so it should ap=
ply the same size check the
other handlers already use=2E

Add the matching=
 msg=2Eheader=2Esize =3D=3D sizeof(=2E=2E=2E) check to the dns,
nrpt_dns an=
d wins cases=2E

Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Change=
-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
Signed-off-by: Naveed Khan <=
dxbnaveed=2Ek@gmail=2Ecom>
---
M src/openvpnserv/interactive=2Ec
1 file cha=
nged, 14 insertions(+), 7 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/30/2030/1

diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec
index d36e8d5=2E=2Ee8203c6=
e 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/intera=
ctive=2Ec
@@ -3292,20 +3292,27 @@
 
         case msg_add_dns_cfg:
        =
 case msg_del_dns_cfg:
-            ack=2Eerror_number =3D HandleDNSConfigM=
essage(&msg=2Edns, lists);
+            if (msg=2Eheader=2Esize =3D=3D size=
of(msg=2Edns))
+            {
+                ack=2Eerror_number =3D Handl=
eDNSConfigMessage(&msg=2Edns, lists);
+            }
             break;
 
=
         case msg_add_nrpt_cfg:
         case msg_del_nrpt_cfg:
-        {
=
-            DWORD ovpn_pid =3D proc_info->dwProcessId;
-            ack=2E=
error_number =3D HandleDNSConfigNrptMessage(&msg=2Enrpt_dns, ovpn_pid, list=
s);
-        }
-        break;
+            if (msg=2Eheader=2Esize =3D=3D =
sizeof(msg=2Enrpt_dns))
+            {
+                DWORD ovpn_pid =3D =
proc_info->dwProcessId;
+                ack=2Eerror_number =3D HandleDNSCo=
nfigNrptMessage(&msg=2Enrpt_dns, ovpn_pid, lists);
+            }
+        =
    break;
 
         case msg_add_wins_cfg:
         case msg_del_wins_cfg=
:
-            ack=2Eerror_number =3D HandleWINSConfigMessage(&msg=2Ewins, =
lists);
+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Ewins))
+  =
          {
+                ack=2Eerror_number =3D HandleWINSConfigMessage=
(&msg=2Ewins, lists);
+            }
             break;
 
         case ms=
g_enable_dhcp:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2030?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
083c6c5460ff2aff638598ac26f99fd30d01fd1
Gerrit-Change-Number: 2030
Gerrit-P=
atchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>

--4lyYY/RatHg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">interactive: validate message size for dns/nrpt/wins handlers<br>=
<br>HandleMessage() dispatches every fixed-size request only after checking=
<br>that msg=2Eheader=2Esize equals the size of the expected struct: addres=
s,<br>route, flush_neighbors, wfp_block, enable_dhcp, set_mtu and<br>create=
_adapter all do this=2E The dns, nrpt and wins config handlers do<br>not, s=
o they inherit only the generic gate (header=2Esize &lt;=3D sizeof the<br>m=
essage union)=2E<br><br>The stack message object is not zeroed, so an unpri=
vileged pipe client<br>can send an undersized dns/nrpt/wins message and hav=
e the service act on<br>uninitialized stack memory: addr_len, the address a=
rray, family, the<br>interface name and the domain lists are all read beyon=
d the bytes that<br>were actually received=2E The service runs as SYSTEM an=
d takes these<br>messages from any local user, so it should apply the same =
size check the<br>other handlers already use=2E<br><br>Add the matching msg=
=2Eheader=2Esize =3D=3D sizeof(=2E=2E=2E) check to the dns,<br>nrpt_dns and=
 wins cases=2E<br><br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet=
&gt;<br>Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1<br>Signed-off-=
by: Naveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>---<br>M src/openvpnse=
rv/interactive=2Ec<br>1 file changed, 14 insertions(+), 7 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/30/2030/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec=
 b/src/openvpnserv/interactive=2Ec</span><br><span>index d36e8d5=2E=2Ee8203=
c6e 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br>=
<span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3292,20 +32=
92,27 @@</span><br><span> </span><br><span>         case msg_add_dns_cfg:</=
span><br><span>         case msg_del_dns_cfg:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ack=2Eerror_number =3D HandleDNSConfigM=
essage(&amp;msg=2Edns, lists);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Edns))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                ack=2Eerror_=
number =3D HandleDNSConfigMessage(&amp;msg=2Edns, lists);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>       =
      break;</span><br><span> </span><br><span>         case msg_add_nrpt_c=
fg:</span><br><span>         case msg_del_nrpt_cfg:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            DWORD ovpn_pid =3D proc_info-&gt;dwProcessI=
d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ack=2Ee=
rror_number =3D HandleDNSConfigNrptMessage(&amp;msg=2Enrpt_dns, ovpn_pid, l=
ists);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (msg=2Eheader=2Es=
ize =3D=3D sizeof(msg=2Enrpt_dns))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                DWORD ovpn_pid =3D proc_info-&gt;dwProcessId;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                ack=2Eer=
ror_number =3D HandleDNSConfigNrptMessage(&amp;msg=2Enrpt_dns, ovpn_pid, li=
sts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</=
span><br><span> </span><br><span>         case msg_add_wins_cfg:</span><br>=
<span>         case msg_del_wins_cfg:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ack=2Eerror_number =3D HandleWINSConfigMessage(=
&amp;msg=2Ewins, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (msg=2Eheader=2Esize =3D=3D sizeof(msg=2Ewins))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                ack=2Eerror_numbe=
r =3D HandleWINSConfigMessage(&amp;msg=2Ewins, lists);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>          =
   break;</span><br><span> </span><br><span>         case msg_enable_dhcp:<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2030?usp=3Demail">change 2030</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd=
30d01fd1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2030 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--4lyYY/RatHg=--


--===============7220185452760991705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7220185452760991705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7220185452760991705==--

