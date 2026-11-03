Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48A606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TKUmg+ov;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R/H1RRWY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cyfRXE9P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aKKMpDir
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HO9X5K/YdSSSjNKZzIoT3OEPVMaHEeKxgDya0TbukDE=; b=TKUmg+ov9KbwBdD6lqTukt/PPH
	XbIU2hxxfwbHaey0rza/T67hXI4kcJ6pJL7WnpIYzAmWL2tlCb9cPGCW3nPckbRDq1O00KWimiI6x
	F5kBK9ziOY7/qQ8b22Pn7UMNroG64TpXnVYHhNxmUtlmTj98kLzf5OYztFTsRcD1/fOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGzE-000000006gQ-3Sc3;
	Tue, 03 Nov 2026 16:03:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGzC-000000006gK-1FSs
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5LWaKPmnO3WQS6vo19MLozBDtEY8Hv5mvhmKBfB3D9o=; b=R/H1RRWYlJ7o/S9gJHfR0Z46cS
 J86P112ZCFBs2+R2ox7UW2WipdjCE/UX+9UEnLnbdWBvwhRVaX9vgPG3XvwnNioNeJLq4k+8pFBhw
 tMBVCmIjfmSypSvTpFeRHXjNeE6zfd+xawXsmb7vyAvj/sUuubJFzlSpc5aUTiPh9pUU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5LWaKPmnO3WQS6vo19MLozBDtEY8Hv5mvhmKBfB3D9o=; b=cyfRXE9PD5r8fdLDEb+WUkk0Ua
 ldOlM7X1uEbTCJHYmHZ/LpJfrb/gESGt/rrTp52pR5Z4X/UD9275TkYIMnjv6vwfi3/gv9yL+gNe1
 NTb3Z7oxOxx95a00pXCdJtlbyJgwo4L0JYw+Go+DcFJK0C2/eegq4Vdi79RMctR8DkpQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGzA-000000007CW-2es1 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:03:46 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so30240965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793721818; x=1794326618; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5LWaKPmnO3WQS6vo19MLozBDtEY8Hv5mvhmKBfB3D9o=;
 b=aKKMpDircG+Z0BhSCyBoToSTqkX8deLJqJdonYnUZi2eTCJ1CTmUd8XyuucvVuAAmW
 QSbRcGQwl3KXTF45yoj5zO1xuCa4MN3QuCn8fVfHMUcyrZo+OLk/pwHVUD6WUqjGPlBP
 z5dJFWaEScKe7wgcnhGO3qc/xlfDcTSBNnT78xWjbcva2arxC0YFXoQB0IHCqaZZSl/g
 aaEqaGqdc8Gg95Z5GKt+1VU/lSKp/PelquDx/awNMqnKO5krATWa0RYN0g22BpWGiDOb
 DjgDJI05C7Xy7AaIXL2aBGfKf02pPFkdBgAaQkN6BQP6eRrvo2SzB+Qf90d5mh8YSx8Q
 DNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721818; x=1794326618;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5LWaKPmnO3WQS6vo19MLozBDtEY8Hv5mvhmKBfB3D9o=;
 b=OCi3IKDElm8yYn+n99NRrxB4sD2P5fPFjJTRLV2FTpsRvnihmG1VckYd3DK/AYwaJa
 DHQId6UnNtuPotWgtwvUrE8V6ObWJCpU9MLUvchUmACvJ7QPSzIbQuumM/3zo96x4a1J
 mUGx9x85zbjiDM057KjZiPia64C/b2sn5j3otHSnH0HFOpSw1CZqoU5L1wHK9EpdOxp8
 MKE1MfUnUDkA4ykqksqdH5ScT+4QI/I4H4QaqKeNpfBiU5vEv/iXciUfhheEUckzmktx
 TfLqs/ZtbHlFpDU7VRa1auou0Nai+ad1Xzj6NGvq8cFDN60f6lAJ1BY3C8skA+4eCG3X
 kWfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI8bOS25sdIWuec65gBAcPYbVgXRT1tXZS+Db9BIjWJ8yh1RJ/9ghoqVvdA4oCEdIe4co2XwNCCgQmv2LF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9TMDZt88Gs2fGKOoOxPZIJVSFHgZbYHdyOAvu4qtxoV6R7hi8I
 s3cgYYsgmYsS2H9nBm2e1I2ej7cca4MqbeNPt3fOE/yJkM/8AFSjK0b+oLyvHMAtgbi+EePWDj3
 EVFcyFbgrAH7IQxn23EoGqftVGtm57MfKFkSh2MfkW7nb8pw2Z2zmEW/va/GXxdaZsydG
X-Gm-Gg: AYBFou3jI8lh6jTBUTOn8zVKuowYxj93kcTw8QdgHjnPLz0mquJ9ErVib5OOtUMSYgx
 9+PWrVYC45IKwQuZFDPpCijC6Ws1iI4flPSIRTI/9UpGu/U2bW3KWY6/1vh44ncQhT3W9kAj5Tk
 mBgxH3E0iDHADumuRdre8iJCQGt4ufhOtCXaFkP7H/18bVxQhF6d3Fs2prEc6DQuaOKdBnpFIbc
 S3vHeBhGVXeZOqMh+Wnz6eIryboedNEY3DGexcC4MOVvDh8YSJr7g1xz7Lxktv5Rc4bf3bVpj+g
 P1evgSWYIq3MRCKZLe771fYwlYxVahpIrQfHpqJozMBZ8tugcQbDW58piBOreKPTu5cHRGSdtAG
 x/+tWU1JO8Ao5zoDIl++n4jDLyxexmdv1Ke/D+fn4gwVz9+Z5Hxc6NNdmedIBTP3vRE+i7DYA6c
 FpTjiSdAvloDHxUVkp5xxH2IY9h93QCiHq0iy6EB4WnymtIYEBi2SF9JgWK4PtPOeEwmSzGkCl+
 pXEsEPHVnGxfnGdBfeSmSCTOU2w2z15PlsdSVEwRIR66hBCiKo/xPc/SPJ3YIv9WoexqppJy3k0
 FsDy/gjG/Y5UvgnsV4IusHtS1zeZCcD+snyN+scy3p9youam92bTd06A3GP4n0C8S0NvvBE76zR
 PNdl67mubx9VfHXluUUQ8RXudA/R+wqfd5tIv6DLw8kTIFxj0B5+K5sxPHMpRpwtxQHIOs2L2ng
 bM0/jq7ExoA810Q3DkxoSOZuOoFiyQ5Yl6lvQ=
X-Received: by 2002:a05:600c:a41:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4ac150b2136mr292641215e9.4.1793721817729; 
 Tue, 03 Nov 2026 08:03:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm66742135e9.15.2026.11.03.08.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:03:36 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:03:35 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: eb47f700d852cd5c740d549fbf835ed63781bf10
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ec30d2f0bcfe1ea5df9a77d690bb6e899e3ae5b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGzA-000000007CW-2es1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4846446085634146087=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4846446085634146087==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yF7aJADZfO4="; charset=UTF-8

--yF7aJADZfO4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2076?usp=3Demail )

Change subject: auth_token: Wipe the server=
 secret key after loading it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

auth_token: Wipe the server secret key after loading it

a=
uth_token_init_secret() reads the auth-token server key into a 2048
byte bu=
ffer, copies it into a struct key on the stack, converts that
into a struct=
 key_parameters on the stack and frees the buffer with
free_buf(), so all t=
hree copies of the key stay in memory=2E
tls_crypt_v2_init_server_key() alr=
eady wipes its struct key after
init_key_ctx(); do the same here for the st=
ruct key and the struct
key_parameters, and clear the buffer before freeing=
 it=2E

Found by scanning freed heap blocks for the key from test_auth_toke=
n=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ib5eb24b156acb5a9=
9c614050fb1bd64fe46d8b52
Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
A=
cked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2076
Message-Id: <20261102090635=2E24906-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40478=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/auth_token=2Ec
1 file changed, 3 inserti=
ons(+), 0 deletions(-)




diff --git a/src/openvpn/auth_token=2Ec b/src/op=
envpn/auth_token=2Ec
index 969f37f=2E=2E84558af 100644
--- a/src/openvpn/au=
th_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -172,6 +172,9 @@
     key_=
parameters_from_key(&key_params, &key);
     init_key_ctx(key_ctx, &key_par=
ams, &kt, false, "auth-token secret");
 
+    secure_memzero(&key, sizeof(k=
ey));
+    secure_memzero(&key_params, sizeof(key_params));
+    buf_clear(=
&server_secret_key);
     free_buf(&server_secret_key);
 }
 

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe=
46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 3
Gerrit-Owner: Hansaem=
 Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--yF7aJADZfO4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">auth_token: Wipe the server secret=
 key after loading it<br><br>auth_token_init_secret() reads the auth-token =
server key into a 2048<br>byte buffer, copies it into a struct key on the s=
tack, converts that<br>into a struct key_parameters on the stack and frees =
the buffer with<br>free_buf(), so all three copies of the key stay in memor=
y=2E<br>tls_crypt_v2_init_server_key() already wipes its struct key after<b=
r>init_key_ctx(); do the same here for the struct key and the struct<br>key=
_parameters, and clear the buffer before freeing it=2E<br><br>Found by scan=
ning freed heap blocks for the key from test_auth_token=2E<br><br>Assisted-=
by: Claude Code:claude-opus-5-5<br>Change-Id: Ib5eb24b156acb5a99c614050fb1b=
d64fe46d8b52<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>A=
cked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076<br>Message-Id: &lt;20261102090635=
=2E24906-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40478=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
auth_token=2Ec<br>1 file changed, 3 insertions(+), 0 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2E=
c</span><br><span>index 969f37f=2E=2E84558af 100644</span><br><span>--- a/s=
rc/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec<=
/span><br><span>@@ -172,6 +172,9 @@</span><br><span>     key_parameters_fro=
m_key(&amp;key_params, &amp;key);</span><br><span>     init_key_ctx(key_ctx=
, &amp;key_params, &amp;kt, false, &quot;auth-token secret&quot;);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure=
_memzero(&amp;key, sizeof(key));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    secure_memzero(&amp;key_params, sizeof(key_params));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;server=
_secret_key);</span><br><span>     free_buf(&amp;server_secret_key);</span>=
<br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2076?usp=3Demail">change 2076</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5eb24b156acb5a99c6140=
50fb1bd64fe46d8b52 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2076 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--yF7aJADZfO4=--


--===============4846446085634146087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4846446085634146087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4846446085634146087==--

