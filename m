Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56E606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a45bpDEz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YyRzN14W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TPpr6FMU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=add0Xnpz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AHusBulmoyen0eX7SDD9dAV5XREVq9jYTmxcVqGF1pI=; b=a45bpDEzcP5tRnfz7S39d5HH/2
	EXw69VUt97qoy6XBoyVm1xjKtfEhssQnSvv6jizHAEotwJ35l98Uh/Mx/qcHcf/MSISMvDnjMR3yp
	z5tNHVWGBKkXwQMBb/2x19U+P21hM4uY+dy5lbjEqNv+gZfRzOr4WqczNKRmOCzPq7Cw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYbx-000000002Ik-2Sqs;
	Mon, 23 Nov 2026 18:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYbw-000000002Id-103z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZAxeXIipcgLJDROjTaxpb9D7HGQG1CtnsT6y8jhFPM=; b=YyRzN14WuoxSCAaz5LEJAKgiLX
 ooi1z6wmcLuYL8ZZECQGrGlInvy1HWttaWeLvH4MxBqD9Q60TIZupuLfSziFwR7nZbmKFBWienrIx
 VFLMFkhNjp5Ltc968a8lHkJNDkjvcUzpP8bwYpGJVN5O5m7WUzBEV6+p3YaBFKIN5YQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZAxeXIipcgLJDROjTaxpb9D7HGQG1CtnsT6y8jhFPM=; b=TPpr6FMU1qfCVNPyiJjadJvfH7
 maa2WKFpjjelBbxinJzu1ui9/Zqh53EEdNyA9Ffyjj4rSYb5Jzx/N0C2eE52p5u1InFOWYU1gdZnc
 y82bRUmqgS/pyQzdk1Ogj2nC5W7KlmljY8SGsjORKRPyS9a3oKdnedSER+f7LqR8HI8k=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYbt-0000000034z-0AQ1 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:52 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so33433185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795457862; x=1796062662; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vZAxeXIipcgLJDROjTaxpb9D7HGQG1CtnsT6y8jhFPM=;
 b=add0Xnpz1f4D7EFnWWDn+UG7Ghw5hQLcYKZc6TjsZiztyeaNk+GviIze5EeOISPh0X
 gLx6x74+/M86CXMAEdslZdpzhI5eR+UY3XZo3TzrbrB2z1JLH9NbIJBTlF/LtR9AogHQ
 doQWSDydEeKcEVFsJYeL6A0Boc1sJKqPVd/FBqmjA5NfLro8u8Rx6lrOo9gdEvz6D3ZW
 ObJO70SmKQXMmCwYyMfGghlfHw0FrkKtyma+1TJC7WVAqQXHhuQP8iMEI5Z+AaJhc5FP
 xDj/0jqbLtyCubpu0RH2xFhfZ6EfKUFSV7xMjX2Q+9gzPgttrFV5XEFcfp2g8vUpGhSG
 HBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457862; x=1796062662;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vZAxeXIipcgLJDROjTaxpb9D7HGQG1CtnsT6y8jhFPM=;
 b=SHt4wECr+3liSlLj32uzG26FoVs91iWKAlrhgWD77CqZ+XAj/SUt8q//aES9vAx80t
 tJ0QCduMCScWIiUHiXw6TVL0164AC4DvEv93ToJ3XFi7yRb4YUmhENizLLdxM6Rla5di
 vL6Hk8PK3VyxDJ/68rIEVn3me/FQe/fmcICowNj6jMqvqj6mCtddSaPcZgZFXF/h/j1D
 WvJtM9XG/8SZkKEOFzxyDFM+iU4qwCSIODz+u79b5OFfa5+PFX52k7QcHha7RE18l4Kj
 VN0mcYHofNbbwx+/Af4GD3Q86PqkEDGvS7d4YOuy8EwIFiZOJw+p9fDaclMweV0FBLkK
 3h0A==
X-Gm-Message-State: APuU4Z+/eoeJnZMCcuhSy7U5E9+llAe4eG28tkRw5hmF5sM+NU4omNYu
 qrICpncCix42uXE+dO3xcDKDH90Cpn/Z9vFnYscpR47z0Jw3u301+6vZZmMBOaCMjRcmbP535gG
 AOqgooDFEVRk5Grmoo3BWnS92yd3AxolKhW5yshlwgBjlY6/8mpWjRB/Fo3nMbMOGlV9IVbaLdw
 SkRSm2cw==
X-Gm-Gg: AZFdTZdi6H3cVSJJIiGUIukYZeZ8F4cLgZZeOf28CnERDby+pnZ2FvqpHmD7fnpKfXw
 ACfSvD6cs0j18ds5zb4ertHvBMPjHiJxPE7ueSvV9b8bmKH8Wc8LnfqB8eIyf48Y1nCzIlL4N2U
 joAHcZr8eoq5+fpGigou1EnROvNeVmmi5PZqn6fFNLhlzeHC5eY1nhLugrGhFGFCesyySC4fPdA
 goHeNc2hJFU5RA2Wbia1lBJf5ReGvKjsP0QkUiFkv6+dBbe1xdMnSxzDyJVV7L1MdZQmnM8dr7t
 Cw0d/a6f6m2N55KlznATuxVsbeP57Xfnf5H+U7uq/4dxZuzagIdM+Mo+Hww3Mk7KM0h5NTE3nF4
 dyN6Q4camkJu7BMlQqd/8nqQcBbzovu8OnIhGlZ7a5DyUpHYa+cliInzBHmP3IOMccYHXAireju
 rwiPPohLLJ3DDiKfLuSBvdnL2TnA6TJDoXVbb3Bu3O7xDFMIofRMkQle09aIABeYKK2XX0BljBR
 0nSNmBgYp8dsOrrKYxBovQ3Yx0JN2ZC1EtZs7lKo83/atr3wUI0YjhTXfaynPHLpm1phxzpakXE
 r5de7aVjTh0NP4OkOyUVIAK/vke6LPTSICHc0TKy1kcyzcaKlMOXiwMLnsT6rr09AZYl88Wb34z
 /47A8xKMHIM301DD/8Nw8sV8NHr/FjcjUCL22THm/tdsxagz3cVUo0Xsbxj3Ku2jaaMs0eSQY7E
 D/1IHgB0/MqtPPXac=
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4bb88824f38mr292309805e9.15.1795457862364; 
 Mon, 23 Nov 2026 10:17:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm324384275e9.4.2026.11.23.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:17:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:17:41 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: 2f921ab3b4b80c2ff1b2ff3daf41ff206f499bdd
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e08eec863f5d369f1bbb34ff7d2aa91feaa92f8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYbt-0000000034z-0AQ1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
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
Content-Type: multipart/mixed; boundary="===============8430683016248193856=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8430683016248193856==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="toRHCHLyf6M="; charset=UTF-8

--toRHCHLyf6M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2237?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: free ext_cer=
t_input in man_connection_close()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

manage: free ext_cert_input in man_connection_close(=
)

ext_key_input was freed there, its certificate counterpart was not=2E
Wh=
ile here, pass mc to in_extra_reset() like the rest of the function=2E

Cha=
nge-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237
Messag=
e-Id: <20261123135003=2E31908-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41824=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
manage=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2237/3

diff --git a=
/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ab814d5=2E=2E112db4a=
 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2841,=
8 +2841,9 @@
 
     event_timeout_clear(&mc->bytecount_update_interval);
 
=
-    in_extra_reset(&man->connection, IER_RESET);
+    in_extra_reset(mc, I=
ER_RESET);
     buffer_list_free(mc->ext_key_input);
+    buffer_list_free(=
mc->ext_cert_input);
     man_connection_clear(mc);
 }
 

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a=
6596942d
Gerrit-Change-Number: 2237
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--toRHCHLyf6M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2237?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: free ext_cert_input in man_connection_close()<br><br>ext_key_in=
put was freed there, its certificate counterpart was not=2E<br>While here, =
pass mc to in_extra_reset() like the rest of the function=2E<br><br>Change-=
Id: I48d315a38a653aed4b33d3277433cb8a6596942d<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2237<br>Message-Id: &lt;20261123135003=2E31908-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41824=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 2=
 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2237/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ab=
814d5=2E=2E112db4a 100644</span><br><span>--- a/src/openvpn/manage=2Ec</spa=
n><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2841,8 +2841,9=
 @@</span><br><span> </span><br><span>     event_timeout_clear(&amp;mc-&gt;=
bytecount_update_interval);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    in_extra_reset(&amp;man-&gt;connection, IER_RES=
ET);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_extra_re=
set(mc, IER_RESET);</span><br><span>     buffer_list_free(mc-&gt;ext_key_in=
put);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_lis=
t_free(mc-&gt;ext_cert_input);</span><br><span>     man_connection_clear(mc=
);</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail">change 2237</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48d315a38=
a653aed4b33d3277433cb8a6596942d </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2237 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--toRHCHLyf6M=--


--===============8430683016248193856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8430683016248193856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8430683016248193856==--

