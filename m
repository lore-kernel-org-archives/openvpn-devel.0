Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCB606BA60
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XMRfIJBW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qvbj3+4w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ji7Cwl/r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IqH0LW50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cmCZ/ySkpZ48UBy2aBrJNQSiSsmVo9sbJWDJLKdwd98=; b=XMRfIJBW20PzYeSwil7oqreNd3
	dMJUzboVbpsTbqHeQlEKR3KbZ6mRFQpuhrt2CrNr1ziKrPoDBLE8f8ExknrXnu7GKnmHoYB0Uzg0K
	m61lxSZryd329TtAsdmlbDr6TdWgSPGNJ6vBizNd4BOV0b9lK0PcZ4oBnsQPYRG3F+mo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNwFI-000000002SY-0PwK;
	Mon, 02 Nov 2026 17:55:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNwFH-000000002SR-0LNS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRrXXmCinQ6S4a0dcnohFxhzfi5Ko4yHgYpbyymcEos=; b=Qvbj3+4w2Lq9dlkhOBfJNEzEbT
 L+ZxmxOvOa61E8/FY78fqIrLmTBIYTqrvmUeJs9OgPMycrSxQh3dClnMuZgQUvEdXQ0hthiv7n0xr
 jezSRkXQNoJrAkVBkTbNcO4sdQo3eCSVnc9xtbZpH+4orWf+jO8L92TjitQF0Q4kRQpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRrXXmCinQ6S4a0dcnohFxhzfi5Ko4yHgYpbyymcEos=; b=ji7Cwl/rc3VoV7ctrrPYxx981f
 iBGEKKMHmxQrbDk19zBOYuwKVuMVARBTHO+cT1cLp3sBaOK9RwvPvQRSLHVEluwWldeVmO9+LprSU
 RejgfQPQgP5eOHAhM7F1rRRsFsUanUyRQmYJC6/fG1aYquh6uLQr8h5G9pgfeQDbkw7o=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNwFG-000000007ua-0s2a for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:54:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so25478635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793642092; x=1794246892; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wRrXXmCinQ6S4a0dcnohFxhzfi5Ko4yHgYpbyymcEos=;
 b=IqH0LW50yis3jgXSBDPwHPHA4LWgW8b4Va8pPUQQOrdayCxL9lcFbk8+n48Vmq+rR7
 8R/l0eWeuRXqc4PC7sqmSnJx6ylKCzP0fnVcFrdtQ1WKSbN1LwE4gnIFD6EpO6WbFUnq
 Bfw0ICDw5EyDQBptalvLXuv+Y+5S7qej3i+IAOqU4t3m5m1GkwaH4cpVd/SVQPYOzlBW
 Hk4mFxOcweRW9Y9bIsOulIcz9fW5f5Z8z48FDXhzBT6TVF5glhUlDzr0+Wc4qe7Bsmft
 IBjwV9DDHswDsXsm81V3tZWxz8CLIjwXRdZ4YFyFOVuxKDUJWFtK2js3tznQ70Ml34/s
 a3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793642092; x=1794246892;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wRrXXmCinQ6S4a0dcnohFxhzfi5Ko4yHgYpbyymcEos=;
 b=X+3WlHp4yc8obJzbQq5Nv4Z5axANtHFR8NtYFIYy/Bpgi9QP/IYUW+75AMSq91CQ4k
 hAg4ugFOKWDTL8njFEja9aXMfLdXk2xBJFpuMRtVwQpljQWu6Pe/cnE8jHHyiXJo/s65
 4U85W1g/pHtd1wdQClL9XO+GvK0yBxjOJDrufxklTogHQ0fmLWqOzxzOw6d+wr4yqHUR
 D7v5Fxgk2a+8BTD2PUBa89MVDRn042F6inLji1vnRh4UQWxeQx7xyRnDCXuvlZZq7tiM
 I+ym4tnqYzj4at+uXakq/9TdMMMEEm9QEQMXdwMI9F91ofMZgaK88WgqhC6gL8fdpYXL
 7nKA==
X-Gm-Message-State: AFq9FYIz//nTYcuBBt0uCiB3Bl96ZdI4lmT1jYV8x/ylpvBLpdZC8k5S
 R9/hs/qElXXnjK8FnfYRUkkinHxIS5fKs41Nxr/QMG8Xx13go/RiPJFxdntH/Oq+bhdfdqfSn5Q
 JEyDiTfHMVNtCtNxTVR3Q6fZ/68i59JlR5KRS/2lMoDeLBBOQ9+/APc0Pj604UdsmFIvo6Gp2Kc
 o0msvwzw==
X-Gm-Gg: AYBFou0ZDORvqFR1ngkCUzuKpVQcJMxa4GdZH3aSOP9WHtIO1hxWNKadWba+PIOZVlR
 3nBSi3ngVEs2Br5K8L2qWqnQN0D8k2xAIC9jOpCZ8FeEewagmzII4+gN7xzw/f8HpdPctDBe/t3
 XX3vLYvcL2zmd/jQnEF/f+6+YMPCS+/Ih1kRLRuVpezRJItdxkJJif6s3YzdhiR55+rbf0HDgsg
 CotjALgAJri1vYhzvLIDsyM6gsev7OwOEYWlnppb0+LWElwycdOeJtfBjF8JB7raYS/WqWPJihn
 QN1ETdql9jYdkUkP+9vBofJqJ0rbyX4G0CUVhPtVUtsyOXTOKerQplpQNnlLy+Ty+nehjhZb8+B
 GuRd6t1vaFolgmsqnPZuQtR4mzc/aeWP8XAolD13RltTO8FxZgYhZM1NUvbHBwibwJ0P4pAhJOy
 u3N2kR8WrYos+OD13xpx2tgrTVUmFtlgIxOUHJV6JbOrE0cCEwQnpODue7+jXMueKuY1kpyET46
 7emX+FCtDVEi5uHhfr/8iZvpuwcjCZxHGPFi8FvC3QwFIH2k5HMhpFMU0O4bFxpWfRDKSBO08uY
 kheV8dkRpCYYiq61/U6efIbBF/hBLUDI4XkzO1do9tZ8UPTdxwBlPy2//5EtcmiR/G9hlRe3h2S
 9yXPW67ELwFSTd/dGnDeEh3spknwbKdDTHfQFK74Pf3Hkbe/xYbLmDW4Lucwvp3g8HFpXtC0VpQ
 BwJKQFR1cqkFjmbg==
X-Received: by 2002:a05:600c:4e50:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4ac16bc461emr248917535e9.7.1793642091446; 
 Mon, 02 Nov 2026 09:54:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm215781195e9.3.2026.11.02.09.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:54:50 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:54:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 7fc07de241c5135581ccd16e638b6e2c101d6211
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 17:54:48 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c52c816fdb992e36007b7d0c6d80852bd36cc71-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNwFG-000000007ua-0s2a
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5757374336798071941=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5757374336798071941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DqlS9dEs2As="; charset=UTF-8

--DqlS9dEs2As=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(9 comments)

File sample=
/management/acc_sysinfo_client_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2037/comment/8a1a11a8_7acf614d?usp=3Demail :
PS2, Line 84:      =
           addrs =3D [x[4][0] for x in socket=2Egetaddrinfo('google=2Ecom',=
 443)]
> getaddrinfo is sync and it will block whole code, but maybe its no=
t important for demo
Yeah but calling the async getaddrinfo is not much mor=
e work, I fixed it=2E Thanks


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/a68de430_5d0135df?usp=3Demail :
PS2, Line 102:         if platf=
orm=2Esystem() =3D=3D 'linux':
> PyDev console: using IPython 8=2E39=2E0 [=
=E2=80=A6]
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/c=
omment/e0051400_b024824f?usp=3Demail :
PS2, Line 123:         proc =3D awai=
t asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubpro=
cess=2EPIPE)
> Maybe we want to add timeout here?
Done


https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2037/comment/de20c496_c9bad897?usp=3Demail :
PS2, =
Line 132:         print("=2E", end=3D"", flush=3DTrue)
> Leftover?
Done


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/505f0ac8_9aca5ea2?us=
p=3Demail :
PS2, Line 135:     print(f"Management interface version: {manag=
ement_version}")
> Mix of print and logger
Done


File sample/management/ac=
c_sysinfo_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
7/comment/4b9eb543_8c3c5544?usp=3Demail :
PS2, Line 36: import base64
> Unu=
sed import
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/f=
317eec8_95880934?usp=3Demail :
PS2, Line 40: from pprint import pformat
> U=
nused import
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment=
/d3acdcfd_055e60ed?usp=3Demail :
PS2, Line 64:     def client_event_CONNECT=
(self, client, kid, env, extra):
> Should we have here a method for reautch=
 client_event_REAUTH ?
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
37/comment/90c4cfe5_1e9ec2de?usp=3Demail :
PS2, Line 94:             if typ=
e(response[key]) =3D=3D str:
> isinstance instead of type() ?
Done



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e83887b8c07d=
0d09baff6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 3
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set=
 #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Comment-Date: Mon,=
 02 Nov 2026 17:54:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: Name of user not set #1000061

--DqlS9dEs2As=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></=
p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_sysinfo_client_de=
mo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/8a1a11a8_7acf614d?usp=
=3Demail">Patch Set #2, Line 84:</a> <code style=3D"font-family:monospace,m=
onospace">                addrs =3D [x[4][0] for x in socket=2Egetaddrinfo(=
&#39;google=2Ecom&#39;, 443)]</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">getaddrinfo is sync and=
 it will block whole code, but maybe its not important for demo</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Yeah but calling the async getaddrinfo is not much more work, I fixed=
 it=2E Thanks</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2037/comment/a68de430_5d0135df?usp=3Demail">Patch Set #2, Line 102:</a=
> <code style=3D"font-family:monospace,monospace">        if platform=2Esys=
tem() =3D=3D &#39;linux&#39;:</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">PyDev console: using IP=
ython 8=2E39=2E0 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/e0051400_b02=
4824f?usp=3Demail">Patch Set #2, Line 123:</a> <code style=3D"font-family:m=
onospace,monospace">        proc =3D await asyncio=2Esubprocess=2Ecreate_su=
bprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Maybe we want to add timeout here?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/de20c496_c9ba=
d897?usp=3Demail">Patch Set #2, Line 132:</a> <code style=3D"font-family:mo=
nospace,monospace">        print(&quot;=2E&quot;, end=3D&quot;&quot;, flush=
=3DTrue)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Leftover?</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/505f0ac8=
_9aca5ea2?usp=3Demail">Patch Set #2, Line 135:</a> <code style=3D"font-fami=
ly:monospace,monospace">    print(f&quot;Management interface version: {man=
agement_version}&quot;)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Mix of print and logger</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File sample/management/acc_sysinfo_server_demo=2Epy:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2037/comment/4b9eb543_8c3c5544?usp=3Demail">Patch Set #2, Line 36:<=
/a> <code style=3D"font-family:monospace,monospace">import base64</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Unused import</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/f317eec8_95880934?usp=
=3Demail">Patch Set #2, Line 40:</a> <code style=3D"font-family:monospace,m=
onospace">from pprint import pformat</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Unused import</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2037/comment/d3acdcfd_055e60ed?usp=3Demail">Patch Set #2, Line 6=
4:</a> <code style=3D"font-family:monospace,monospace">    def client_event=
_CONNECT(self, client, kid, env, extra):</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we ha=
ve here a method for reautch client_event_REAUTH ?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/commen=
t/90c4cfe5_1e9ec2de?usp=3Demail">Patch Set #2, Line 94:</a> <code style=3D"=
font-family:monospace,monospace">            if type(response[key]) =3D=3D =
str:</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">isinstance instead of type() ?</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 2037</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I695967524bb9e83887b8c=
07d0d09baff6e41acf4 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2037 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not =
set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Name of user not set #1000061 </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 17:54:48 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Name of user not set #1000061 </div>

</body></html>
--DqlS9dEs2As=--


--===============5757374336798071941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5757374336798071941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5757374336798071941==--

