Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3CDC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wXHNYQfgvARRw0b4WuStG9ERHnum9RmbMamL7644A8Y=; b=IAWegb1HlPvt79
	3jxYeV0+s1wT+IAY73JP8Kz4lplEeUxd8FVcw2s+z9+ZradNOr68Bzk43v9n4K2otVOuJJNKeho9Z
	uZjsZwwU3tyFFr14h5XiMKP/D0Q+psW+uCUGOgQaGuAtiOjIkNCx3uwbjFpoMju30nP/Egu2s0xxW
	t+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfGHD-0000i7-9l;
	Thu, 02 Jul 2026 12:12:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfGGv-0000hZ-Qb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:11:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3InnBvOUHZsqMHpuhBz9wwiufxDD6xKX9sfxv1Ht6N8=; b=a0hEj5XFE9xX04ZYwnDsbGjznd
 442gutRTfafzEYFRRIoMlf2aMe7YwJvHooUXn/aLc9YymbdzoKe0/xILW6nNIzps/4mBnTzZamWmt
 c0iCbPaPGjoyQhmb2yEx4ddrj2p0yjJKDGYOfdaGOZ/IXs1AlV0O8/tQa3TvkzioSNwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3InnBvOUHZsqMHpuhBz9wwiufxDD6xKX9sfxv1Ht6N8=; b=a
 WZ42tQ+yYHTiuX1eiB7V5xeHFbM7HG5Rz9WxL5CMHJ2BQx0Ri7cxl9gfRETEdQT9UwkYd8Q+Jr+vh
 ajLysqqXRW6kV5TgPI8XpBZF7AFX0cu+t5Xh9o4R19mwsWC70Sc4xCPLVlia5tQf7de3ESqGlRppP
 a3hJkVyGJ9R4YbzU=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfGGl-0005SK-Dd for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:11:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so1172472f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782994300; x=1783599100; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3InnBvOUHZsqMHpuhBz9wwiufxDD6xKX9sfxv1Ht6N8=;
 b=cQgFoiBLNnfJVfR867jPagYEpxL9LVO76kdASdANKvCV4h+0b7R3RMCwWGYL/BNZyw
 808BhMYzUknstOVu/TvxG4hOWZWgR2SW4ntjqIjeGZjFmHYmqQxkrgFsRVIUeT4EmelQ
 QMTADV2unUDVnGGfSsIjr8q+7Gh5W4Up9eubMeslP0yHNDh1Ea539KN955sRFRIh4tej
 2PSgXlonBsFT3FlCq4uh8xoiHcjbVN0vdPWm/X4YHE4ukYRW6NIbMkfvTIQOPdemFbtD
 kvRvu4cCTf1cjzlGnfl2JYMYZ115gTwv9jLa2e7ai53SYFXiycMmTJYqmegU+KiL0+5Q
 tKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782994300; x=1783599100;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3InnBvOUHZsqMHpuhBz9wwiufxDD6xKX9sfxv1Ht6N8=;
 b=gZVc485sbVTp8pOrCCGVuThIjzipQqkVFOtGEIPvgcjWAsGxKkA1Ay9cNIzdH23sxl
 vgYTRQd+SxvCkCaTrsYL57sBMBFjDpQMgJMPxERK4pc84+1yQ0lUDLlKxtauj7jp7VQk
 K8+72NInV7jO53lsQIj63mWS1LkgjtHgAW0gPLEEg7qGZ0BsljJLGMfd/yfSFPIe5R88
 9AfPmQzArCXUjKVE4hnPQbdVgxnl8Rt0gMBsVwGonkbTFGuzlLtPtYJ/NLJDpSR/+jBe
 0JaTHrZ74l1fxKcZq8CBd9B1BIRa6UOJb/xOI3d4Pnk/tUHwUMt8y/vpTMe1xJbJ5cq0
 Se+A==
X-Gm-Message-State: AOJu0YzjxA/6Qo8KumHbBO/le7Ojqm2Ps+9TnvK+RqNkVBgLYayWpRge
 vjW7Ck22uPwGEZRUEdf7VJtHKGgrkR9YpjjbO51s0hpNSfsSji/Hg7rZfNocXxhq7aGkzXnl1fA
 l3PxcFohhT7zg+VMO/gSpyDeaARByWVL/hxVh9o+VMF/v2kPbZ38tCzSgddt7PmbWxg/4AC4I0t
 kmalWXnQ==
X-Gm-Gg: AfdE7cmgUNgDDBzCqUE+aQg0oy/HS1IOKILRkDwaEkpjRmQZBbejnv1qCzNYFz3/YMK
 Q/g+f/0pf89VLgIfWXUvgt6ghzfQpDq/I1csy98DhY/RjOdQu6Iccmhy4lLXr/mn7Wj+5ePBtTL
 tiwzKo5dIK6rDi50KINB25L2wrwzv/ENwOLDoELxOhAv9w+qZKnCI8+VfaBC5FtfM0cICgxJdoZ
 vRWCtgMWk0m7eYxKJbf7ozNfnB/K7/t0HZqy3YXYcZvOnVnbN/Ptp3lH3XbiSqwGRoeevRzxH9I
 gPRfBX+inNLQbGxuMq1lynEAhDoRfIKwvhTueG9xL0KOui2i6b9Y3JVxnYIB9ID3FUFFehNZI9Z
 mCH94eXJQzyynxRk+iRpSNg6raok0ZQa7tIazf5QgnmSdu61gVtpKTJsbkjEJgV2PUAv7o0xTPz
 5DDevpyEFlOuxhhtctQ6jmsYM8F9m7w0K+PPF24X14qba2txVa9xLRAKzCQlsqoB7y96MEHMaYk
 CN8Yt3JVLzUOczU2elGDbdmNxDxLBI+UAxTVPsDG6IrdaCCI6CiMEJIShtP2CeV6zyK1zZt5n/0
 ydc=
X-Received: by 2002:a5d:5588:0:b0:473:1ccc:15bf with SMTP id
 ffacd0b85a97d-477b5488071mr5872746f8f.42.1782994296834; 
 Thu, 02 Jul 2026 05:11:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbc75sm8981803f8f.5.2026.07.02.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:11:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 12:11:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
X-Gerrit-Change-Number: 1767
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1767?usp=email>
X-Gerrit-Commit: ad864a699245649191d347c152193c8e7f59d8b8
References: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTk0MjkzMDAwLkk4ODg3ZmE3Y2NmNDA3ZDcyN2MyYjU5Mzk3MDAwMTQ5ZTQ1NDg3ZTEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <53244a34413f3866d9afb05aadf3b26b23e2f53c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfGGl-0005SK-Dd
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Convert Changes.rst
 to Markdown
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6263506297954399338=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6263506297954399338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R7Q4Skx7Hfc="; charset=UTF-8

--R7Q4Skx7Hfc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1767?usp=3Demail

to review the following change=2E


Chang=
e subject: Convert Changes=2Erst to Markdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Convert Changes=2Erst to Markdown

Since al=
l of our release publishing infrastructure now uses
Markdown (Wiki, Forums,=
 Github), preparing this documentation
in rst just creates more work for th=
e people creating the
release (so often me ;))=2E

This conversion to Markd=
own tries to also fix several instances
of weird formatting=2E But I tried =
to limit myself to not go
too much in the direction of actually "improving"=
 the text=2E

Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
Signed-o=
ff-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
A Changes=2Emd
D Cha=
nges=2Erst
M Makefile=2Eam
3 files changed, 1,423 insertions(+), 1,461 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/67/1767/1

diff --git a/Changes=2Emd b/Changes=2Emd
new file mode 10064=
4
index 0000000=2E=2E7590ac9
--- /dev/null
+++ b/Changes=2Emd
@@ -0,0 +1,14=
22 @@
+# Overview of changes in 2=2E8
+
+# Overview of changes in 2=2E7
+
+=
## New features
+
+**Multi-socket support for servers**
+
+OpenVPN servers =
now can listen on multiple sockets at the same time=2E Multiple
+`--local` =
statements in the configuration can be used to configure this=2E This
+way =
the same server can e=2Eg=2E listen for UDP and TCP connections at the same=

+time, or listen on multiple addresses and/or ports=2E
+
+**Client impleme=
ntations for DNS options sent by server for Linux/BSD/macOS**
+
+Linux, BSD=
 and macOS versions of OpenVPN now ship with a per-platform default
+`--dns=
-updown` script that implements proper handling of DNS configuration sent
+=
by the server=2E The scripts should work on systems that use `systemd` or
+=
`resolveconf` to manage the DNS setup, as well as raw `/etc/resolv=2Econf` =
files=2E
+However, the exact features supported will depend on the configur=
ation method=2E
+On Linux and MacOS this should usually make split-DNS conf=
igurations supported
+out-of-the-box now=2E
+
+Note that this new script wi=
ll not be used by default if a `--up` script is
+already in use to reduce p=
roblems with backwards compatibility=2E
+
+See documentation for `--dns-upd=
own` and `--dns` for more details=2E
+
+**New client implementation for DNS=
 options sent by server for Windows**
+
+The Windows client now uses NRPT (=
Name Resolution Policy Table) to handle DNS
+configurations=2E This adds su=
pport for split-DNS and DNSSEC and improves the
+compatbility with local DN=
S resolvers=2E Requires the interactive service=2E
+
+**On Windows the `blo=
ck-local` flag is now enforced with WFP filters=2E**
+
+The `block-local` f=
lag to `--redirect-gateway` and `--redirect-private` is now
+also enforced =
via the Windows Firewall, making sure packets can't be sent to the
+local n=
etwork=2E This provides stronger protection against TunnelCrack-style
+atta=
cks=2E
+
+**Windows network adapters are now generated on demand**
+
+This =
means that on systems that run multiple OpenVPN connections at the same
+ti=
me the users don't need to manually create enough network adapters anymore =
(in
+addition to the ones created by the installer)=2E
+
+**Windows automat=
ic service now runs as an unpriviledged user**
+
+All tasks that need privi=
leges are now delegated to the interactive service=2E
+**NOTE** this has th=
e risk of breaking existing setups if the Windows
+certificate store is use=
d (cryptoapi), and the certificates are not readable for
+`NT SERVICE\OpenV=
PNService`=2E
+
+**Support for new version of Linux DCO module**
+
+The Ope=
nVPN DCO module has been merged into the Linux kernel as of 6=2E16=2E This
=
+required some API changes and OpenVPN 2=2E7 only supports the new API=2E T=
he new
+module is called `ovpn`=2E Out-of-tree builds for older kernels are=
 available from
+<https://github=2Ecom/OpenVPN/ovpn-backports>=2E Please se=
e the release
+announcements for further information=2E
+
+**Support for se=
rver mode in win-dco driver**
+
+On Windows the win-dco driver can now be u=
sed in server setups=2E
+
+**Support for TLS client floating in DCO impleme=
ntations**
+
+The kernel modules will detect clients floating to a new IP a=
ddress and notify
+userland so both data packets (kernel) and TLS packets (=
sent by userland) can
+reach the new client IP=2E (Actual support depends o=
n recent-enough kernel
+implementation)
+
+**Enforcement of AES-GCM usage l=
imit**
+
+OpenVPN will now enforce the usage limits on AES-GCM with the sam=
e
+confidentiality margin as TLS 1=2E3 does=2E This mean that renegotiation=
 will be
+triggered after roughly 2^28 to 2^31 packets depending of the pac=
ket size=2E More
+details about usage limit of AES-GCM can be found here:
+=

+<https://datatracker=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-limits/>
+
+**=
Epoch data keys and packet format**
+
+This introduces the epoch data forma=
t for AEAD data channel ciphers in TLS mode
+ciphers=2E This new data forma=
t has a number of improvements over the standard
+"DATA_V2" format=2E
+
+- =
AEAD tag at the end of packet which is more hardware implementation friendl=
y
+- Automatic key switchover when cipher usage limits are hit, similar to =
the
+  epoch data keys in (D)TLS 1=2E3
+- 64 bit instead of 32 bit packet i=
ds to allow the data channel to be ready for
+  10 GBit/s without having fr=
equent renegotiation
+- IV constructed with XOR instead of concatenation to=
 not have (parts) of the
+  real IV on the wire
+
+**Support for Epoch data=
 channel on Windows, using the win-dco driver (2=2E8=2E0+)**
+
+**Default c=
iphers in `--data-ciphers`**
+
+Ciphers in `--data-ciphers` can contain the=
 string DEFAULT that is replaced by
+the default ciphers used by OpenVPN, m=
aking it easier to add an allowed cipher
+without having to spell out the d=
efault ciphers=2E
+
+**TLS alerts**
+
+OpenVPN 2=2E7 will send out TLS aler=
ts to peers informing them if the TLS session
+shuts down or when the TLS i=
mplementation informs the peer about an error in the
+TLS session (e=2Eg=2E=
 mismatching TLS versions)=2E This improves the user experience
+as the cli=
ent shows an error instead of running into a timeout when the server
+just =
stops responding completely=2E
+
+**Support for tun/tap via unix domain soc=
ket and lwipovpn support**
+
+To allow better testing and emulating a full =
client with a full network stack
+OpenVPN now allows a program executed to =
provide a tun/tap device instead of
+opening a device=2E
+
+The co-develope=
d lwipovpn program based on lwIP stack allows to simulate full IP
+stack=2E=
 An OpenVPN client using `--dev-node unix:/path/to/lwipovpn` can emulate a
=
+full client that can be pinged, can serve a website and more without requi=
ring
+any elevated permission=2E This can make testing OpenVPN much easier=
=2E
+
+For more details see [lwipovpn on Github](https://github=2Ecom/OpenV=
PN/lwipovpn)=2E
+
+**Allow overriding username with `--override-username`**=

+
+This is intended to allow using `--auth-gen-token` in scenarios where t=
he
+clients use certificates and multi-factor authentication=2E This will a=
lso
+generate a `push "auth-token-user newusername"` directive in push repl=
ies=2E
+
+**`--port-share` now properly supports IPv6**
+
+Issues with logg=
ing of IPv6 addresses were fixed=2E The feature now allows IPv6
+connection=
s towards the proxy receiver=2E
+
+**Support for Haiku OS**
+
+**TLS1=2E3 s=
upport with mbedTLS (requires mbedTLS >=3D 3=2E6=2E4)**
+
+**PUSH_UPDATE cl=
ient support**
+
+It is now possible to update parts of the client-side con=
figuration (IP address,
+routes, MTU, DNS) by sending a new server-to-clien=
t control message,
+`PUSH_UPDATE,<options>`=2E See also:
+<https://openvpn=
=2Egithub=2Eio/openvpn-rfc/openvpn-wire-protocol=2Ehtml>
+
+NOTE: PUSH_UPDA=
TE client support is currently disabled if DCO is active (on all
+platforms=
)=2E
+
+**PUSH_UPDATE server support (minimal)**
+
+New management interfac=
e commands `push-update-broad` and `push-update-cid` to
+send PUSH_UPDATE o=
ption updates to all clients ("there is a new DNS server") or
+only a speci=
fic client ID ("privileges have changed, here's a new IP address")=2E
+
+Se=
e doc/management-notes=2Etxt
+
+NOTE: PUSH_UPDATE server support is current=
ly disabled if DCO is active
+(on all platforms)=2E
+
+**Support for user-d=
efined routing tables on Linux**
+
+See the `--route-table` option in the m=
anpage
+
+**PQE support for WolfSSL**
+
+Two new environment variables have=
 been introduced to communicate desired
+default gateway redirection to plu=
gins like Network Manager,
+`route_redirect_gateway_ipv4` and `route_redire=
ct_gateway_ipv6`=2E See the
+"Environmental Variables" section in the man p=
age
+
+**Improved logging of service events/errors to event log on Windows=
=2E**
+
+**Improved "Recursive Routing" check**
+
+The check is now more gr=
anular, and will only drop
+packets-in-tunnel if destination IP, protocol a=
nd port matches with those needed
+to reach the VPN server=2E With that cha=
nge, you can now use policies that direct
+"everything that is not OpenVPN"=
 into the tunnel, and have IP packets to the VPN
+server address arrive as =
expected (no such policies are currently installed by
+OpenVPN) (GH: OpenVP=
N/openvpn#669)=2E
+
+**COPYING: license details only relevant to our Window=
s installers have
+been updated and moved to the openvpn-build repo**
+
+**=
Improved BYTECOUNT support**
+
+More strictly adhere to timing interval req=
uested, correctly support client and
+server counters with Linux and Window=
s DCO offloading=2E
+
+**Improve compatibility with OpenSSL 3=2E6=2E0 (do n=
ot fail t_lpback selftest)**
+
+**New option `--tls-crypt-v2-max-age n` to =
check tls-crypt-v2 timestamps**
+
+When a client is older than n days or ha=
s no timestamp, the server will reject
+it=2E
+
+**mbedTLS 4 support has be=
en added=2E**
+
+Note that with mbedTLS 4 algorithms need to be translated =
to mbedTLS 4 internal
+IDs by OpenVPN, and some names might be missing=2E
+=

+## Deprecated features
+
+**`secret` support has been removed (by default=
)=2E**
+
+static key mode (non-TLS) is no longer considered "good and secur=
e enough" for
+today's requirements=2E Use TLS mode instead=2E If deploying=
 a PKI CA is considered
+"too complicated", using `--peer-fingerprint` make=
s TLS mode about as easy as
+using `--secret`=2E
+
+This mode can still be =
enabled by using
+`--allow-deprecated-insecure-static-crypto` but will be r=
emoved in OpenVPN 2=2E8=2E
+
+**Support for wintun Windows driver has been =
removed=2E**
+
+OpenVPN 2=2E6 added support for the new dco-win driver, so =
it supported three
+different device drivers: dco-win, wintun, and tap-wind=
ows6=2E OpenVPN 2=2E7 now
+drops the support for wintun driver=2E By defaul=
t all modern configs should be
+supported by dco-win driver=2E In all other=
 cases OpenVPN will fall back
+automatically to tap-windows6 driver=2E
+
+*=
*NTLMv1 authentication support for HTTP proxies has been removed=2E**
+
+Th=
is is considered an insecure method of authentication that uses obsolete
+c=
rypto algorithms=2E NTLMv2 support is still available, but will be removed =
in a
+future release=2E When configured to authenticate with NTLMv1 (`ntlm`=
 keyword in
+`--http-proxy`) OpenVPN will try NTLMv2 instead=2E
+
+**`persi=
st-key` option has been enabled by default=2E**
+
+All the keys will be kep=
t in memory across restart=2E
+
+**OpenSSL 1=2E0=2E2 support has been remov=
ed=2E**
+
+Support for building with OpenSSL 1=2E0=2E2 has been removed=2E =
The minimum supported
+OpenSSL version is now 1=2E1=2E0=2E
+
+**mbedTLS 2=
=2Ex support has been removed**
+
+Support for building with mbedTLS 2=2Ex =
has been removed (it is out of support
+since March 2025, and the necessary=
 compatibility code is making maintenance and
+support for mbedTLS 4=2Ex ha=
rd)=2E The minimum supported mbedTLS version is now
+3=2E2=2E1=2E
+
+**Comp=
ression on send has been removed=2E**
+
+OpenVPN 2=2E7 will never compress =
data before sending=2E Decompression of received
+data is still supported=
=2E `--allow-compression yes` is now an alias for
+`--allow-compression asy=
m`=2E
+
+**`--memstats` feature removed**
+
+The `--memstats` option was la=
rgely undocumented and there is no known user of
+this feature=2E This feat=
ure provided very limited statistics (number of users,
+link bytes read/wri=
tten) and we do not except any usage because of this=2E
+
+Using `--push` i=
n a mode that is not `--mode server` will now print a
+clear warning that t=
his is an unsupported operation and might cause negotiation
+failures=2E
+
=
+`--reneg-bytes` and `--reneg-packets` do not work in DCO mode, and will
+n=
ow print an appropriate warning=2E
+
+On-connect resolving of `--remote` ad=
dresses in `--tcp-server` mode
+was not working since 2=2E4, so the code wa=
s completely removed=2E
+
+## User-visible Changes
+
+- Default for `--topo=
logy` changed to `subnet` for `--mode server`=2E Previous
+  releases alway=
s used `net30` as default=2E This only affects configs with
+  `--mode serv=
er` or `--server` (the latter implies the former), and
+  `--dev tun`, and =
only if IPv4 is enabled=2E Note that this changes the semantics
+  of `--if=
config`, so if you have manual settings for that in your config but
+  not =
set `--topology` your config might fail to parse with the new version=2E
+ =
 Just adding `--topology net30` to the config should fix the problem=2E By
=
+  default `--topology` is pushed from server to client=2E
+- `--x509-usern=
ame-field` will no longer automatically convert fieldnames to
+  uppercase=
=2E This was deprecated since OpenVPN 2=2E4, and has now been removed=2E
+-=
 `--dh none` is now the default if `--dh` is not specified=2E Modern TLS
+ =
 implementations will prefer ECDH and other more modern algorithms anyway=
=2E And
+  finite field Diffie Hellman is in the proces of being deprecated=
 (see
+  draft-ietf-tls-deprecate-obsolete-kex)
+- `--lport 0` does not imp=
ly `--bind` anymore=2E
+- `--redirect-gateway` now works correctly if the V=
PN remote is not reachable by
+  the default gateway=2E
+- `--show-gateway`=
 now supports querying the gateway for IPv4 addresses=2E
+- `--static-chall=
enge` option now has a third parameter `format` that can change
+  how pass=
word and challenge response should be combined=2E
+- `--key` and `--cert` n=
ow accept URIs implemented in OpenSSL 3 as well as
+  optional OpenSSL 3 pr=
oviders loaded using `--providers` option=2E
+- `--cryptoapicert` now suppo=
rts issuer name as well as Windows CA template name
+  or OID as selector s=
tring=2E
+- TLS handshake debugging information contains much more details =
now when using
+  recent versions of OpenSSL=2E
+- The `IV_PLAT_VER` variab=
le sent by Windows clients now contains the full
+  Windows build version t=
o make it possible to determine the Windows 10 or
+  Windows 11 version use=
d=2E
+- The `--windows-driver` option to select between various windows dri=
vers will
+  no longer do anything - it's kept so existing configs will not=
 become invalid,
+  but it is ignored with a warning=2E The default is now =
`ovpn-dco` if all options
+  used are compatible with DCO, with a fallback =
to `tap-windows6`=2E To force TAP
+  (for example because a server pushes D=
CO incompatible options), use the
+  `--disable-dco` option=2E
+- Apply mor=
e checks to incoming TLS handshake packets before creating new
+  state - n=
amely, verify message ID / acked ID for "valid range for an initial
+  pack=
et"=2E This fixes a problem with clients that float very early but send
+  =
control channel packet from the pre-float IP (Github: OpenVPN/openvpn#704)=
=2E
+- Use of `--dh dh2048=2Epem` in all sample configs has been replaced w=
ith
+  `--dh none`=2E The `dh2048=2Epem` file has been removed=2E
+- The st=
artup delay in `t_client=2Esh` has been reduced from 3s to 1s, making a
+  =
noticeable difference for setups with many tests=2E
+- Changed from using `=
uncrustify` for code formatting and pre-commit checks to
+  `clang-format`=
=2E This reformatted quite a bit of code, and requires that
+  regular comm=
itters change their pre-commit checks accordingly=2E
+- On Linux, on interf=
aces where applicable, OpenVPN explicitly configures the
+  broadcast addre=
ss again=2E This was dropped for 2=2E6=2E0 "because computers are
+  smart =
and can do it themselves", but the kernel netlink interface isn't, and
+  w=
ill install "0=2E0=2E0=2E0"=2E This does not normally matter, but for broad=
cast-based
+  applications that get the address to use from "ifconfig", thi=
s change repairs
+  functionality (this has been backported to 2=2E6=2E15, =
but is not in earlier 2=2E6
+  versions)=2E
+- `max-routes-per-client 0` us=
ed to be silently upgraded to `1`=2E This now
+  produces an error=2E
+- `i=
fconfig` and `ifconfig-ipv6` values are now stored in pre-connect options
+=
  cache, and will be restored to pre-connect values on reconnects if the se=
rver
+  stops pushing the respective option=2E
+- `tapctl=2Eexe` helper bin=
ary on Windows has been reworked to improve help texts
+  (making clear tha=
t it can not only do TAP-Adapters but Win-DCO as well), add
+  printing of =
the hwid to all adapter outputs, and change the default adapter
+  type cre=
ated to `ovpn-dco`=2E
+- The default for `multihome` egress interface handl=
ing has changed=2E 2=2E7=2E0 will
+  default to ipi_ifindex=3D0, that is, l=
eave the decision to the routing/policy
+  setup of the operating system=2E=
 The pre-2=2E7 behaviour (force egress =3D ingress
+  interface) can be ach=
ieved with the new `--multihome same-interface`
+  sub-option=2E
+- Windows=
 `openvpn=2Eexe` binary manifest now sets code page UTF8 - which has no
+  =
direct effect on OpenVPN itself, but this repairs OpenSSL file loading for
=
+  key/cert files with non-ASCII characters in their file names (GH:
+  Ope=
nVPN/openvpn#920)=2E
+- The `test-crypto` option no longer requires a `--se=
cret` argument and will
+  automatically generate a random key=2E
+- The co=
nfigure-time option `--enable-x509-alt-username` is no longer
+  conditiona=
l, and always-on (GH: OpenVPN/openvpn#917)=2E
+
+## Deprecated features
+
+=
**`--opt-verify` feature removed**
+
+This option was already deprecated an=
d it is now being converted to a no-op=2E
+Using this option will only prin=
t a warning=2E
+
+# Overview of changes in 2=2E6
+
+## Project changes
+
+W=
e want to deprecate our old Trac bug tracking system=2E Please report any i=
ssues
+with this release in GitHub instead: <https://github=2Ecom/OpenVPN/o=
penvpn/issues>
+
+## New features
+
+**Support unlimited number of connecti=
on entries and remote entries**
+
+**New management commands to enumerate a=
nd list remote entries**
+
+Use `remote-entry-count` and `remote-entry-get`=
 commands from the management
+interface to get the number of remote entrie=
s and the entries themselves=2E
+
+**Keying Material Exporters (RFC 5705) b=
ased key generation**
+
+As part of the cipher negotiation OpenVPN will aut=
omatically prefer the RFC5705
+based key material generation to the current=
 custom OpenVPN PRF=2E This feature
+requires OpenSSL or mbed TLS 2=2E18+=
=2E
+
+**Compatibility with OpenSSL in FIPS mode**
+
+OpenVPN will now work=
 with OpenSSL in FIPS mode=2E Note, no effort has been made
+to check or im=
plement all the requirements/recommendation of FIPS 140-2=2E This
+just all=
ows OpenVPN to be run on a system that be configured OpenSSL in FIPS
+mode=
=2E
+
+`mlock` will now check if enough memlock-able memory has been reserv=
ed,
+and if less than 100MB RAM are available, use setrlimit() to upgrade t=
he limit=2E
+See Trac #1390=2E Not available on OpenSolaris=2E
+
+**Certifi=
cate pinning/verify peer fingerprint**
+
+The `--peer-fingerprint` option h=
as been introduced to give users an easy to use
+alternative to the `tls-ve=
rify` for matching the fingerprint of the peer=2E The
+option takes use a n=
umber of allowed SHA256 certificate fingerprints=2E
+
+See the man page sec=
tion "Small OpenVPN setup with peer-fingerprint" for a
+tutorial on how to =
use this feature=2E This is also available online under
+<https://github=2E=
com/openvpn/openvpn/blob/master/doc/man-sections/example-fingerprint=2Erst>=

+
+**TLS mode with self-signed certificates**
+
+When `--peer-fingerprint`=
 is used, the `--ca` and `--capath` option become
+optional=2E This allows =
for small OpenVPN setups without setting up a PKI with
+Easy-RSA or similar=
 software=2E
+
+**Deferred auth support for scripts**
+
+The `--auth-user-p=
ass-verify` script supports now deferred authentication=2E
+
+**Pending aut=
h support for plugins and scripts**
+
+Both auth plugin and script can now =
signal pending authentication to the client
+when using deferred authentica=
tion=2E The new `client-crresponse` script option
+and `OPENVPN_PLUGIN_CLIE=
NT_CRRESPONSE` plugin function can be used to parse a
+client response to a=
 `CR_TEXT` two factor challenge=2E
+
+See `sample/sample-scripts/totpauth=
=2Epy` for an example=2E
+
+**Compatibility mode (`--compat-mode`)**
+
+The=
 modernisation of defaults can impact the compatibility of OpenVPN 2=2E6=2E=
0 with
+older peers=2E The options `--compat-mode` allows UIs to provide us=
ers with an
+easy way to still connect to older servers=2E
+
+**OpenSSL 3=
=2E0 support**
+
+OpenSSL 3=2E0 has been added=2E Most of OpenSSL 3=2E0 cha=
nges are not user visible but
+improve general compatibility with OpenSSL 3=
=2E0=2E `--tls-cert-profile insecure`
+has been added to allow selecting th=
e lowest OpenSSL security level (not
+recommended, use only if you must)=2E=
 OpenSSL 3=2E0 no longer supports the Blowfish
+(and other deprecated) algo=
rithm by default and the new option `--providers`
+allows loading the legac=
y provider to renable these algorithms=2E
+
+**Optional ciphers in `--data-=
ciphers`**
+
+Ciphers in `--data-ciphers` can now be prefixed with a `?` to=
 mark those as
+optional and only use them if the SSL library supports them=
=2E
+
+**Improved `--mssfix` and `--fragment` calculation**
+
+The `--mssfi=
x` and `--fragment` options now allow an optional `mtu` parameter to
+speci=
fy that different overhead for IPv4/IPv6 should taken into account and the
=
+resulting size is specified as the total size of the VPN packets including=
 IP
+and UDP headers=2E
+
+**Cookie based handshake for UDP server**
+
+Ins=
tead of allocating a connection for each client on the initial packet OpenV=
PN
+server will now use an HMAC based cookie as its session id=2E This way =
the server
+can verify it on completing the handshake without keeping state=
=2E This eliminates
+the amplification and resource exhaustion attacks=2E F=
or tls-crypt-v2 clients,
+this requires OpenVPN 2=2E6 clients or later beca=
use the client needs to resend
+its client key on completing the hand shake=
=2E The tls-crypt-v2 option allows
+controlling if older clients are accept=
ed=2E
+
+By default the rate of initial packet responses is limited to 100 =
per 10s
+interval to avoid OpenVPN servers being abused in reflection attac=
ks (see
+`--connect-freq-initial`)=2E
+
+**Data channel offloading with ovp=
n-dco**
+
+2=2E6=2E0+ implements support for data-channel offloading where =
the data packets are
+directly processed and forwarded in kernel space than=
ks to the ovpn-dco kernel
+module=2E The userspace openvpn program acts pur=
ely as a control plane
+application=2E Note that DCO will use DATA_V2 packe=
ts in P2P mode, therefore, this
+implies that peers must be running 2=2E6=
=2E0+ in order to have P2P-NCP which brings
+DATA_V2 packet support=2E
+
+*=
*Session timeout**
+
+It is now possible to terminate a session (or all) af=
ter a specified amount of
+seconds has passed session commencement=2E This =
behaviour can be configured using
+`--session-timeout`=2E This option can b=
e configured on the server, on the client
+or can also be pushed=2E
+
+**In=
line auth username and password**
+
+Username and password can now be speci=
fied inline in the configuration file
+within the `<auth-user-pass></auth-u=
ser-pass>` tags=2E If the password is
+missing OpenVPN will prompt for inpu=
t via stdin=2E This applies to inline'd
+http-proxy-user-pass too=2E
+
+**T=
un MTU can be pushed**
+
+The client can now also dynamically configure its=
 MTU and the server will try to
+push the client MTU when the client suppor=
ts it=2E The directive `--tun-mtu-max`
+has been introduced to increase the=
 maximum pushable MTU size (defaults to
+1600)=2E
+
+**Dynamic TLS Crypt**
=
+
+When both peers are OpenVPN 2=2E6=2E1+, OpenVPN will dynamically create =
a tls-crypt
+key that is used for renegotiation=2E This ensure that only th=
e previously
+authenticated peer can do trigger renegotiation and complete =
renegotiations=2E
+
+**Improved control channel packet size control (`max-p=
acket-size`)**
+
+The size of control channel is no longer tied to `--link-=
mtu`/`--tun-mtu` and
+can be set using `--max-packet-size`=2E Sending large=
 control channel frames is
+also optimised by allowing 6 outstanding packet=
s instead of just 4=2E
+`max-packet-size` will also set `mssfix` to try to =
limit data-channel packets as
+well=2E
+
+## Deprecated features
+
+**`inet=
d` has been removed**
+
+This was a very limited and not-well-tested way to=
 run OpenVPN, on TCP and TAP
+mode only=2E
+
+**`verify-hash` has been depr=
ecated**
+
+This option has very limited usefulness and should be replaced =
by either a
+better `--ca` configuration or with a `--tls-verify` script=2E=

+
+**`secret` has been deprecated**
+
+static key mode (non-TLS) is no lon=
ger considered "good and secure enough" for
+today's requirements=2E Use TL=
S mode instead=2E If deploying a PKI CA is considered
+"too complicated", u=
sing `--peer-fingerprint` makes TLS mode about as easy as
+using `--secret`=
=2E
+
+**`ncp-disable` has been removed**
+
+This option mainly served a ro=
le as debug option when NCP was first introduced=2E
+It should now no longe=
r be necessary=2E
+
+**TLS 1=2E0 and 1=2E1 are deprecated**
+
+`tls-version=
-min` is set to 1=2E2 by default=2E OpenVPN 2=2E6=2E0 defaults to a minimum=

+TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be generally avoided=
=2E Note that
+OpenVPN versions older than 2=2E3=2E7 use TLS 1=2E0 only=2E
=
+
+**`--cipher` argument is no longer appended to `--data-ciphers`**
+
+by =
default=2E Data cipher negotiation has been introduced in 2=2E4=2E0 and bee=
n
+significantly improved in 2=2E5=2E0=2E The implicit fallback to the ciph=
er specified
+in `--cipher` has been removed=2E Effectively, `--cipher` is =
a no-op in TLS mode
+now, and will only have an effect in pre-shared-key mo=
de (`--secret`)=2E From now
+on `--cipher` should not be used in new config=
urations for TLS mode=2E Should
+backwards compatibility with older OpenVPN=
 peers be required, please see the
+`--compat-mode` instead=2E
+
+**`--prng=
` has beeen removed**
+
+OpenVPN used to implement its own PRNG based on a =
hash=2E However implementing a
+PRNG is better left to a crypto library=2E =
So we use the PRNG mbed TLS or OpenSSL
+now=2E
+
+**`--keysize` has been re=
moved**
+
+The `--keysize` option was only useful to change the key length =
when using the
+BF, CAST6 or RC2 ciphers=2E For all other ciphers the key s=
ize is fixed with the
+chosen cipher=2E As OpenVPN v2=2E6 no longer support=
s any of these variable length
+ciphers, this option was removed as well to=
 avoid confusion=2E
+
+**Compression no longer enabled by default**
+
+Unle=
ss an explicit compression option is specified in the configuration,
+`--al=
low-compression` defaults to `no` in OpeNVPN 2=2E6=2E0=2E By default, OpenV=
PN 2=2E5
+still allowed a server to enable compression by pushing compressi=
on related
+options=2E
+
+**PF (Packet Filtering) support has been removed*=
*
+
+The built-in PF functionality has been removed from the code base=2E T=
his feature
+wasn't really easy to use and was long unmaintained=2E This im=
plies that also
+`--management-client-pf` and any other compile time or run=
 time related option
+do not exist any longer=2E
+
+**Option conflict check=
ing is being deprecated and phased out**
+
+The static option checking (OCC=
) is no longer useful in typical setups that
+negotiate most connection par=
ameters=2E The `--opt-verify` and `--occ-disable`
+options are deprecated, =
and the configure option `--enable-strict-options` has
+been removed=2E Log=
ging of mismatched options has been moved to debug logging
+(verb 7)=2E
+
+=
## User-visible Changes
+
+- CHACHA20-POLY1305 is included in the default o=
f `--data-ciphers` when
+  available=2E
+- Option `--prng` is ignored as we=
 rely on the SSL library random number
+  generator=2E
+- Option `--nobind`=
 is default when `--client` or `--pull` is used in the
+  configuration
+- =
`link_mtu` parameter is removed from environment or replaced with 0 when
+ =
 scripts are called with parameters=2E This parameter is unreliable and no =
longer
+  internally calculated=2E
+- control channel packet maximum size i=
s no longer influenced by
+  `--link-mtu`/`--tun-mtu` and must be set by `-=
-max-packet-size` now=2E The
+  default is 1250 for the control channel siz=
e=2E
+- In point-to-point OpenVPN setups (no `--server`), using `--explict-=
exit-notiy`
+  on one end would terminate the other side at session end=2E =
This is considered a
+  no longer useful default and has been changed to "r=
estart on reception of
+  explicit-exit-notify message"=2E If the old behav=
iour is still desired,
+  `--remap-usr1 SIGTERM` can be used=2E
+- FreeBSD =
tun interfaces with `--topology subnet` are now put into real subnet
+  mod=
e (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might upset software
+ =
 that enumerates interfaces, looking for "broadcast capable?" and expecting=

+  certain results=2E Normal uses should not see any difference=2E
+- The =
default configurations will no longer allow connections to OpenVPN 2=2E3=2E=
x
+  peer or earlier, use the new `--compat-mode` option if you need compat=
ibility
+  with older versions=2E See the manual page on the `--compat-mode=
` for details=2E
+- The `client-pending-auth` management command now requir=
es also the key id=2E The
+  management version has been changed to 5 to in=
dicate this change=2E
+- (OpenVPN 2=2E6=2E2) A client will now refuse a con=
nection if pushed compression
+  settings will contradict the setting of al=
low-compression as this almost
+  always results in a non-working connectio=
n=2E
+- The "kill" by addr management command now requires also the protoco=
l as string
+  e=2Eg=2E "udp", "tcp"=2E
+
+## Common errors with OpenSSL 3=
=2E0 and OpenVPN 2=2E6
+
+Both OpenVPN 2=2E6 and OpenSSL 3=2E0 tighten the =
security considerable, so some
+configuration will no longer work=2E This s=
ection will cover the most common
+causes and error message we have seen an=
d explain their reason and temporary
+workarounds=2E You should fix the und=
erlying problems as soon as possible since
+these workaround are not secure=
 and will eventually stop working in a future
+update=2E
+
+- weak SHA1 or =
MD5 signature on certificates
+
+  This will happen on either loading of ce=
rtificates or on connection to a
+  server:
+
+      OpenSSL: error:0A00018=
E:SSL routines::ca md too weak
+      Cannot load certificate file cert=2Ec=
rt
+      Exiting due to fatal error
+
+  OpenSSL 3=2E0 no longer allows we=
ak signatures on certificates=2E You can
+  downgrade your security to allo=
w them by using `--tls-cert-profile insecure`
+  but should replace/regener=
ate these certificates as soon as possible=2E
+
+- 1024 bit RSA certificate=
s, 1024 bit DH parameters, other weak keys
+
+  This happens if you use pri=
vate keys or other cryptographic material that does
+  not meet today's cry=
ptographic standards anymore=2E Messages are similar to:
+
+      OpenSSL: =
error:0A00018F:SSL routines::ee key too small
+      OpenSSL: error:1408518=
A:SSL routines:ssl3_ctx_ctrl:dh key too small
+
+  DH parameters (`--dh`) c=
an be regenerated with `openssl dhparam 2048`=2E For
+  other cryptographic=
 keys, these keys and certificates need to be regenerated=2E
+  TLS Securit=
y level can be temporarily lowered with `--tls-cert-profile legacy`
+  or e=
ven `--tls-cert-profile insecure`=2E
+
+- Connecting to a OpenVPN 2=2E3=2Ex=
 server or allowing OpenVPN 2=2E3=2Ex or earlier
+  clients
+
+  This will =
normally result in messages like:
+
+      OPTIONS ERROR: failed to negotia=
te cipher with server=2E Add the server's cipher ('AES-128-CBC') to --data-=
ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') if you want=
 to connect to this server=2E
+
+  or
+
+      client/127=2E0=2E0=2E1:49954=
 SENT CONTROL [client]: 'AUTH_FAILED,Data channel cipher negotiation failed=
 (no shared cipher)' (status=3D1)
+
+  You can manually add the missing cip=
her to the `--data-ciphers`=2E The standard
+  ciphers should be included a=
s well, e=2Eg=2E
+  `--data-ciphers AES-256-GCM:AES-128-GCM:?Chacha20-Poly1=
305:?AES-128-CBC`=2E You
+  can also use the `--compat-mode` option=2E Note=
 that these message may also
+  indicate other cipher configuration problem=
s=2E See the data channel cipher
+  negotiation manual section for more det=
ails=2E (Available online under
+  <https://github=2Ecom/OpenVPN/openvpn/bl=
ob/master/doc/man-sections/cipher-negotiation=2Erst>)
+
+- Use of a legacy =
or deprecated cipher (e=2Eg=2E 64bit block ciphers)
+
+  OpenSSL 3=2E0 no l=
onger supports a number of insecure and outdated ciphers in
+  its default =
configuration=2E Some of these ciphers are known to be vulnerable
+  (SWEET=
32 attack)=2E
+
+  This will typically manifest itself in messages like:
+
=
+      OpenSSL: error:0308010C:digital envelope routines::unsupported
+    =
  Cipher algorithm 'BF-CBC' not found
+      Unsupported cipher in --data-c=
iphers: BF-CBC
+
+  If your OpenSSL distribution comes with the legacy prov=
ider (see also
+  `man OSSL_PROVIDER-legacy`), you can load it with
+  `--p=
roviders legacy default`=2E This will re-enable the old algorithms=2E
+
+- =
OpenVPN version not supporting TLS 1=2E2 or later
+
+  The default in OpenV=
PN 2=2E6 and also in many distributions is now TLS 1=2E2 or
+  later=2E Con=
necting to a peer that does not support this will results in
+  messages li=
ke:
+
+      TLS error: Unsupported protocol=2E
+
+  This typically indicat=
es that client and server have no common TLS version
+  enabled=2E This can=
 be caused by mismatched tls-version-min and tls-version-max
+  options on =
client and server=2E If your OpenVPN client is between v2=2E3=2E6 and
+  v2=
=2E3=2E2 try adding `tls-version-min 1=2E0` to the client configuration to =
use
+  TLS 1=2E0+ instead of TLS 1=2E0 only=2E
+
+      OpenSSL: error:0A00=
0102:SSL routines::unsupported protocol
+
+  This can be an OpenVPN 2=2E3=
=2E6 or earlier version=2E `compat-version 2=2E3=2E0` will
+  enable TLS 1=
=2E0 support if supported by the OpenSSL distribution=2E Note that on
+  so=
me Linux distributions enabling TLS 1=2E1 or 1=2E0 is not possible=2E
+
+# =
Overview of changes in 2=2E5
+
+## New features
+
+**Client-specific tls-cr=
ypt keys (`--tls-crypt-v2`)**
+
+`tls-crypt-v2` adds the ability to supply =
each client with a unique tls-crypt
+key=2E This allows large organisations=
 and VPN providers to profit from the same
+DoS and TLS stack protection th=
at small deployments can already achieve using
+`tls-auth` or `tls-crypt`=
=2E
+
+**ChaCha20-Poly1305 cipher support**
+
+Added support for using the =
ChaCha20-Poly1305 cipher in the OpenVPN data
+channel=2E
+
+**Improved Data=
 channel cipher negotiation**
+
+The option `ncp-ciphers` has been renamed =
to `data-ciphers`=2E The old name is
+still accepted=2E The change in name =
signals that `data-ciphers` is the preferred
+way to configure data channel=
 ciphers and the data prefix is chosen to avoid the
+ambiguity that exists =
with `--cipher` for the data cipher and `tls-cipher` for
+the TLS ciphers=
=2E
+
+OpenVPN clients will now signal all supported ciphers from the `data=
-ciphers`
+option to the server via `IV_CIPHERS`=2E OpenVPN servers will se=
lect the first
+common cipher from the `data-ciphers` list instead of blind=
ly pushing the first
+cipher of the list=2E This allows to use a configurat=
ion like
+`data-ciphers ChaCha20-Poly1305:AES-256-GCM` on the server that p=
refers
+ChaCha20-Poly1305 but uses it only if the client supports it=2E
+
+=
See the data channel negotiation section in the manual for more details=2E
=
+
+**Removal of BF-CBC support in default configuration:**
+
+By default Op=
enVPN 2=2E5 will only accept AES-256-GCM and AES-128-GCM as data
+ciphers=
=2E OpenVPN 2=2E4 allows AES-256-GCM,AES-128-GCM and BF-CBC when no --ciphe=
r
+and --ncp-ciphers options are present=2E Accepting BF-CBC can be enabled=
 by adding
+
+> data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC
+
+and when you=
 need to support very old peers also
+
+> data-ciphers-fallback BF-CBC
+
+T=
o offer backwards compatibility with older configs an *explicit*
+
+> ciphe=
r BF-CBC
+
+in the configuration will be automatically translated into addi=
ng BF-CBC to the
+data-ciphers option and setting data-ciphers-fallback to =
BF-CBC (as in the
+example commands above)=2E We strongly recommend to swit=
ching away from BF-CBC to
+a more secure cipher=2E
+
+**Asynchronous (defer=
red) authentication support for auth-pam plugin=2E**
+
+See src/plugins/aut=
h-pam/README=2Eauth-pam for details=2E
+
+**Deferred client-connect**
+
+Th=
e `--client-connect` option and the connect plugin API allow
+asynchronous/=
deferred return of the configuration file in the same way as the
+auth-plug=
in=2E
+
+**Faster connection setup**
+
+A client will signal in the `IV_PRO=
TO` variable that it is in pull mode=2E This
+allows the server to push the=
 configuration options to the client without
+waiting for a `PULL_REQUEST` =
message=2E The feature is automatically enabled if
+both client and server =
support it and significantly reduces the connection setup
+time by avoiding=
 one extra packet round-trip and 1s of internal event delays=2E
+
+**Netlin=
k support**
+
+On Linux, if configured without `--enable-iproute2`, configu=
ring IP addresses
+and adding/removing routes is now done via the netlink(3=
) kernel interface=2E This
+is much faster than calling `ifconfig` or `rout=
e` and also enables OpenVPN to
+run with less privileges=2E
+
+If configure=
d with --enable-iproute2, the `ip` command is used (as in 2=2E4)=2E
+Suppor=
t for `ifconfig` and `route` is gone=2E
+
+**Wintun support**
+
+On Windows=
, OpenVPN can now use `wintun` devices=2E They are faster than the
+traditi=
onal `tap9` tun/tap devices, but do not provide `--dev tap` mode - so the
+=
official installers contain both=2E To use a wintun device, add
+`--windows=
-driver wintun` to your config (and use of the interactive service is
+requ=
ired as wintun needs SYSTEM privileges to enable access)=2E
+
+**IPv6-only =
operation**
+
+It is now possible to have only IPv6 addresses inside the VP=
N tunnel, and
+IPv6-only address pools (2=2E4 always required IPv4 config/p=
ools and IPv6 was the
+"optional extra")=2E
+
+**Improved Windows 10 detect=
ion**
+
+Correctly log OS on Windows 10 now=2E
+
+**Linux VRF support**
+
+=
Using the new `--bind-dev` option, the OpenVPN outside socket can now be pu=
t
+into a Linux VRF=2E See the "Virtual Routing and Forwarding" documentati=
on in the
+man page=2E
+
+**TLS 1=2E3 support**
+
+TLS 1=2E3 support has be=
en added to OpenVPN=2E Currently, this requires OpenSSL
+1=2E1=2E1+=2E The =
options `--tls-ciphersuites` and `--tls-groups` have been added to
+fine tu=
ne TLS protocol options=2E Most of the improvements were also backported to=

+OpenVPN 2=2E4 as part of the maintainance releases=2E
+
+**Support settin=
g DHCP search domain**
+
+A new option `--dhcp-option DOMAIN-SEARCH my=2Eex=
ample=2Ecom` has been defined, and
+Windows support for it is implemented (=
tun/tap only, no wintun support yet)=2E
+Other platforms need to support th=
is via `--up` script (Linux) or GUI
+(OSX/Tunnelblick)=2E
+
+**per-client c=
hanging of `--data-ciphers` or `data-ciphers-fallback`**
+
+from client-con=
nect script/dir (NOTE: this only changes preference of ciphers
+for NCP, bu=
t can not override what the client announces as "willing to accept")
+
+**H=
andle setting of tun/tap interface MTU on Windows**
+
+If IPv6 is in use, M=
TU must be >=3D 1280 (Windows enforces IETF requirements)
+
+**Add support =
for OpenSSL engines to access private key material (like TPM)=2E**
+
+**HMA=
C based auth-token support**
+
+The `--auth-gen-token` support has been imp=
roved and now generates HMAC based
+user token=2E If the optional `--auth-g=
en-token-secret` option is used clients
+will be able to seamlessly reconne=
ct to a different server using the same secret
+file or to the same server =
after a server restart=2E
+
+**Improved support for pending authentication*=
*
+
+The protocol has been enhanced to be able to signal that the authentic=
ation
+should use a secondary authentication via web (like SAML) or a two f=
actor
+authentication without disconnecting the OpenVPN session with AUTH_F=
AILED=2E The
+session will instead be stay in a authenticated state and wai=
t for the second
+factor authentication to complete=2E
+
+This feature curr=
ently requires usage of the managent interface on both client
+and server s=
ide=2E See the `management-notes=2Etxt` `client-pending-auth` and
+`cr-resp=
onse` commands for more details=2E
+
+**VLAN support**
+
+OpenVPN servers i=
n TAP mode can now use 802=2E1q tagged VLANs on the TAP interface
+to separ=
ate clients into different groups that can then be handled differently
+(di=
fferent subnets / DHCP, firewall zones, =2E=2E=2E) further down the network=
=2E See
+the new options `--vlan-tagging`, `--vlan-accept`, `--vlan-pvid`=
=2E
+
+802=2E1q tagging on the client side TAP interface is not handled tod=
ay (=3D tags are
+just forwarded transparently to the server)=2E
+
+**Suppo=
rt building of =2Emsi installers for Windows**
+
+**Allow unicode search st=
ring in `--cryptoapicert` option (Windows)**
+
+**Support IPv4 configs with=
 /31 netmasks now**
+
+(By no longer trying to configure `broadcast x=2Ex=
=2Ex=2Ex` in ifconfig calls, /31
+support "just works")
+
+**New option `--=
block-ipv6` to reject all IPv6 packets (ICMPv6)**
+
+This is useful if the =
VPN service has no IPv6, but the clients might have (LAN),
+to avoid client=
 connections to IPv6-enabled servers leaking "around" the
+IPv4-only VPN=2E=

+
+`--ifconfig-ipv6` and `--ifconfig-ipv6-push` will now accept hostnames =
and do
+a DNS lookup to get the IPv6 address to use=2E
+
+## Deprecated fea=
tures
+
+For an up-to-date list of all deprecated options, see this wiki pa=
ge:
+<https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOptions>
+
+=
- `ncp-disable` has been deprecated=2E
+
+  With the improved and matured d=
ata channel cipher negotiation, the use of
+  `ncp-disable` should not be n=
ecessary anymore=2E
+
+- `inetd` has been deprecated=2E
+
+  This is a very=
 limited and not-well-tested way to
+  run OpenVPN, on TCP and TAP mode onl=
y, which complicates the code quite a bit
+  for little gain=2E To be remov=
ed in OpenVPN 2=2E6 (unless users protest)=2E
+
+- `no-iv` has been removed=
=2E
+
+  This option was made into a NOOP option with OpenVPN
+  2=2E4=2E T=
his has now been completely removed=2E
+
+- `--client-cert-not-required` ha=
s been removed
+
+  This option will now cause server configurations to not=
 start=2E
+  Use `--verify-client-cert none` instead=2E
+
+- `--ifconfig-po=
ol-linear` has been removed=2E
+
+  This option is removed=2E Use `--topolo=
gy p2p` or `--topology subnet` instead=2E
+
+- `--compress xxx` is consider=
ed risky and is warned against, see below=2E
+
+- `--key-method 1` has been=
 removed
+
+## User-visible Changes
+
+- If multiple connect handlers are u=
sed (client-connect, ccd, connect plugin)
+  and one of the handler succeed=
s but a subsequent fails, the
+  client-disconnect-script is now called imm=
ediately=2E Previously it was called,
+  when the VPN session was terminate=
d=2E
+- Support for building with OpenSSL 1=2E0=2E1 has been removed=2E The=
 minimum
+  supported OpenSSL version is now 1=2E0=2E2=2E
+- The GET_CONFIG=
 management state is omitted if the server pushes the client
+  configurati=
on almost immediately as result of the faster connection setup
+  feature=
=2E
+- `--compress` is nowadays considered risky, because attacks exist lev=
eraging
+  compression-inside-crypto to reveal plaintext (VORACLE)=2E So by=
 default,
+  `--compress xxx` will now accept incoming compressed packets (=
for
+  compatibility with peers that have not been upgraded yet), but will =
not use
+  compression outgoing packets=2E This can be controlled with the =
new option
+  `--allow-compression yes|no|asym`=2E
+- Stop changing `--txle=
n` aways from OS defaults unless explicitly specified in
+  config file=2E =
OS defaults nowadays are actually larger then what we used to
+  configure,=
 so our defaults sometimes caused packet drops =3D bad performance=2E
+- re=
move `--writepid` pid file on exit now
+- plugin-auth-pam now logs via Open=
VPN logging method, no longer to stderr (this
+  means you'll have log mess=
ages in syslog or openvpn log file now)
+- use ISO 8601 time format for fil=
e based logging now (YYYY-MM-DD hh:mm:dd)
+  (syslog is not affected, nor i=
s `--machine-readable-output`)
+- `--clr-verify` now loads all CRLs if more=
 than one CRL is in the same file
+  (OpenSSL backend only, mbedTLS always =
did that)
+- when `--auth-user-pass file` has no password, and the manageme=
nt interface is
+  active, query management interface (instead of trying co=
nsole query, which
+  does not work on windows)
+- skip expired certificate=
s in Windows certificate store (`--cryptoapicert`)
+- `--socks-proxy` + `--=
proto udp*` will now allways use IPv4, even if IPv6 is
+  requested and ava=
ilable=2E Our SOCKS code does not handle IPv6+UDP, and before
+  that chang=
e it would just fail in non-obvious ways=2E
+- TCP listen() backlog queue i=
s now set to 32 - this helps TCP servers that
+  receive lots of "invalid" =
connects by TCP port scanners
+- do no longer print OCC warnings ("option m=
ismatch") about `key-method`,
+  `keydir`, `tls-auth` and `cipher` - these =
are either gone now, or negotiated,
+  and the warnings do not serve a usef=
ul purpose=2E
+- `dhcp-option DNS` and `dhcp-option DNS6` are now treated i=
dentically (=3D both
+  accept an IPv4 or IPv6 address for the nameserver)
=
+
+## Maintainer-visible changes
+
+- the man page is now in maintained in =
=2Erst format, so building the openvpn=2E8
+  manpage from a git checkout n=
ow requires python-docutils (if this is missing,
+  the manpage will not be=
 built - which is not considered an error generally,
+  but for package bui=
lders or `make distcheck` it is)=2E Release tarballs contain
+  the openvpn=
=2E8 file, so unless some =2Erst is changed, doc-utils are not needed
+  fo=
r building=2E
+- OCC support can no longer be disabled
+- AEAD support is n=
ow required in the crypto library
+- `--disable-server` has been removed fr=
om configure (so it is no longer
+  possible to build a client-/p2p-only Op=
enVPN binary) - the saving in code size
+  no longer outweighs the extra ma=
intenance effort=2E
+- `--enable-iproute2` will disable netlink(3) support,=
 so maybe remove that from
+  package building configs (see above)
+- suppo=
rt building with MSVC 2019
+- cmocka based unit tests are now only run if c=
mocka is installed externally
+  (2=2E4 used to ship a local git submodule =
which was painful to maintain)
+- `--disable-crypto` configure option has b=
een removed=2E OpenVPN is now always
+  built with crypto support, which ma=
kes the code much easier to maintain=2E This
+  does not affect `--cipher n=
one` to do a tunnel without encryption=2E
+- `--disable-multi` configure op=
tion has been removed
+
+# Overview of changes in 2=2E4
+
+## New features
=
+
+**Seamless client IP/port floating**
+
+Added new packet format P_DATA_V=
2, which includes peer-id=2E If both the server
+and client support it, the=
 client sends all data packets in the new format=2E When
+a data packet arr=
ives, the server identifies peer by peer-id=2E If peer's ip/port
+has chang=
ed, server assumes that client has floated, verifies HMAC and updates
+ip/p=
ort in internal structs=2E This allows the connection to be immediately
+re=
stored, instead of requiring a TLS handshake before the server accepts pack=
ets
+from the new client ip/port=2E
+
+**Data channel cipher negotiation**
=
+
+Data channel ciphers (`--cipher`) are now by default negotiated=2E If a =
client
+advertises support for Negotiable Crypto Parameters (NCP), the serv=
er will
+choose a cipher (by default AES-256-GCM) for the data channel, and=
 tell the
+client to use that cipher=2E Data channel cipher negotiation can=
 be controlled
+using `--ncp-ciphers` and `--ncp-disable`=2E
+
+A more limi=
ted version also works in client-to-server and server-to-client
+scenarios =
where one of the end points uses a v2=2E4 client or server and the other
+s=
ide uses an older version=2E In such scenarios the v2=2E4 side will change =
to the
+`--cipher` set by the remote side, if permitted by by `--ncp-cipher=
s`=2E For
+example, a v2=2E4 client with `--cipher BF-CBC` and
+`ncp-cipher=
s AES-256-GCM:AES-256-CBC` can connect to both a v2=2E3 server with
+`ciphe=
r BF-CBC` as well as a server with `cipher AES-256-CBC` in its config=2E Th=
e
+other way around, a v2=2E3 client with either `cipher BF-CBC` or
+`ciphe=
r AES-256-CBC` can connect to a v2=2E4 server with e=2Eg=2E `cipher BF-CBC`=
 and
+`ncp-ciphers AES-256-GCM:AES-256-CBC` in its config=2E For this to wo=
rk it
+requires that OpenVPN was built without disabling OCC support=2E
+
+=
**AEAD (GCM) data channel cipher support**
+
+The data channel now supports=
 AEAD ciphers (currently only GCM)=2E The AEAD packet
+format has a smaller=
 crypto overhead than the CBC packet format, (e=2Eg=2E 20 bytes
+per packet=
 for AES-128-GCM instead of 36 bytes per packet for AES-128-CBC +
+HMAC-SHA=
1)=2E
+
+**ECDH key exchange**
+
+The TLS control channel now supports for =
elliptic curve diffie-hellmann key
+exchange (ECDH)=2E
+
+**Improved Certif=
icate Revocation List (CRL) processing**
+
+CRLs are now handled by the cry=
pto library (OpenSSL or mbed TLS), instead of
+inside OpenVPN itself=2E The=
 crypto library implementations are more strict than
+the OpenVPN implement=
ation was=2E This might reject peer certificates that would
+previously be =
accepted=2E If this occurs, OpenVPN will log the crypto library's
+error de=
scription=2E
+
+**Dualstack round-robin DNS client connect**
+
+Instead of =
only using the first address of each `--remote` OpenVPN will now try
+all a=
ddresses (IPv6 and IPv4) of a `--remote` entry=2E
+
+**Support for providin=
g IPv6 DNS servers**
+
+A new DHCP sub-option `DNS6` is added alongside wit=
h the already existing `DNS`
+sub-option=2E This is used to provide DNS res=
olvers available over IPv6=2E This may
+be pushed to clients where `--up` s=
cripts and `--plugin` can act upon it through
+the `foreign_option_<n>` env=
ironment variables=2E
+
+Support for the Windows client picking up this new=
 sub-option is added, however
+IPv6 DNS resolvers need to be configured via=
 `netsh` which requires
+administrator privileges unless the new interactiv=
e services on Windows is being
+used=2E If the interactive service is used,=
 this service will execute `netsh` in
+the background with the proper privi=
leges=2E
+
+**New improved Windows Background service**
+
+The new OpenVPNS=
ervice is based on openvpnserv2, a complete rewrite of the
+OpenVPN service=
 wrapper=2E It is intended for launching OpenVPN instances that
+should be =
up at all times, instead of being manually launched by a user=2E
+OpenVPNSe=
rvice is able to restart individual OpenVPN processes if they crash,
+and i=
t also works properly on recent Windows versions=2E OpenVPNServiceLegacy
+t=
ends to work poorly, if at all, on newer Windows versions (8+) and its use =
is
+not recommended=2E
+
+**New interactive Windows service**
+
+The instal=
ler starts OpenVPNServiceInteractive automatically and configures it
+to st=
art at system startup=2E
+
+The interactive Windows service allows unprivil=
eged users to start OpenVPN
+connections in the global config directory (us=
ually C:\Program
+Files\OpenVPN\config) using OpenVPN GUI without any extra=
 configuration=2E
+
+Users who belong to the built-in Administrator group o=
r to the local "OpenVPN
+Administrator" group can also store configuration =
files under
+%USERPROFILE%\OpenVPN\config for use with the interactive serv=
ice=2E
+
+**redirect-gateway ipv6**
+
+OpenVPN has now feature parity betwe=
en IPv4 and IPv6 for redirect gateway
+including the handling of overlappin=
g IPv6 routes with IPv6 remote VPN server
+address=2E
+
+**LZ4 Compression =
and pushable compression**
+
+Additionally to LZO compression OpenVPN now a=
lso supports LZ4 compression=2E
+Compression options are now pushable from =
the server=2E
+
+**Filter pulled options client-side: pull-filter**
+
+New =
option to explicitly allow or reject options pushed by the server=2E May be=

+used multiple times and is applied in the order specified=2E
+
+**Per-cli=
ent remove push options: push-remove**
+
+New option to remove options on a=
 per-client basis from the "push" list (more
+fine-grained than `--push-res=
et`)=2E
+
+**Http proxy password inside config file**
+
+Http proxy passwor=
ds can be specified with the inline file option
+`<http-proxy-user-pass>` =
=2E=2E `</http-proxy-user-pass>`
+
+**Windows version detection**
+
+Window=
s version is detected, logged and possibly signalled to server
+(`IV_PLAT_V=
ER=3D<nn>` if `--push-peer-info` is set on client)=2E
+
+**Authentication t=
okens**
+
+In situations where it is not suitable to save user passwords on=
 the client,
+OpenVPN has support for pushing a --auth-token since v2=2E3=
=2E This option is pushed
+from the server to the client with a token value=
 to be used instead of the users
+password=2E For this to work, the authent=
ication plug-in would need to implement
+this support as well=2E In OpenVPN=
 2=2E4 --auth-gen-token is introduced, which will
+allow the OpenVPN server=
 to generate a random token and push it to the client
+without any changes =
to the authentication modules=2E When the clients need to
+re-authenticate =
the OpenVPN server will do the authentication internally,
+instead of sendi=
ng the re-authentication request to the authentication module =2E
+This fea=
ture is especially useful in configurations which use One Time Password
+(O=
TP) authentication schemes, as this allows the tunnel keys to be renegotiat=
ed
+regularly without any need to supply new OTP codes=2E
+
+**keying-mater=
ial-exporter**
+
+Keying Material Exporter \[RFC-5705\] allow additional ke=
ying material to be
+derived from existing TLS channel=2E
+
+**Android plat=
form support**
+
+Support for running on Android using Android's VPNService=
 API has been added=2E
+See doc/android=2Etxt for more details=2E This supp=
ort is primarily used in the
+OpenVPN for Android app (<https://github=2Eco=
m/schwabe/ics-openvpn>)
+
+**AIX platform support**
+
+AIX platform support=
 has been added=2E The support only includes tap devices since
+AIX does no=
t provide tun interface=2E
+
+**Control channel encryption (`--tls-crypt`)*=
*
+
+Use a pre-shared static key (like the `--tls-auth` key) to encrypt con=
trol
+channel packets=2E Provides more privacy, some obfuscation and poor-m=
an's
+post-quantum security=2E
+
+**Asynchronous push reply**
+
+Plug-ins p=
roviding support for deferred authentication can benefit from a more
+respo=
nsive authentication where the server sends PUSH_REPLY immediately once the=

+authentication result is ready, instead of waiting for the client to to s=
end
+PUSH_REQUEST once more=2E This requires OpenVPN to be built with
+`=2E=
/configure --enable-async-push`=2E This is a compile-time only switch=2E
+
=
+## Deprecated features
+
+For an up-to-date list of all deprecated options=
, see this wiki page:
+<https://community=2Eopenvpn=2Enet/openvpn/wiki/Depr=
ecatedOptions>
+
+- `--key-method 1` is deprecated in OpenVPN 2=2E4 and wil=
l be removed in v2=2E5=2E
+  Migrate away from `--key-method 1` as soon as =
possible=2E The recommended
+  approach is to remove the `--key-method` opt=
ion from the configuration files,
+  OpenVPN will then use `--key-method 2`=
 by default=2E Note that this requires
+  changing the option in both the c=
lient and server side configs=2E
+- `--tls-remote` is removed in OpenVPN 2=
=2E4, as indicated in the v2=2E3 man-pages=2E
+  Similar functionality is p=
rovided via `--verify-x509-name`, which does the
+  same job in a better wa=
y=2E
+- `--compat-names` and `--no-name-remapping` were deprecated in OpenV=
PN 2=2E3 and
+  will be removed in v2=2E5=2E All scripts and plug-ins depen=
ding on the old
+  non-standard X=2E509 subject formatting must be updated =
to the standardized
+  formatting=2E See the man page for more information=
=2E
+- `--no-iv` is deprecated in OpenVPN 2=2E4 and will be removed in v2=
=2E5=2E
+- `--keysize` is deprecated in OpenVPN 2=2E4 and will be removed i=
n v2=2E6 together
+  with the support of ciphers with cipher block size les=
s than 128-bits=2E
+- `--comp-lzo` is deprecated in OpenVPN 2=2E4=2E Use `-=
-compress` instead=2E
+- `--ifconfig-pool-linear` has been deprecated since=
 OpenVPN 2=2E1 and will be
+  removed in v2=2E5=2E Use `--topology p2p` ins=
tead=2E
+- `--client-cert-not-required` is deprecated in OpenVPN 2=2E4 and =
will be removed
+  in v2=2E5=2E Use `--verify-client-cert none` for a funct=
ional equivalent=2E
+- `--ns-cert-type` is deprecated in OpenVPN 2=2E3=2E18=
 and v2=2E4=2E It will be removed
+  in v2=2E5=2E Use the far better `--rem=
ote-cert-tls` option which replaces this
+  feature=2E
+
+## User-visible C=
hanges
+
+- When using ciphers with cipher blocks less than 128-bits, OpenV=
PN will
+  complain loudly if the configuration uses ciphers considered wea=
k, such as the
+  SWEET32 attack vector=2E In such scenarios, OpenVPN will =
by default renegotiate
+  for each 64MB of transported data (`--reneg-bytes=
`)=2E This renegotiation can be
+  disabled, but is HIGHLY DISCOURAGED=2E
+=

+- For certificate DNs with duplicate fields, e=2Eg=2E "OU=3Done,OU=3Dtwo"=
, both fields
+  are now exported to the environment, where each second and=
 later occurrence of
+  a field get _$N appended to it's field name, starti=
ng at N=3D1=2E For the
+  example above, that would result in e=2Eg=2E X509=
_0_OU=3Done, X509_0_OU_1=3Dtwo=2E Note
+  that this breaks setups that rely=
 on the fact that OpenVPN would previously
+  (incorrectly) only export the=
 last occurrence of a field=2E
+
+- `proto udp` and `proto tcp` now use bot=
h IPv4 and IPv6=2E The new options
+  `proto udp4` and `proto tcp4` use IPv=
4 only=2E
+
+- `--sndbuf` and `--recvbuf` default now to OS defaults instea=
d of 64k
+
+- OpenVPN exits with an error if an option has extra parameters=
; previously they
+  were silently ignored
+
+- `--tls-auth` always require=
s OpenVPN static key files and will no longer work
+  with free form files
=
+
+- `--proto udp6/tcp6` in server mode will now try to always listen to bo=
th IPv4
+  and IPv6 on platforms that allow it=2E Use `--bind ipv6only` to =
explicitly
+  listen only on IPv6=2E
+
+- Removed `--enable-password-save` =
from configure=2E This option is now always
+  enabled=2E
+
+- Stricter def=
ault TLS cipher list (override with `--tls-cipher`), that now also
+  disab=
les:
+
+  - Non-ephemeral key exchange using static (EC)DH keys
+  - DSS pr=
ivate keys
+
+- mbed TLS builds: changed the tls_digest_N values exported t=
o the script
+  environment to be equal to the ones exported by OpenSSL bui=
lds, namely the
+  certificate fingerprint (was the hash of the 'to be sign=
ed' data)=2E
+
+- mbed TLS builds: minimum RSA key size is now 2048 bits=2E=
 Shorter keys will not
+  be accepted, both local and from the peer=2E
+
+-=
 `--connect-timeout` now specifies the timeout until the first TLS packet i=
s
+  received (identical to `--server-poll-timeout`) and this timeout now i=
ncludes
+  the removed socks proxy timeout and http proxy timeout=2E
+
+  I=
n `--static` mode `connect-timeout` specifies the timeout for TCP and proxy=

+  connection establishment
+
+- `--connect-retry-max` now specifies the m=
aximum number of unsuccessful
+  attempts of each remote/connection entry b=
efore exiting=2E
+
+- `--http-proxy-timeout` and the static non-changeable =
socks timeout (5s) have
+  been folded into a "unified" `--connect-timeout`=
 which covers all steps needed
+  to connect to the server, up to the start=
 of the TLS exchange=2E The default
+  value has been raised to 120s, to ha=
ndle slow http/socks proxies graciously=2E
+  The old "fail TCP fast" behav=
iour can be achieved by adding
+  "`--connect-timeout 10`" to the client co=
nfig=2E
+
+- `--http-proxy-retry` and `--sock-proxy-retry` have been remove=
d=2E Proxy
+  connections will now behave like regular connection entries a=
nd generate a
+  USR1 on failure=2E
+
+- `--connect-retry` gets an optional=
 second argument that specifies the maximum
+  time in seconds to wait betw=
een reconnection attempts when an exponential
+  backoff is triggered due t=
o repeated retries=2E Default =3D 300 seconds=2E
+
+- Data channel cipher n=
egotiation (see New features section) can override
+  ciphers configured in=
 the config file=2E Use `--ncp-disable` if you do not want
+  this behavior=
=2E
+
+- All tun devices on all platforms are always considered to be IPv6 =
capable=2E The
+  `--tun-ipv6` option is ignored (behaves like it is always=
 on)=2E
+
+- On the client side recursively routed packets, which have the =
same destination
+  as the VPN server, are dropped=2E This can be disabled =
with
+  --allow-recursive-routing option=2E
+
+- On Windows, when the `--re=
gister-dns` option is set, OpenVPN no longer
+  restarts the `dnscache` ser=
vice - this had unwanted side effects, and seems to
+  be no longer necessa=
ry with currently supported Windows versions=2E
+
+- If no flags are given,=
 and the interactive Windows service is used, "def1" is
+  implicitly set (=
because "delete and later reinstall the existing default
+  route" does not=
 work well here)=2E If not using the service, the old behaviour
+  is kept=
=2E
+
+- OpenVPN now reloads a CRL only if the modication time or file size=
 has
+  changed, instead of for each new connection=2E This reduces the con=
nection setup
+  time, in particular when using large CRLs=2E
+
+- OpenVPN =
now ships with more up-to-date systemd unit files which take advantage
+  o=
f the improved service management as well as some hardening steps=2E The
+ =
 configuration files are picked up from the /etc/openvpn/server/ and
+  /et=
c/openvpn/client/ directories (depending on unit file)=2E This also avoids
=
+  these new unit files and how they work to collide with older pre-existin=
g unit
+  files=2E
+
+- Using `--no-iv` (which is generally not a recommend=
ed setup) will require
+  explicitly disabling NCP with `--disable-ncp`=2E =
This is intentional because NCP
+  will by default use AES-GCM, which requi=
res an IV - so we want users of that
+  option to consciously reconsider=2E=

+
+## Maintainer-visible changes
+
+- OpenVPN no longer supports building =
with crypto support, but without TLS
+  support=2E As a consequence, `OPENS=
SL_CRYPTO_{CFLAGS,LIBS}` and
+  `OPENSSL_SSL_{CFLAGS,LIBS}` have been merge=
d into `OPENSSL_{CFLAGS,LIBS}`=2E
+  This is particularly relevant for main=
tainers who build their own OpenSSL
+  library, e=2Eg=2E when cross-compili=
ng=2E
+- Linux distributions using systemd is highly encouraged to ship the=
se new unit
+  files instead of older ones, to provide a unified behaviour =
across systemd
+  based Linux distributions=2E
+- With OpenVPN 2=2E4, the p=
roject has moved over to depend on and actively use the
+  official C99 sta=
ndard (-std=3Dc99)=2E This may fail on some older compiler/libc
+  header c=
ombinations=2E In most of these situations it is recommended to use
+  -std=
=3Dgnu99 in CFLAGS=2E This is known to be needed when doing i386/i686 build=
s
+  on RHEL5=2E
+
+# Version 2=2E4=2E5
+
+## New features
+
+- The new opt=
ion `--tls-cert-profile` can be used to restrict the set of allowed
+  cryp=
to algorithms in TLS certificates in mbed TLS builds=2E The default profile=

+  is 'legacy' for now, which allows SHA1+, RSA-1024+ and any elliptic cur=
ve
+  certificates=2E The default will be changed to the 'preferred' profil=
e in the
+  future, which requires SHA2+, RSA-2048+ and any curve=2E
+
+# V=
ersion 2=2E4=2E3
+
+## New features
+
+- Support building with OpenSSL 1=2E=
1 now (in addition to older versions)
+- On Win10, set low interface metric=
 for TAP adapter when block-outside-dns is
+  in use, to make Windows prefe=
r the TAP adapter for DNS queries (avoiding large
+  delays)
+
+## Security=

+
+- CVE-2017-7522: Fix `--x509-track` post-authentication remote DoS A cl=
ient
+  could crash a v2=2E4+ mbedtls server, if that server uses the `--x5=
09-track`
+  option and the client has a correct, signed and unrevoked cert=
ificate that
+  contains an embedded NUL in the certificate subject=2E Disc=
overed and reported
+  to the OpenVPN security team by Guido Vranken=2E
+- =
CVE-2017-7521: Fix post-authentication remote-triggerable memory leaks A
+ =
 client could cause a server to leak a few bytes each time it connects to t=
he
+  server=2E That can eventually cause the server to run out of memory, =
and thereby
+  causing the server process to terminate=2E Discovered and re=
ported to the
+  OpenVPN security team by Guido Vranken=2E (OpenSSL builds =
only=2E)
+- CVE-2017-7521: Fix a potential post-authentication remote code =
execution
+  attack on servers that use the `--x509-username-field` option =
with an X=2E509
+  extension field (option argument prefixed with `ext:`)=
=2E A client that can
+  cause a server to run out-of-memory (see above) mi=
ght be able to cause the
+  server to double free, which in turn might lead=
 to remote code execution=2E
+  Discovered and reported to the OpenVPN secu=
rity team by Guido Vranken=2E
+  (OpenSSL builds only=2E)
+- CVE-2017-7520:=
 Pre-authentication remote crash/information disclosure for
+  clients=2E I=
f clients use a HTTP proxy with NTLM authentication (i=2Ee=2E
+  `--http-pr=
oxy <server> <port> [<authfile>|'auto'|'auto-nct'] ntlm2`), a
+  man-in-the=
-middle attacker between the client and the proxy can cause the
+  client t=
o crash or disclose at most 96 bytes of stack memory=2E The disclosed
+  st=
ack memory is likely to contain the proxy password=2E If the proxy password=
 is
+  not reused, this is unlikely to compromise the security of the OpenV=
PN tunnel
+  itself=2E Clients who do not use the `--http-proxy` option wit=
h ntlm2
+  authentication are not affected=2E
+- CVE-2017-7508: Fix remotel=
y-triggerable ASSERT() on malformed IPv6 packet=2E
+  This can be used to r=
emotely shutdown an openvpn server or client, if IPv6 and
+  `--mssfix` are=
 enabled and the IPv6 networks used inside the VPN are known=2E
+- Fix null=
-pointer dereference when talking to a malicious http proxy that
+  returns=
 a malformed `Proxy-Authenticate:` headers for digest auth=2E
+- Fix overfl=
ow check for long `--tls-cipher` option
+- Windows: Pass correct buffer siz=
e to `GetModuleFileNameW()` (OSTIF/Quarkslabs
+  audit, finding 5=2E6)
+
+#=
# User-visible Changes
+
+- `--verify-hash` can now take an optional flag w=
hich changes the hashing
+  algorithm=2E It can be either SHA1 or SHA256=2E=
 The default if not provided is
+  SHA1 to preserve backwards compatibility=
 with existing configurations=2E
+- Restrict the supported `--x509-username=
-field` extension fields to
+  subjectAltName and issuerAltName=2E Other ex=
tensions probably didn't work
+  anyway, and would cause OpenVPN to crash w=
hen a client connects=2E
+
+## Bugfixes
+
+- Fix fingerprint calculation in=
 mbed TLS builds=2E This means that mbed TLS users
+  of OpenVPN 2=2E4=2E0,=
 v2=2E4=2E1 and v2=2E4=2E2 that rely on the values of the
+  `tls_digest_*`=
 env vars, or that use `--verify-hash` will have to change the
+  fingerpri=
nt values they check against=2E The security impact of the incorrect
+  cal=
culation is very minimal; the last few bytes (max 4, typically 4) are not
+=
  verified by the fingerprint=2E We expect no real-world impact,
+  because=
 users that used this feature before will notice that it has suddenly
+  st=
opped working, and users that didn't will notice that connection setup fail=
s
+  if they specify correct fingerprints=2E
+
+- Fix edge case with NCP wh=
en the server sends an empty PUSH_REPLY message back,
+  and the client wou=
ld not initialize it's data channel crypto layer properly
+  (trac #903)
+
=
+- Fix SIGSEGV on unaligned buffer access on OpenBSD/Sparc64
+
+- Fix TCP_N=
ODELAY on OpenBSD
+
+- Remove erroneous limitation on max number of args fo=
r `--plugin`
+
+- Fix NCP behaviour on TLS reconnect (Server would not send=
 a proper "cipher
+  =2E=2E=2E" message back to the client, leading to clie=
nt and server using different
+  ciphers) (trac #887)
+
+# Version 2=2E4=2E=
2
+
+## Bugfixes
+
+- Fix memory leak introduced in OpenVPN 2=2E4=2E1: if `=
--remote-cert-tls` is used,
+  we leaked some memory on each TLS (re)negoti=
ation=2E
+
+## Security
+
+- Fix a pre-authentication denial-of-service att=
ack on both clients and servers=2E
+  By sending a too-large control packet=
, OpenVPN 2=2E4=2E0 or v2=2E4=2E1 can be forced
+  to hit an ASSERT() and s=
top the process=2E If `--tls-auth` or `--tls-crypt` is
+  used, only attack=
ers that have the `--tls-auth` or `--tls-crypt` key can mount
+  an attack=
=2E (OSTIF/Quarkslab audit finding 5=2E1, CVE-2017-7478)
+- Fix an authenti=
cated remote DoS vulnerability that could be triggered by
+  causing a pack=
et id roll over=2E An attack is rather inefficient; a peer would
+  need to=
 get us to send at least about 196 GB of data=2E (OSTIF/Quarkslab audit
+  =
finding 5=2E2, CVE-2017-7479)
+
+# Version 2=2E4=2E1
+
+- `--remote-cert-ku=
` now only requires the certificate to have at least the bits
+  set of one=
 of the values in the supplied list, instead of requiring an exact
+  match=
 to one of the values in the list=2E
+- `--remote-cert-tls` now only requir=
es that a keyUsage is present in the
+  certificate, and leaves the verific=
ation of the value up to the crypto
+  library, which has more information =
(i=2Ee=2E the key exchange method in use) to
+  verify that the keyUsage is=
 correct=2E
+- `--ns-cert-type` is deprecated=2E Use `--remote-cert-tls` in=
stead=2E The
+  nsCertType x509 extension is very old, and barely used=2E `=
--remote-cert-tls`
+  uses the far more common keyUsage and extendedKeyUsag=
e extension instead=2E Make
+  sure your certificates carry these to be abl=
e to use `--remote-cert-tls`=2E
diff --git a/Changes=2Erst b/Changes=2Erst
=
deleted file mode 100644
index 1f992b2=2E=2E0000000
--- a/Changes=2Erst
+++=
 /dev/null
@@ -1,1460 +0,0 @@
-Overview of changes in 2=2E8
-=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-
-Ove=
rview of changes in 2=2E7
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-New features
-------------
-Multi-socket su=
pport for servers
-    OpenVPN servers now can listen on multiple sockets a=
t the same time=2E
-    Multiple ``--local`` statements in the configuratio=
n can be used to
-    configure this=2E This way the same server can e=2Eg=
=2E listen for UDP
-    and TCP connections at the same time, or listen on =
multiple addresses
-    and/or ports=2E
-
-Client implementations for DNS o=
ptions sent by server for Linux/BSD/macOS
-    Linux, BSD and macOS version=
s of OpenVPN now ship with a per-platform
-    default ``--dns-updown`` scr=
ipt that implements proper handling of
-    DNS configuration sent by the s=
erver=2E  The scripts should work on
-    systems that use ``systemd`` or `=
`resolveconf`` to manage the DNS
-    setup, as well as raw ``/etc/resolv=
=2Econf`` files=2E However, the exact
-    features supported will depend o=
n the configuration method=2E
-    On Linux and MacOS this should usually m=
ake split-DNS configurations
-    supported out-of-the-box now=2E
-
-    No=
te that this new script will not be used by default if a ``--up``
-    scri=
pt is already in use to reduce problems with
-    backwards compatibility=
=2E
-
-    See documentation for ``--dns-updown`` and ``--dns`` for more de=
tails=2E
-
-New client implementation for DNS options sent by server for Wi=
ndows
-    The Windows client now uses NRPT (Name Resolution Policy Table) =
to
-    handle DNS configurations=2E This adds support for split-DNS and DN=
SSEC
-    and improves the compatbility with local DNS resolvers=2E Require=
s the
-    interactive service=2E
-
-On Windows the ``block-local`` flag is=
 now enforced with WFP filters=2E
-    The ``block-local`` flag to ``--redi=
rect-gateway`` and
-    ``--redirect-private`` is now also enforced via the=
 Windows Firewall,
-    making sure packets can't be sent to the local netw=
ork=2E
-    This provides stronger protection against TunnelCrack-style att=
acks=2E
-
-Windows network adapters are now generated on demand
-    This m=
eans that on systems that run multiple OpenVPN connections at
-    the same=
 time the users don't need to manually create enough network
-    adapters =
anymore (in addition to the ones created by the installer)=2E
-
-Windows au=
tomatic service now runs as an unpriviledged user
-    All tasks that need =
privileges are now delegated to the interactive
-    service=2E
-    **NOTE=
** this has the risk of breaking existing setups if the
-    Windows certif=
icate store is used (cryptoapi), and the certificates
-    are not readable=
 for ``NT SERVICE\OpenVPNService``=2E
-
-Support for new version of Linux D=
CO module
-    The OpenVPN DCO module has been merged into the Linux kernel=
 as of
-    6=2E16=2E  This required some API changes and OpenVPN 2=2E7 onl=
y supports
-    the new API=2E The new module is called ``ovpn``=2E Out-of-=
tree builds
-    for older kernels are available from
-    https://github=
=2Ecom/OpenVPN/ovpn-backports=2E Please
-    see the release announcements =
for further information=2E
-
-Support for server mode in win-dco driver
-  =
  On Windows the win-dco driver can now be used in server setups=2E
-
-Supp=
ort for TLS client floating in DCO implementations
-    The kernel modules =
will detect clients floating to a new IP address
-    and notify userland s=
o both data packets (kernel) and TLS packets
-    (sent by userland) can re=
ach the new client IP=2E
-    (Actual support depends on recent-enough kern=
el implementation)
-
-Enforcement of AES-GCM usage limit
-    OpenVPN will =
now enforce the usage limits on AES-GCM with the same
-    confidentiality =
margin as TLS 1=2E3 does=2E This mean that renegotiation will
-    be trigg=
ered after roughly 2^28 to 2^31 packets depending of the packet
-    size=
=2E More details about usage limit of AES-GCM can be found here:
-
-    htt=
ps://datatracker=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-limits/
-
-Epoch dat=
a keys and packet format
-    This introduces the epoch data format for AEA=
D data channel
-    ciphers in TLS mode ciphers=2E This new data format has=
 a number of
-    improvements over the standard "DATA_V2" format=2E
-
-   =
 - AEAD tag at the end of packet which is more hardware implementation
-   =
   friendly
-    - Automatic key switchover when cipher usage limits are hi=
t, similar to
-      the epoch data keys in (D)TLS 1=2E3
-    - 64 bit inst=
ead of 32 bit packet ids to allow the data channel to be
-      ready for 1=
0 GBit/s without having frequent renegotiation
-    - IV constructed with X=
OR instead of concatenation to not have (parts) of
-      the real IV on th=
e wire
-
-Support for Epoch data channel on Windows, using the win-dco driv=
er (2=2E8=2E0+)
-
-Default ciphers in ``--data-ciphers``
-    Ciphers in ``=
--data-ciphers`` can contain the string DEFAULT that is
-    replaced by th=
e default ciphers used by OpenVPN, making it easier to
-    add an allowed =
cipher without having to spell out the default ciphers=2E
-
-TLS alerts
-  =
  OpenVPN 2=2E7 will send out TLS alerts to peers informing them if the TLS=

-    session shuts down or when the TLS implementation informs the peer ab=
out
-    an error in the TLS session (e=2Eg=2E mismatching TLS versions)=2E=
 This improves
-    the user experience as the client shows an error instea=
d of running into
-    a timeout when the server just stops responding comp=
letely=2E
-
-Support for tun/tap via unix domain socket and lwipovpn suppor=
t
-    To allow better testing and emulating a full client with a full
-   =
 network stack OpenVPN now allows a program executed to provide
-    a tun/=
tap device instead of opening a device=2E
-
-    The co-developed lwipovpn =
program based on lwIP stack allows to
-    simulate full IP stack=2E An Ope=
nVPN client using
-    ``--dev-node unix:/path/to/lwipovpn`` can emulate a =
full client that
-    can be pinged, can serve a website and more without r=
equiring any
-    elevated permission=2E This can make testing OpenVPN much=
 easier=2E
-
-    For more details see
-    `lwipovpn on Github <https://gi=
thub=2Ecom/OpenVPN/lwipovpn>`_=2E
-
-Allow overriding username with ``--ove=
rride-username``
-    This is intended to allow using ``--auth-gen-token`` =
in scenarios where the
-    clients use certificates and multi-factor authe=
ntication=2E  This will
-    also generate a ``push "auth-token-user newuse=
rname"`` directive in
-    push replies=2E
-
-``--port-share`` now properly=
 supports IPv6
-    Issues with logging of IPv6 addresses were fixed=2E The=
 feature now allows
-    IPv6 connections towards the proxy receiver=2E
-
-=
Support for Haiku OS
-
-TLS1=2E3 support with mbedTLS (requires mbedTLS >=
=3D 3=2E6=2E4)
-
-PUSH_UPDATE client support
-    It is now possible to upd=
ate parts of the client-side configuration
-    (IP address, routes, MTU, D=
NS) by sending a new server-to-client
-    control message, ``PUSH_UPDATE,<=
options>``=2E
-    See also: https://openvpn=2Egithub=2Eio/openvpn-rfc/open=
vpn-wire-protocol=2Ehtml
-    NOTE: PUSH_UPDATE client support is currently=
 disabled if DCO
-    is active (on all platforms)=2E
-
-PUSH_UPDATE server=
 support (minimal)
-    New management interface commands ``push-update-bro=
ad`` and
-    ``push-update-cid`` to send PUSH_UPDATE option updates to all=

-    clients ("there is a new DNS server") or only a specific client ID
- =
   ("privileges have changed, here's a new IP address")=2E  See
-    doc/ma=
nagement-notes=2Etxt
-    NOTE: PUSH_UPDATE server support is currently dis=
abled if DCO
-    is active (on all platforms)=2E
-
-Support for user-defin=
ed routing tables on Linux
-    See the ``--route-table`` option in the man=
page
-
-PQE support for WolfSSL
-
-Two new environment variables have been =
introduced to communicate desired
-    default gateway redirection to plugi=
ns like Network Manager,
-    ``route_redirect_gateway_ipv4`` and ``route_r=
edirect_gateway_ipv6``=2E
-    See the "Environmental Variables" section in=
 the man page
-
-Improved logging of service events/errors to event log on =
Windows=2E
-
-"Recursive Routing" check is now more granular, and will only=
 drop
-   packets-in-tunnel if destination IP, protocol and port matches wi=
th
-   those needed to reach the VPN server=2E  With that change, you can n=
ow
-   use policies that direct "everything that is not OpenVPN" into the
-=
   tunnel, and have IP packets to the VPN server address arrive as
-   expe=
cted (no such policies are currently installed by OpenVPN)
-   (GH: OpenVPN=
/openvpn#669)=2E
-
-COPYING: license details only relevant to our Windows i=
nstallers have
-   been updated and moved to the openvpn-build repo
-
-Impr=
oved BYTECOUNT support - more strictly adhere to timing interval
-   reques=
ted, correctly support client and server counters with Linux and
-   Window=
s DCO offloading=2E
-
-Improve compatibility with OpenSSL 3=2E6=2E0 (do not=
 fail t_lpback selftest)
-
-New option ``--tls-crypt-v2-max-age n`` to chec=
k tls-crypt-v2 timestamps
-   (When a client is older than n days or has no=
 timestamp, the server
-    will reject it)
-
-mbedTLS 4 support has been a=
dded=2E
-   Note that with mbedTLS 4 algorithms need to be translated to
- =
  mbedTLS 4 internal IDs by OpenVPN, and some names might be
-   missing=2E=

-
-
-Deprecated features
--------------------
-``secret`` support has been=
 removed (by default)=2E
-    static key mode (non-TLS) is no longer consid=
ered "good and secure enough"
-    for today's requirements=2E  Use TLS mod=
e instead=2E  If deploying a PKI CA
-    is considered "too complicated", u=
sing ``--peer-fingerprint`` makes
-    TLS mode about as easy as using ``--=
secret``=2E
-
-    This mode can still be enabled by using
-    ``--allow-d=
eprecated-insecure-static-crypto`` but will be removed in
-    OpenVPN 2=2E=
8=2E
-
-Support for wintun Windows driver has been removed=2E
-    OpenVPN =
2=2E6 added support for the new dco-win driver, so it supported
-    three =
different device drivers: dco-win, wintun, and tap-windows6=2E
-    OpenVPN=
 2=2E7 now drops the support for wintun driver=2E By default
-    all moder=
n configs should be supported by dco-win driver=2E In all
-    other cases =
OpenVPN will fall back automatically to tap-windows6
-    driver=2E
-
-NTLM=
v1 authentication support for HTTP proxies has been removed=2E
-    This is=
 considered an insecure method of authentication that uses
-    obsolete cr=
ypto algorithms=2E
-    NTLMv2 support is still available, but will be remo=
ved in a future
-    release=2E
-    When configured to authenticate with N=
TLMv1 (``ntlm`` keyword in
-    ``--http-proxy``) OpenVPN will try NTLMv2 i=
nstead=2E
-
-``persist-key`` option has been enabled by default=2E
-    All=
 the keys will be kept in memory across restart=2E
-
-OpenSSL 1=2E0=2E2 sup=
port has been removed=2E
-    Support for building with OpenSSL 1=2E0=2E2 h=
as been removed=2E The minimum
-    supported OpenSSL version is now 1=2E1=
=2E0=2E
-
-mbedTLS 2=2Ex support has been removed
-    Support for building=
 with mbedTLS 2=2Ex has been removed (it is out
-    of support since March=
 2025, and the necessary compatibility code
-    is making maintenance and =
support for mbedTLS 4=2Ex hard)=2E
-    The minimum supported mbedTLS versi=
on is now 3=2E2=2E1=2E
-
-Compression on send has been removed=2E
-    Open=
VPN 2=2E7 will never compress data before sending=2E Decompression of
-    =
received data is still supported=2E
-    ``--allow-compression yes`` is now=
 an alias for
-    ``--allow-compression asym``=2E
-
-``--memstats`` featur=
e removed
-    The ``--memstats`` option was largely undocumented and there=
 is no known
-    user of this feature=2E  This feature provided very limit=
ed statistics
-    (number of users, link bytes read/written) and we do not=
 except any
-    usage because of this=2E
-
-Using ``--push`` in a mode tha=
t is not ``--mode server`` will now print a
-    clear warning that this is=
 an unsupported operation and might cause
-    negotiation failures=2E
-
-`=
`--reneg-bytes`` and ``--reneg-packets`` do not work in DCO mode, and will
=
-    now print an appropriate warning=2E
-
-On-connect resolving of ``--rem=
ote`` addresses in ``--tcp-server`` mode
-    was not working since 2=2E4, =
so the code was completely removed=2E
-
-
-User-visible Changes
-----------=
----------
-- Default for ``--topology`` changed to ``subnet`` for ``--mode=
 server``=2E
-  Previous releases always used ``net30`` as default=2E This =
only affects
-  configs with ``--mode server`` or ``--server`` (the latter =
implies the
-  former), and ``--dev tun``, and only if IPv4 is enabled=2E
-=
  Note that this changes the semantics of ``--ifconfig``, so if you have
- =
 manual settings for that in your config but not set ``--topology``
-  your=
 config might fail to parse with the new version=2E Just adding
-  ``--topo=
logy net30`` to the config should fix the problem=2E
-  By default ``--topo=
logy`` is pushed from server to client=2E
-
-- ``--x509-username-field`` wi=
ll no longer automatically convert fieldnames to
-  uppercase=2E This was d=
eprecated since OpenVPN 2=2E4, and has now been removed=2E
-
-- ``--dh none=
`` is now the default if ``--dh`` is not specified=2E Modern TLS
-  impleme=
ntations will prefer ECDH and other more modern algorithms anyway=2E
-  And=
 finite field Diffie Hellman is in the proces of being deprecated
-  (see d=
raft-ietf-tls-deprecate-obsolete-kex)
-
-- ``--lport 0`` does not imply ``-=
-bind`` anymore=2E
-
-- ``--redirect-gateway`` now works correctly if the V=
PN remote is not
-  reachable by the default gateway=2E
-
-- ``--show-gatew=
ay`` now supports querying the gateway for IPv4 addresses=2E
-
-- ``--stati=
c-challenge`` option now has a third parameter ``format`` that
-  can chang=
e how password and challenge response should be combined=2E
-
-- ``--key`` =
and ``--cert`` now accept URIs implemented in OpenSSL 3 as well as
-  optio=
nal OpenSSL 3 providers loaded using ``--providers`` option=2E
-
-- ``--cry=
ptoapicert`` now supports issuer name as well as Windows CA template
-  nam=
e or OID as selector string=2E
-
-- TLS handshake debugging information con=
tains much more details now when
-  using recent versions of OpenSSL=2E
-
-=
- The ``IV_PLAT_VER`` variable sent by Windows clients now contains the
-  =
full Windows build version to make it possible to determine the
-  Windows =
10 or Windows 11 version used=2E
-
-- The ``--windows-driver`` option to se=
lect between various windows
-  drivers will no longer do anything - it's k=
ept so existing configs
-  will not become invalid, but it is ignored with =
a warning=2E  The default
-  is now ``ovpn-dco`` if all options used are co=
mpatible with DCO, with
-  a fallback to ``tap-windows6``=2E  To force TAP =
(for example because a
-  server pushes DCO incompatible options), use the =
``--disable-dco``
-  option=2E
-
-- Apply more checks to incoming TLS hands=
hake packets before creating
-  new state - namely, verify message ID / ack=
ed ID for "valid range for
-  an initial packet"=2E  This fixes a problem w=
ith clients that float
-  very early but send control channel packet from t=
he pre-float IP
-  (Github: OpenVPN/openvpn#704)=2E
-
-- Use of ``--dh dh20=
48=2Epem`` in all sample configs has been replaced
-  with ``--dh none``=2E=
  The ``dh2048=2Epem`` file has been removed=2E
-
-- The startup delay in `=
`t_client=2Esh`` has been reduced from 3s to 1s,
-  making a noticeable dif=
ference for setups with many tests=2E
-
-- Changed from using ``uncrustify`=
` for code formatting and pre-commit checks
-  to ``clang-format``=2E  This=
 reformatted quite a bit of code, and requires
-  that regular committers c=
hange their pre-commit checks accordingly=2E
-
-- On Linux, on interfaces w=
here applicable, OpenVPN explicitly configures
-  the broadcast address aga=
in=2E  This was dropped for 2=2E6=2E0 "because
-  computers are smart and c=
an do it themselves", but the kernel netlink
-  interface isn't, and will i=
nstall "0=2E0=2E0=2E0"=2E  This does not normally
-  matter, but for broadc=
ast-based applications that get the address to
-  use from "ifconfig", this=
 change repairs functionality (this has
-  been backported to 2=2E6=2E15, b=
ut is not in earlier 2=2E6 versions)=2E
-
-- ``max-routes-per-client 0`` us=
ed to be silently upgraded to ``1``=2E  This
-  now produces an error=2E
-
=
-- ``ifconfig`` and ``ifconfig-ipv6`` values are now stored in pre-connect
=
-  options cache, and will be restored to pre-connect values on reconnects
=
-  if the server stops pushing the respective option=2E
-
-- ``tapctl=2Eexe=
`` helper binary on Windows has been reworked to improve
-  help texts (mak=
ing clear that it can not only do TAP-Adapters but
-  Win-DCO as well), add=
 printing of the hwid to all adapter outputs, and
-  change the default ada=
pter type created to ``ovpn-dco``=2E
-
-- The default for ``multihome`` egr=
ess interface handling has changed=2E
-  2=2E7=2E0 will default to ipi_ifin=
dex=3D0, that is, leave the decision to the
-  routing/policy setup of the =
operating system=2E  The pre-2=2E7 behaviour
-  (force egress =3D ingress i=
nterface) can be achieved with the new
-  ``--multihome same-interface`` su=
b-option=2E
-
-- Windows ``openvpn=2Eexe`` binary manifest now sets code pa=
ge UTF8 - which
-  has no direct effect on OpenVPN itself, but this repairs=
 OpenSSL file
-  loading for key/cert files with non-ASCII characters in th=
eir file names
-  (GH: OpenVPN/openvpn#920)=2E
-
-- The ``test-crypto`` opt=
ion no longer requires a ``--secret`` argument and
-  will automatically ge=
nerate a random key=2E
-
-- The configure-time option ``--enable-x509-alt-u=
sername`` is no longer
-  conditional, and always-on (GH: OpenVPN/openvpn#9=
17)=2E
-
-
-Deprecated features
--------------------
-``--opt-verify`` feat=
ure removed
-    This option was already deprecated and it is now being con=
verted to a
-    no-op=2E Using this option will only print a warning=2E
-
=
-
-Overview of changes in 2=2E6
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Project changes
----------------
-
=
-We want to deprecate our old Trac bug tracking system=2E
-Please report an=
y issues with this release in GitHub
-instead: https://github=2Ecom/OpenVPN=
/openvpn/issues
-
-New features
-------------
-Support unlimited number of =
connection entries and remote entries
-
-New management commands to enumera=
te and list remote entries
-    Use ``remote-entry-count`` and ``remote-ent=
ry-get``
-    commands from the management interface to get the number of
-=
    remote entries and the entries themselves=2E
-
-Keying Material Exporte=
rs (RFC 5705) based key generation
-    As part of the cipher negotiation O=
penVPN will automatically prefer
-    the RFC5705 based key material genera=
tion to the current custom
-    OpenVPN PRF=2E This feature requires OpenSS=
L or mbed TLS 2=2E18+=2E
-
-Compatibility with OpenSSL in FIPS mode
-    Op=
enVPN will now work with OpenSSL in FIPS mode=2E Note, no effort
-    has b=
een made to check or implement all the
-    requirements/recommendation of =
FIPS 140-2=2E This just allows OpenVPN
-    to be run on a system that be c=
onfigured OpenSSL in FIPS mode=2E
-
-``mlock`` will now check if enough mem=
lock-able memory has been reserved,
-    and if less than 100MB RAM are ava=
ilable, use setrlimit() to upgrade
-    the limit=2E  See Trac #1390=2E  No=
t available on OpenSolaris=2E
-
-Certificate pinning/verify peer fingerprin=
t
-    The ``--peer-fingerprint`` option has been introduced to give users =
an
-    easy to use alternative to the ``tls-verify`` for matching the
-   =
 fingerprint of the peer=2E The option takes use a number of allowed
-    S=
HA256 certificate fingerprints=2E
-
-    See the man page section "Small Op=
enVPN setup with peer-fingerprint"
-    for a tutorial on how to use this f=
eature=2E This is also available online
-    under https://github=2Ecom/ope=
nvpn/openvpn/blob/master/doc/man-sections/example-fingerprint=2Erst
-
-TLS =
mode with self-signed certificates
-    When ``--peer-fingerprint`` is used=
, the ``--ca`` and ``--capath`` option
-    become optional=2E This allows =
for small OpenVPN setups without setting up
-    a PKI with Easy-RSA or sim=
ilar software=2E
-
-Deferred auth support for scripts
-    The ``--auth-use=
r-pass-verify`` script supports now deferred authentication=2E
-
-Pending a=
uth support for plugins and scripts
-    Both auth plugin and script can no=
w signal pending authentication to
-    the client when using deferred auth=
entication=2E The new ``client-crresponse``
-    script option and ``OPENVP=
N_PLUGIN_CLIENT_CRRESPONSE`` plugin function can
-    be used to parse a cl=
ient response to a ``CR_TEXT`` two factor challenge=2E
-
-    See ``sample/=
sample-scripts/totpauth=2Epy`` for an example=2E
-
-Compatibility mode (``-=
-compat-mode``)
-    The modernisation of defaults can impact the compatibi=
lity of OpenVPN 2=2E6=2E0
-    with older peers=2E The options ``--compat-m=
ode`` allows UIs to provide users
-    with an easy way to still connect to=
 older servers=2E
-
-OpenSSL 3=2E0 support
-    OpenSSL 3=2E0 has been adde=
d=2E Most of OpenSSL 3=2E0 changes are not user visible but
-    improve ge=
neral compatibility with OpenSSL 3=2E0=2E ``--tls-cert-profile insecure``
-=
    has been added to allow selecting the lowest OpenSSL security level (no=
t
-    recommended, use only if you must)=2E OpenSSL 3=2E0 no longer suppor=
ts the Blowfish
-    (and other deprecated) algorithm by default and the ne=
w option ``--providers``
-    allows loading the legacy provider to renable=
 these algorithms=2E
-
-Optional ciphers in ``--data-ciphers``
-    Ciphers=
 in ``--data-ciphers`` can now be prefixed with a ``?`` to mark
-    those =
as optional and only use them if the SSL library supports them=2E
-
-
-Impr=
oved ``--mssfix`` and ``--fragment`` calculation
-    The ``--mssfix`` and =
``--fragment`` options now allow an optional :code:`mtu`
-    parameter to =
specify that different overhead for IPv4/IPv6 should taken into
-    accoun=
t and the resulting size is specified as the total size of the VPN packets
=
-    including IP and UDP headers=2E
-
-Cookie based handshake for UDP serv=
er
-    Instead of allocating a connection for each client on the initial p=
acket
-    OpenVPN server will now use an HMAC based cookie as its session =
id=2E This
-    way the server can verify it on completing the handshake wi=
thout keeping
-    state=2E This eliminates the amplification and resource =
exhaustion attacks=2E
-    For tls-crypt-v2 clients, this requires OpenVPN =
2=2E6 clients or later
-    because the client needs to resend its client k=
ey on completing the hand
-    shake=2E The tls-crypt-v2 option allows cont=
rolling if older clients are
-    accepted=2E
-
-    By default the rate of=
 initial packet responses is limited to 100 per 10s
-    interval to avoid =
OpenVPN servers being abused in reflection attacks
-    (see ``--connect-fr=
eq-initial``)=2E
-
-Data channel offloading with ovpn-dco
-    2=2E6=2E0+ i=
mplements support for data-channel offloading where the data packets
-    a=
re directly processed and forwarded in kernel space thanks to the ovpn-dco
=
-    kernel module=2E The userspace openvpn program acts purely as a contro=
l plane
-    application=2E Note that DCO will use DATA_V2 packets in P2P m=
ode, therefore,
-    this implies that peers must be running 2=2E6=2E0+ in =
order to have P2P-NCP
-    which brings DATA_V2 packet support=2E
-
-Sessio=
n timeout
-    It is now possible to terminate a session (or all) after a s=
pecified amount
-    of seconds has passed session commencement=2E This beh=
aviour can be configured
-    using ``--session-timeout``=2E This option ca=
n be configured on the server, on
-    the client or can also be pushed=2E
=
-
-Inline auth username and password
-    Username and password can now be =
specified inline in the configuration file
-    within the <auth-user-pass>=
</auth-user-pass> tags=2E If the password is
-    missing OpenVPN will prom=
pt for input via stdin=2E This applies to inline'd
-    http-proxy-user-pas=
s too=2E
-
-Tun MTU can be pushed
-    The  client can now also dynamically=
 configure its MTU and the server
-    will try to push the client MTU when=
 the client supports it=2E The
-    directive ``--tun-mtu-max`` has been in=
troduced to increase the maximum
-    pushable MTU size (defaults to 1600)=
=2E
-
-Dynamic TLS Crypt
-    When both peers are OpenVPN 2=2E6=2E1+, OpenV=
PN will dynamically create
-    a tls-crypt key that is used for renegotiat=
ion=2E This ensure that only the
-    previously authenticated peer can do =
trigger renegotiation and complete
-    renegotiations=2E
-
-Improved contr=
ol channel packet size control (``max-packet-size``)
-    The size of contr=
ol channel is no longer tied to
-    ``--link-mtu``/``--tun-mtu`` and can b=
e set using ``--max-packet-size``=2E
-    Sending large control channel fra=
mes is also optimised by allowing 6
-    outstanding packets instead of jus=
t 4=2E ``max-packet-size`` will also set
-    ``mssfix`` to try to limit da=
ta-channel packets as well=2E
-
-Deprecated features
--------------------
-=
``inetd`` has been removed
-    This was a very limited and not-well-tested=
 way to run OpenVPN, on TCP
-    and TAP mode only=2E
-
-``verify-hash`` ha=
s been deprecated
-    This option has very limited usefulness and should b=
e replaced by either
-    a better ``--ca`` configuration or with a ``--tls=
-verify`` script=2E
-
-``secret`` has been deprecated
-    static key mode =
(non-TLS) is no longer considered "good and secure enough"
-    for today's=
 requirements=2E  Use TLS mode instead=2E  If deploying a PKI CA
-    is co=
nsidered "too complicated", using ``--peer-fingerprint`` makes
-    TLS mod=
e about as easy as using ``--secret``=2E
-
-``ncp-disable`` has been remove=
d
-    This option mainly served a role as debug option when NCP was first
=
-    introduced=2E It should now no longer be necessary=2E
-
-TLS 1=2E0 and=
 1=2E1 are deprecated
-    ``tls-version-min`` is set to 1=2E2 by default=
=2E  OpenVPN 2=2E6=2E0 defaults
-    to a minimum TLS version of 1=2E2 as T=
LS 1=2E0 and 1=2E1 should be generally
-    avoided=2E Note that OpenVPN ve=
rsions older than 2=2E3=2E7 use TLS 1=2E0 only=2E
-
-``--cipher`` argument =
is no longer appended to ``--data-ciphers``
-    by default=2E Data cipher =
negotiation has been introduced in 2=2E4=2E0
-    and been significantly im=
proved in 2=2E5=2E0=2E The implicit fallback
-    to the cipher specified i=
n ``--cipher`` has been removed=2E
-    Effectively, ``--cipher`` is a no-o=
p in TLS mode now, and will
-    only have an effect in pre-shared-key mode=
 (``--secret``)=2E
-    From now on ``--cipher`` should not be used in new =
configurations
-    for TLS mode=2E
-    Should backwards compatibility wit=
h older OpenVPN peers be
-    required, please see the ``--compat-mode`` in=
stead=2E
-
-``--prng`` has beeen removed
-    OpenVPN used to implement its=
 own PRNG based on a hash=2E However implementing
-    a PRNG is better lef=
t to a crypto library=2E So we use the PRNG
-    mbed TLS or OpenSSL now=2E=

-
-``--keysize`` has been removed
-    The ``--keysize`` option was only u=
seful to change the key length when using the
-    BF, CAST6 or RC2 ciphers=
=2E For all other ciphers the key size is fixed with the
-    chosen cipher=
=2E As OpenVPN v2=2E6 no longer supports any of these variable length
-    =
ciphers, this option was removed as well to avoid confusion=2E
-
-Compressi=
on no longer enabled by default
-    Unless an explicit compression option =
is specified in the configuration,
-    ``--allow-compression`` defaults to=
 ``no`` in OpeNVPN 2=2E6=2E0=2E
-    By default, OpenVPN 2=2E5 still allowe=
d a server to enable compression by
-    pushing compression related option=
s=2E
-
-PF (Packet Filtering) support has been removed
-   The built-in PF =
functionality has been removed from the code base=2E This
-   feature wasn'=
t really easy to use and was long unmaintained=2E
-   This implies that als=
o ``--management-client-pf`` and any other compile
-   time or run time rel=
ated option do not exist any longer=2E
-
-Option conflict checking is being=
 deprecated and phased out
-    The static option checking (OCC) is no long=
er useful in typical setups
-    that negotiate most connection parameters=
=2E The ``--opt-verify`` and
-    ``--occ-disable`` options are deprecated,=
 and the configure option
-    ``--enable-strict-options`` has been removed=
=2E Logging of mismatched
-    options has been moved to debug logging (ver=
b 7)=2E
-
-User-visible Changes
---------------------
-- CHACHA20-POLY1305 =
is included in the default of ``--data-ciphers`` when available=2E
-- Optio=
n ``--prng`` is ignored as we rely on the SSL library random number generat=
or=2E
-- Option ``--nobind`` is default when ``--client`` or ``--pull`` is =
used in the configuration
-- :code:`link_mtu` parameter is removed from env=
ironment or replaced with 0 when scripts are
-  called with parameters=2E T=
his parameter is unreliable and no longer internally calculated=2E
-
-- con=
trol channel packet maximum size is no longer influenced by
-  ``--link-mtu=
``/``--tun-mtu`` and must be set by ``--max-packet-size`` now=2E
-  The def=
ault is 1250 for the control channel size=2E
-
-- In point-to-point OpenVPN=
 setups (no ``--server``), using
-  ``--explict-exit-notiy`` on one end wou=
ld terminate the other side at
-  session end=2E  This is considered a no l=
onger useful default and has
-  been changed to "restart on reception of ex=
plicit-exit-notify message"=2E
-  If the old behaviour is still desired, ``=
--remap-usr1 SIGTERM`` can be used=2E
-
-- FreeBSD tun interfaces with ``--=
topology subnet`` are now put into real
-  subnet mode (IFF_BROADCAST inste=
ad of IFF_POINTOPOINT) - this might upset
-  software that enumerates inter=
faces, looking for "broadcast capable?" and
-  expecting certain results=2E=
  Normal uses should not see any difference=2E
-
-- The default configurati=
ons will no longer allow connections to OpenVPN 2=2E3=2Ex
-  peer or earlie=
r, use the new ``--compat-mode`` option if you need
-  compatibility with o=
lder versions=2E See the manual page on the
-  ``--compat-mode`` for detail=
s=2E
-
-- The ``client-pending-auth`` management command now requires also =
the
-  key id=2E The management version has been changed to 5 to indicate t=
his change=2E
-
-- (OpenVPN 2=2E6=2E2) A client will now refuse a connectio=
n if pushed compression
-  settings will contradict the setting of allow-co=
mpression as this almost
-  always results in a non-working connection=2E
-=

-- The "kill" by addr management command now requires also the protocol
- =
 as string e=2Eg=2E "udp", "tcp"=2E
-
-Common errors with OpenSSL 3=2E0 and=
 OpenVPN 2=2E6
-----------------------------------------------
-Both OpenVP=
N 2=2E6 and OpenSSL 3=2E0 tighten the security considerable, so some
-confi=
guration will no longer work=2E This section will cover the most common
-ca=
uses and error message we have seen and explain their reason and temporary
=
-workarounds=2E You should fix the underlying problems as soon as possible =
since
-these workaround are not secure and will eventually stop working in =
a future
-update=2E
-
-- weak SHA1 or MD5 signature on certificates
-
-  Th=
is will happen on either loading of certificates or on connection
-  to a s=
erver::
-
-      OpenSSL: error:0A00018E:SSL routines::ca md too weak
-    =
  Cannot load certificate file cert=2Ecrt
-      Exiting due to fatal error=

-
-  OpenSSL 3=2E0 no longer allows weak signatures on certificates=2E You=
 can
-  downgrade your security to allow them by using ``--tls-cert-profile=
 insecure``
-  but should replace/regenerate these certificates as soon as =
possible=2E
-
-
-- 1024 bit RSA certificates, 1024 bit DH parameters, other=
 weak keys
-
-  This happens if you use private keys or other cryptographic=
 material that
-  does not meet today's cryptographic standards anymore=2E =
Messages are similar
-  to::
-
-      OpenSSL: error:0A00018F:SSL routines:=
:ee key too small
-      OpenSSL: error:1408518A:SSL routines:ssl3_ctx_ctrl=
:dh key too small
-
-  DH parameters (``--dh``) can be regenerated with ``o=
penssl dhparam 2048``=2E
-  For other cryptographic keys, these keys and ce=
rtificates need to be
-  regenerated=2E TLS Security level can be temporari=
ly lowered with
-  ``--tls-cert-profile legacy`` or even ``--tls-cert-profi=
le insecure``=2E
-
-- Connecting to a OpenVPN 2=2E3=2Ex server or allowing =
OpenVPN 2=2E3=2Ex or earlier
-  clients
-
-  This will normally result in m=
essages like::
-
-     OPTIONS ERROR: failed to negotiate cipher with serve=
r=2E  Add the server's cipher ('AES-128-CBC') to --data-ciphers (currently =
'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') if you want to connect to this=
 server=2E
-
-     or
-
-     client/127=2E0=2E0=2E1:49954 SENT CONTROL [cl=
ient]: 'AUTH_FAILED,Data channel cipher negotiation failed (no shared ciphe=
r)' (status=3D1)
-
-  You can manually add the missing cipher to the ``--da=
ta-ciphers``=2E The
-  standard ciphers should be included as well, e=2Eg=
=2E
-  ``--data-ciphers AES-256-GCM:AES-128-GCM:?Chacha20-Poly1305:?AES-128=
-CBC``=2E
-  You can also use the ``--compat-mode`` option=2E Note that the=
se message may
-  also indicate other cipher configuration problems=2E See =
the data channel
-  cipher negotiation manual section for more details=2E (=
Available online under
-  https://github=2Ecom/OpenVPN/openvpn/blob/master/=
doc/man-sections/cipher-negotiation=2Erst)
-
-- Use of a legacy or deprecat=
ed cipher (e=2Eg=2E 64bit block ciphers)
-
-  OpenSSL 3=2E0 no longer suppo=
rts a number of insecure and outdated ciphers in
-  its default configurati=
on=2E Some of these ciphers are known to be vulnerable (SWEET32 attack)=2E
=
-
-  This will typically manifest itself in messages like::
-
-      OpenSS=
L: error:0308010C:digital envelope routines::unsupported
-      Cipher algo=
rithm 'BF-CBC' not found
-      Unsupported cipher in --data-ciphers: BF-CB=
C
-
-  If your OpenSSL distribution comes with the legacy provider (see
-  =
also ``man OSSL_PROVIDER-legacy``), you can load it with
-  ``--providers l=
egacy default``=2E  This will re-enable the old algorithms=2E
-
-- OpenVPN =
version not supporting TLS 1=2E2 or later
-
-  The default in OpenVPN 2=2E6=
 and also in many distributions is now TLS 1=2E2 or
-  later=2E Connecting =
to a peer that does not support this will results in
-  messages like::
-
-=
    TLS error: Unsupported protocol=2E This typically indicates that client=
 and
-    server have no common TLS version enabled=2E This can be caused b=
y mismatched
-    tls-version-min and tls-version-max options on client and=
 server=2E If your
-    OpenVPN client is between v2=2E3=2E6 and v2=2E3=2E2=
 try adding tls-version-min 1=2E0
-    to the client configuration to use T=
LS 1=2E0+ instead of TLS 1=2E0 only
-    OpenSSL: error:0A000102:SSL routin=
es::unsupported protocol
-
-  This can be an OpenVPN 2=2E3=2E6 or earlier v=
ersion=2E ``compat-version 2=2E3=2E0`` will
-  enable TLS 1=2E0 support if =
supported by the OpenSSL distribution=2E Note that
-  on some Linux distrib=
utions enabling TLS 1=2E1 or 1=2E0 is not possible=2E
-
-
-
-Overview of ch=
anges in 2=2E5
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
-New features
-------------
-Client-specific tls-cr=
ypt keys (``--tls-crypt-v2``)
-    ``tls-crypt-v2`` adds the ability to sup=
ply each client with a unique
-    tls-crypt key=2E  This allows large orga=
nisations and VPN providers to profit
-    from the same DoS and TLS stack =
protection that small deployments can
-    already achieve using ``tls-auth=
`` or ``tls-crypt``=2E
-
-ChaCha20-Poly1305 cipher support
-    Added suppo=
rt for using the ChaCha20-Poly1305 cipher in the OpenVPN data
-    channel=
=2E
-
-Improved Data channel cipher negotiation
-    The option ``ncp-ciphe=
rs`` has been renamed to ``data-ciphers``=2E
-    The old name is still acc=
epted=2E The change in name signals that
-    ``data-ciphers`` is the prefe=
rred way to configure data channel
-    ciphers and the data prefix is chos=
en to avoid the ambiguity that
-    exists with ``--cipher`` for the data c=
ipher and ``tls-cipher``
-    for the TLS ciphers=2E
-
-    OpenVPN clients=
 will now signal all supported ciphers from the
-    ``data-ciphers`` optio=
n to the server via ``IV_CIPHERS``=2E OpenVPN
-    servers will select the =
first common cipher from the ``data-ciphers``
-    list instead of blindly =
pushing the first cipher of the list=2E This
-    allows to use a configura=
tion like
-    ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server=
 that
-    prefers ChaCha20-Poly1305 but uses it only if the client support=
s it=2E
-
-    See the data channel negotiation section in the manual for m=
ore details=2E
-
-Removal of BF-CBC support in default configuration:
-    =
By default OpenVPN 2=2E5 will only accept AES-256-GCM and AES-128-GCM as
- =
   data ciphers=2E OpenVPN 2=2E4 allows AES-256-GCM,AES-128-GCM and BF-CBC =
when
-    no --cipher and --ncp-ciphers options are present=2E Accepting BF=
-CBC can be
-    enabled by adding
-
-        data-ciphers AES-256-GCM:AES-=
128-GCM:BF-CBC
-
-    and when you need to support very old peers also
-
- =
       data-ciphers-fallback BF-CBC
-
-    To offer backwards compatibility=
 with older configs an *explicit*
-
-        cipher BF-CBC
-
-    in the co=
nfiguration will be automatically translated into adding BF-CBC
-    to the=
 data-ciphers option and setting data-ciphers-fallback to BF-CBC
-    (as i=
n the example commands above)=2E We strongly recommend to switching
-    aw=
ay from BF-CBC to a more secure cipher=2E
-
-Asynchronous (deferred) authen=
tication support for auth-pam plugin=2E
-    See src/plugins/auth-pam/READM=
E=2Eauth-pam for details=2E
-
-Deferred client-connect
-    The ``--client-=
connect`` option and the connect plugin API allow
-    asynchronous/deferre=
d return of the configuration file in the same way
-    as the auth-plugin=
=2E
-
-Faster connection setup
-    A client will signal in the ``IV_PROTO`=
` variable that it is in pull
-    mode=2E This allows the server to push t=
he configuration options to
-    the client without waiting for a ``PULL_RE=
QUEST`` message=2E The feature
-    is automatically enabled if both client=
 and server support it and
-    significantly reduces the connection setup =
time by avoiding one
-    extra packet round-trip and 1s of internal event =
delays=2E
-
-Netlink support
-    On Linux, if configured without ``--enabl=
e-iproute2``, configuring IP
-    addresses and adding/removing routes is n=
ow done via the netlink(3)
-    kernel interface=2E  This is much faster th=
an calling ``ifconfig`` or
-    ``route`` and also enables OpenVPN to run w=
ith less privileges=2E
-
-    If configured with --enable-iproute2, the ``i=
p`` command is used
-    (as in 2=2E4)=2E  Support for ``ifconfig`` and ``r=
oute`` is gone=2E
-
-Wintun support
-    On Windows, OpenVPN can now use ``=
wintun`` devices=2E  They are faster
-    than the traditional ``tap9`` tun=
/tap devices, but do not provide
-    ``--dev tap`` mode - so the official =
installers contain both=2E  To use
-    a wintun device, add ``--windows-dr=
iver wintun`` to your config
-    (and use of the interactive service is re=
quired as wintun needs
-    SYSTEM privileges to enable access)=2E
-
-IPv6-=
only operation
-    It is now possible to have only IPv6 addresses inside t=
he VPN tunnel,
-    and IPv6-only address pools (2=2E4 always required IPv4=
 config/pools
-    and IPv6 was the "optional extra")=2E
-
-Improved Window=
s 10 detection
-    Correctly log OS on Windows 10 now=2E
-
-Linux VRF supp=
ort
-    Using the new ``--bind-dev`` option, the OpenVPN outside socket ca=
n
-    now be put into a Linux VRF=2E  See the "Virtual Routing and Forward=
ing"
-    documentation in the man page=2E
-
-TLS 1=2E3 support
-    TLS 1=
=2E3 support has been added to OpenVPN=2E  Currently, this requires
-    Op=
enSSL 1=2E1=2E1+=2E
-    The options ``--tls-ciphersuites`` and ``--tls-gro=
ups`` have been
-    added to fine tune TLS protocol options=2E  Most of th=
e improvements
-    were also backported to OpenVPN 2=2E4 as part of the ma=
intainance
-    releases=2E
-
-Support setting DHCP search domain
-    A ne=
w option ``--dhcp-option DOMAIN-SEARCH my=2Eexample=2Ecom`` has been
-    d=
efined, and Windows support for it is implemented (tun/tap only, no
-    wi=
ntun support yet)=2E  Other platforms need to support this via ``--up``
-  =
  script (Linux) or GUI (OSX/Tunnelblick)=2E
-
-per-client changing of ``--=
data-ciphers`` or ``data-ciphers-fallback``
-    from client-connect script=
/dir (NOTE: this only changes preference of
-    ciphers for NCP, but can n=
ot override what the client announces as
-    "willing to accept")
-
-Handl=
e setting of tun/tap interface MTU on Windows
-    If IPv6 is in use, MTU m=
ust be >=3D 1280 (Windows enforces IETF requirements)
-
-Add support for Op=
enSSL engines to access private key material (like TPM)=2E
-
-HMAC based au=
th-token support
-    The ``--auth-gen-token`` support has been improved an=
d now generates HMAC
-    based user token=2E If the optional ``--auth-gen-=
token-secret`` option is
-    used clients will be able to seamlessly recon=
nect to a different server
-    using the same secret file or to the same s=
erver after a server restart=2E
-
-Improved support for pending authenticat=
ion
-    The protocol has been enhanced to be able to signal that
-    the =
authentication should use a secondary authentication
-    via web (like SAM=
L) or a two factor authentication without
-    disconnecting the OpenVPN se=
ssion with AUTH_FAILED=2E The
-    session will instead be stay in a authen=
ticated state and
-    wait for the second factor authentication to complet=
e=2E
-
-    This feature currently requires usage of the managent interface=

-    on both client and server side=2E See the ``management-notes=2Etxt``
=
-    ``client-pending-auth`` and ``cr-response`` commands for more
-    det=
ails=2E
-
-VLAN support
-    OpenVPN servers in TAP mode can now use 802=2E=
1q tagged VLANs
-    on the TAP interface to separate clients into differen=
t groups
-    that can then be handled differently (different subnets / DHC=
P,
-    firewall zones, =2E=2E=2E) further down the network=2E  See the new=

-    options ``--vlan-tagging``, ``--vlan-accept``, ``--vlan-pvid``=2E
-
-=
    802=2E1q tagging on the client side TAP interface is not handled
-    t=
oday (=3D tags are just forwarded transparently to the server)=2E
-
-Suppor=
t building of =2Emsi installers for Windows
-
-Allow unicode search string =
in ``--cryptoapicert`` option (Windows)
-
-Support IPv4 configs with /31 ne=
tmasks now
-    (By no longer trying to configure ``broadcast x=2Ex=2Ex=2Ex=
`` in
-    ifconfig calls, /31 support "just works")
-
-New option ``--bloc=
k-ipv6`` to reject all IPv6 packets (ICMPv6)
-    this is useful if the VPN=
 service has no IPv6, but the clients
-    might have (LAN), to avoid clien=
t connections to IPv6-enabled
-    servers leaking "around" the IPv4-only V=
PN=2E
-
-``--ifconfig-ipv6`` and ``--ifconfig-ipv6-push`` will now accept
-=
    hostnames and do a DNS lookup to get the IPv6 address to use
-
-
-Depre=
cated features
--------------------
-For an up-to-date list of all deprecat=
ed options, see this wiki page:
-https://community=2Eopenvpn=2Enet/openvpn/=
wiki/DeprecatedOptions
-
-- ``ncp-disable`` has been deprecated
-    With t=
he improved and matured data channel cipher negotiation, the use
-    of ``=
ncp-disable`` should not be necessary anymore=2E
-
-- ``inetd`` has been de=
precated
-  This is a very limited and not-well-tested way to run OpenVPN, =
on TCP
-  and TAP mode only, which complicates the code quite a bit for lit=
tle gain=2E
-  To be removed in OpenVPN 2=2E6 (unless users protest)=2E
-
-=
- ``no-iv`` has been removed
-  This option was made into a NOOP option wit=
h OpenVPN 2=2E4=2E  This has now
-  been completely removed=2E
-
-- ``--cli=
ent-cert-not-required`` has been removed
-  This option will now cause serv=
er configurations to not start=2E  Use
-  ``--verify-client-cert none`` ins=
tead=2E
-
-- ``--ifconfig-pool-linear`` has been removed
-  This option is =
removed=2E  Use ``--topology p2p`` or ``--topology subnet``
-  instead=2E
-=

-- ``--compress xxx`` is considered risky and is warned against, see below=
=2E
-
-- ``--key-method 1`` has been removed
-
-
-User-visible Changes
----=
-----------------
-- If multiple connect handlers are used (client-connect,=
 ccd, connect
-  plugin) and one of the handler succeeds but a subsequent f=
ails, the
-  client-disconnect-script is now called immediately=2E Previous=
ly it
-  was called, when the VPN session was terminated=2E
-
-- Support fo=
r building with OpenSSL 1=2E0=2E1 has been removed=2E The minimum
-  suppor=
ted OpenSSL version is now 1=2E0=2E2=2E
-
-- The GET_CONFIG management stat=
e is omitted if the server pushes
-  the client configuration almost immedi=
ately as result of the
-  faster connection setup feature=2E
-
-- ``--compr=
ess`` is nowadays considered risky, because attacks exist
-  leveraging com=
pression-inside-crypto to reveal plaintext (VORACLE)=2E  So
-  by default, =
``--compress xxx`` will now accept incoming compressed
-  packets (for comp=
atibility with peers that have not been upgraded yet),
-  but will not use =
compression outgoing packets=2E  This can be controlled with
-  the new opt=
ion ``--allow-compression yes|no|asym``=2E
-
-- Stop changing ``--txlen`` a=
ways from OS defaults unless explicitly specified
-  in config file=2E  OS =
defaults nowadays are actually larger then what we used
-  to configure, so=
 our defaults sometimes caused packet drops =3D bad performance=2E
-
-- rem=
ove ``--writepid`` pid file on exit now
-
-- plugin-auth-pam now logs via O=
penVPN logging method, no longer to stderr
-  (this means you'll have log m=
essages in syslog or openvpn log file now)
-
-- use ISO 8601 time format fo=
r file based logging now (YYYY-MM-DD hh:mm:dd)
-  (syslog is not affected, =
nor is ``--machine-readable-output``)
-
-- ``--clr-verify`` now loads all C=
RLs if more than one CRL is in the same
-  file (OpenSSL backend only, mbed=
TLS always did that)
-
-- when ``--auth-user-pass file`` has no password, a=
nd the management interface
-  is active, query management interface (inste=
ad of trying console query,
-  which does not work on windows)
-
-- skip ex=
pired certificates in Windows certificate store (``--cryptoapicert``)
-
-- =
``--socks-proxy`` + ``--proto udp*`` will now allways use IPv4, even if
-  =
IPv6 is requested and available=2E  Our SOCKS code does not handle IPv6+UDP=
,
-  and before that change it would just fail in non-obvious ways=2E
-
-- =
TCP listen() backlog queue is now set to 32 - this helps TCP servers that
-=
  receive lots of "invalid" connects by TCP port scanners
-
-- do no longer=
 print OCC warnings ("option mismatch") about ``key-method``,
-  ``keydir``=
, ``tls-auth`` and ``cipher`` - these are either gone now, or
-  negotiated=
, and the warnings do not serve a useful purpose=2E
-
-- ``dhcp-option DNS`=
` and ``dhcp-option DNS6`` are now treated identically
-  (=3D both accept =
an IPv4 or IPv6 address for the nameserver)
-
-
-Maintainer-visible changes=

---------------------------
-- the man page is now in maintained in =2Erst=
 format, so building the openvpn=2E8
-  manpage from a git checkout now req=
uires python-docutils (if this is missing,
-  the manpage will not be built=
 - which is not considered an error generally,
-  but for package builders =
or ``make distcheck`` it is)=2E  Release tarballs
-  contain the openvpn=2E=
8 file, so unless some =2Erst is changed, doc-utils are
-  not needed for b=
uilding=2E
-
-- OCC support can no longer be disabled
-
-- AEAD support is =
now required in the crypto library
-
-- ``--disable-server`` has been remov=
ed from configure (so it is no longer
-  possible to build a client-/p2p-on=
ly OpenVPN binary) - the saving in code
-  size no longer outweighs the ext=
ra maintenance effort=2E
-
-- ``--enable-iproute2`` will disable netlink(3)=
 support, so maybe remove
-  that from package building configs (see above)=

-
-- support building with MSVC 2019
-
-- cmocka based unit tests are now =
only run if cmocka is installed externally
-  (2=2E4 used to ship a local g=
it submodule which was painful to maintain)
-
-- ``--disable-crypto`` confi=
gure option has been removed=2E  OpenVPN is now always
-  built with crypto=
 support, which makes the code much easier to maintain=2E
-  This does not =
affect ``--cipher none`` to do a tunnel without encryption=2E
-
-- ``--disa=
ble-multi`` configure option has been removed
-
-
-
-Overview of changes in=
 2=2E4
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-
-New features
-------------
-Seamless client IP/port float=
ing
-    Added new packet format P_DATA_V2, which includes peer-id=2E If bo=
th the
-    server and client support it, the client sends all data packets=
 in
-    the new format=2E When a data packet arrives, the server identifie=
s peer
-    by peer-id=2E If peer's ip/port has changed, server assumes tha=
t
-    client has floated, verifies HMAC and updates ip/port in internal st=
ructs=2E
-    This allows the connection to be immediately restored, instea=
d of requiring
-    a TLS handshake before the server accepts packets from =
the new client
-    ip/port=2E
-
-Data channel cipher negotiation
-    Data=
 channel ciphers (``--cipher``) are now by default negotiated=2E  If a
-   =
 client advertises support for Negotiable Crypto Parameters (NCP), the
-   =
 server will choose a cipher (by default AES-256-GCM) for the data channel,=

-    and tell the client to use that cipher=2E  Data channel cipher negoti=
ation
-    can be controlled using ``--ncp-ciphers`` and ``--ncp-disable``=
=2E
-
-    A more limited version also works in client-to-server and server=
-to-client
-    scenarios where one of the end points uses a v2=2E4 client =
or server and the
-    other side uses an older version=2E  In such scenari=
os the v2=2E4 side will
-    change to the ``--cipher`` set by the remote s=
ide, if permitted by by
-    ``--ncp-ciphers``=2E  For example, a v2=2E4 cl=
ient with ``--cipher BF-CBC``
-    and ``ncp-ciphers AES-256-GCM:AES-256-CB=
C`` can connect to both a v2=2E3
-    server with ``cipher BF-CBC`` as well=
 as a server with
-    ``cipher AES-256-CBC`` in its config=2E  The other w=
ay around, a v2=2E3 client
-    with either ``cipher BF-CBC`` or ``cipher A=
ES-256-CBC`` can connect to a
-    v2=2E4 server with e=2Eg=2E ``cipher BF-=
CBC`` and
-    ``ncp-ciphers AES-256-GCM:AES-256-CBC`` in its config=2E  Fo=
r this to work
-    it requires that OpenVPN was built without disabling OC=
C support=2E
-
-AEAD (GCM) data channel cipher support
-    The data channe=
l now supports AEAD ciphers (currently only GCM)=2E  The AEAD
-    packet f=
ormat has a smaller crypto overhead than the CBC packet format,
-    (e=2Eg=
=2E 20 bytes per packet for AES-128-GCM instead of 36 bytes per packet
-   =
 for AES-128-CBC + HMAC-SHA1)=2E
-
-ECDH key exchange
-    The TLS control =
channel now supports for elliptic curve diffie-hellmann
-    key exchange (=
ECDH)=2E
-
-Improved Certificate Revocation List (CRL) processing
-    CRLs=
 are now handled by the crypto library (OpenSSL or mbed TLS), instead
-    =
of inside OpenVPN itself=2E  The crypto library implementations are more
- =
   strict than the OpenVPN implementation was=2E  This might reject peer
- =
   certificates that would previously be accepted=2E  If this occurs, OpenV=
PN
-    will log the crypto library's error description=2E
-
-Dualstack rou=
nd-robin DNS client connect
-    Instead of only using the first address of=
 each ``--remote`` OpenVPN
-    will now try all addresses (IPv6 and IPv4) =
of a ``--remote`` entry=2E
-
-Support for providing IPv6 DNS servers
-    A=
 new DHCP sub-option ``DNS6`` is added alongside with the already existing
=
-    ``DNS`` sub-option=2E  This is used to provide DNS resolvers available=
 over
-    IPv6=2E  This may be pushed to clients where `` --up`` scripts a=
nd ``--plugin``
-    can act upon it through the ``foreign_option_<n>`` env=
ironment variables=2E
-
-    Support for the Windows client picking up this=
 new sub-option is added,
-    however IPv6 DNS resolvers need to be config=
ured via ``netsh`` which requires
-    administrator privileges unless the =
new interactive services on Windows is
-    being used=2E  If the interacti=
ve service is used, this service will execute
-    ``netsh`` in the backgro=
und with the proper privileges=2E
-
-New improved Windows Background servic=
e
-    The new OpenVPNService is based on openvpnserv2, a complete rewrite =
of the OpenVPN
-    service wrapper=2E It is intended for launching OpenVPN=
 instances that should be
-    up at all times, instead of being manually l=
aunched by a user=2E OpenVPNService is
-    able to restart individual Open=
VPN processes if they crash, and it also works
-    properly on recent Wind=
ows versions=2E OpenVPNServiceLegacy tends to work poorly,
-    if at all, =
on newer Windows versions (8+) and its use is not recommended=2E
-
-New int=
eractive Windows service
-    The installer starts OpenVPNServiceInteractiv=
e automatically and configures
-    it to start	at system startup=2E
-
-   =
 The interactive Windows service allows unprivileged users to start
-    Op=
enVPN connections in the global config directory (usually
-    C:\\Program =
Files\\OpenVPN\\config) using OpenVPN GUI without any
-    extra configurat=
ion=2E
-
-    Users who belong to the built-in Administrator group or to th=
e
-    local "OpenVPN Administrator" group can also store configuration
-  =
  files under %USERPROFILE%\\OpenVPN\\config for use with the
-    interact=
ive service=2E
-
-redirect-gateway ipv6
-    OpenVPN has now feature parity=
 between IPv4 and IPv6 for redirect
-    gateway including the handling of =
overlapping IPv6 routes with
-    IPv6 remote VPN server address=2E
-
-LZ4 =
Compression and pushable compression
-    Additionally to LZO compression O=
penVPN now also supports LZ4 compression=2E
-    Compression options are no=
w pushable from the server=2E
-
-Filter pulled options client-side: pull-fi=
lter
-    New option to explicitly allow or reject options pushed by the se=
rver=2E
-    May be used multiple times and is applied in the order specifi=
ed=2E
-
-Per-client remove push options: push-remove
-    New option to rem=
ove options on a per-client basis from the "push" list
-    (more fine-grai=
ned than ``--push-reset``)=2E
-
-Http proxy password inside config file
-  =
  Http proxy passwords can be specified with the inline file option
-    ``=
<http-proxy-user-pass>`` =2E=2E ``</http-proxy-user-pass>``
-
-Windows vers=
ion detection
-    Windows version is detected, logged and possibly signall=
ed to server
-    (IV_PLAT_VER=3D<nn> if ``--push-peer-info`` is set on cli=
ent)=2E
-
-Authentication tokens
-    In situations where it is not suitabl=
e to save user passwords on the client,
-    OpenVPN has support for pushin=
g a --auth-token since v2=2E3=2E  This option is
-    pushed from the serve=
r to the client with a token value to be used instead
-    of the users pas=
sword=2E  For this to work, the authentication plug-in would
-    need to i=
mplement this support as well=2E  In OpenVPN 2=2E4 --auth-gen-token
-    is=
 introduced, which will allow the OpenVPN server to generate a random
-    =
token and push it to the client without any changes to the authentication
-=
    modules=2E  When the clients need to re-authenticate the OpenVPN server=
 will
-    do the authentication internally, instead of sending the re-auth=
entication
-    request to the authentication module =2E  This feature is e=
specially
-    useful in configurations which use One Time Password (OTP) a=
uthentication
-    schemes, as this allows the tunnel keys to be renegotiat=
ed regularly without
-    any need to supply new OTP codes=2E
-
-keying-mat=
erial-exporter
-    Keying Material Exporter [RFC-5705] allow additional ke=
ying material to be
-    derived from existing TLS channel=2E
-
-Android pl=
atform support
-    Support for running on Android using Android's VPNServi=
ce API has been added=2E
-    See doc/android=2Etxt for more details=2E Thi=
s support is primarily used in
-    the OpenVPN for Android app (https://gi=
thub=2Ecom/schwabe/ics-openvpn)
-
-AIX platform support
-    AIX platform s=
upport has been added=2E The support only includes tap
-    devices since A=
IX does not provide tun interface=2E
-
-Control channel encryption (``--tls=
-crypt``)
-    Use a pre-shared static key (like the ``--tls-auth`` key) to=
 encrypt control
-    channel packets=2E  Provides more privacy, some obfus=
cation and poor-man's
-    post-quantum security=2E
-
-Asynchronous push re=
ply
-    Plug-ins providing support for deferred authentication can benefit=
 from a more
-    responsive authentication where the server sends PUSH_REP=
LY immediately once
-    the authentication result is ready, instead of wai=
ting for the client to
-    to send PUSH_REQUEST once more=2E  This require=
s OpenVPN to be built with
-    ``=2E/configure --enable-async-push``=2E  T=
his is a compile-time only switch=2E
-
-
-Deprecated features
-------------=
-------
-For an up-to-date list of all deprecated options, see this wiki pa=
ge:
-https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOptions
-
-- =
``--key-method 1`` is deprecated in OpenVPN 2=2E4 and will be removed in v2=
=2E5=2E
-  Migrate away from ``--key-method 1`` as soon as possible=2E  The=
 recommended
-  approach is to remove the ``--key-method`` option from the =
configuration
-  files, OpenVPN will then use ``--key-method 2`` by default=
=2E  Note that this
-  requires changing the option in both the client and =
server side configs=2E
-
-- ``--tls-remote`` is removed in OpenVPN 2=2E4, a=
s indicated in the v2=2E3
-  man-pages=2E  Similar functionality is provide=
d via ``--verify-x509-name``,
-  which does the same job in a better way=2E=

-
-- ``--compat-names`` and ``--no-name-remapping`` were deprecated in Ope=
nVPN 2=2E3
-  and will be removed in v2=2E5=2E  All scripts and plug-ins de=
pending on the old
-  non-standard X=2E509 subject formatting must be updat=
ed to the standardized
-  formatting=2E  See the man page for more informat=
ion=2E
-
-- ``--no-iv`` is deprecated in OpenVPN 2=2E4 and will be removed =
in v2=2E5=2E
-
-- ``--keysize`` is deprecated in OpenVPN 2=2E4 and will be =
removed in v2=2E6
-  together with the support of ciphers with cipher block=
 size less than
-  128-bits=2E
-
-- ``--comp-lzo`` is deprecated in OpenVPN=
 2=2E4=2E  Use ``--compress`` instead=2E
-
-- ``--ifconfig-pool-linear`` ha=
s been deprecated since OpenVPN 2=2E1 and will be
-  removed in v2=2E5=2E  =
Use ``--topology p2p`` instead=2E
-
-- ``--client-cert-not-required`` is de=
precated in OpenVPN 2=2E4 and will be removed
-  in v2=2E5=2E  Use ``--veri=
fy-client-cert none`` for a functional equivalent=2E
-
-- ``--ns-cert-type`=
` is deprecated in OpenVPN 2=2E3=2E18 and v2=2E4=2E  It will be removed
-  =
in v2=2E5=2E  Use the far better ``--remote-cert-tls`` option which replace=
s this
-  feature=2E
-
-
-User-visible Changes
---------------------
-- Whe=
n using ciphers with cipher blocks less than 128-bits,
-  OpenVPN will comp=
lain loudly if the configuration uses ciphers considered
-  weak, such as t=
he SWEET32 attack vector=2E  In such scenarios, OpenVPN will by
-  default =
renegotiate for each 64MB of transported data (``--reneg-bytes``)=2E
-  Thi=
s renegotiation can be disabled, but is HIGHLY DISCOURAGED=2E
-
-- For cert=
ificate DNs with duplicate fields, e=2Eg=2E "OU=3Done,OU=3Dtwo", both field=
s
-  are now exported to the environment, where each second and later occur=
rence
-  of a field get _$N appended to it's field name, starting at N=3D1=
=2E  For the
-  example above, that would result in e=2Eg=2E X509_0_OU=3Don=
e, X509_0_OU_1=3Dtwo=2E
-  Note that this breaks setups that rely on the fa=
ct that OpenVPN would
-  previously (incorrectly) only export the last occu=
rrence of a field=2E
-
-- ``proto udp`` and ``proto tcp`` now use both IPv4=
 and IPv6=2E The new
-  options ``proto udp4`` and ``proto tcp4`` use IPv4 =
only=2E
-
-- ``--sndbuf`` and ``--recvbuf`` default now to OS defaults inst=
ead of 64k
-
-- OpenVPN exits with an error if an option has extra paramete=
rs;
-  previously they were silently ignored
-
-- ``--tls-auth`` always req=
uires OpenVPN static key files and will no
-  longer work with free form fi=
les
-
-- ``--proto udp6/tcp6`` in server mode will now try to always listen=
 to
-  both IPv4 and IPv6 on platforms that allow it=2E Use ``--bind ipv6on=
ly``
-  to explicitly listen only on IPv6=2E
-
-- Removed ``--enable-passwo=
rd-save`` from configure=2E This option is now
-  always enabled=2E
-
-- St=
ricter default TLS cipher list (override with ``--tls-cipher``), that now
-=
  also disables:
-
-  * Non-ephemeral key exchange using static (EC)DH keys=

-  * DSS private keys
-
-- mbed TLS builds: changed the tls_digest_N value=
s exported to the script
-  environment to be equal to the ones exported by=
 OpenSSL builds, namely
-  the certificate fingerprint (was the hash of the=
 'to be signed' data)=2E
-
-- mbed TLS builds: minimum RSA key size is now =
2048 bits=2E  Shorter keys will
-  not be accepted, both local and from the=
 peer=2E
-
-- ``--connect-timeout`` now specifies the timeout until the fir=
st TLS packet
-  is received (identical to ``--server-poll-timeout``) and t=
his timeout now
-  includes the removed socks proxy timeout and http proxy =
timeout=2E
-
-  In ``--static`` mode ``connect-timeout`` specifies the time=
out for TCP and
-  proxy connection establishment
-
-- ``--connect-retry-ma=
x`` now specifies the maximum number of unsuccessful
-  attempts of each re=
mote/connection entry before exiting=2E
-
-- ``--http-proxy-timeout`` and t=
he static non-changeable socks timeout (5s)
-  have been folded into a "uni=
fied" ``--connect-timeout`` which covers all
-  steps needed to connect to =
the server, up to the start of the TLS exchange=2E
-  The default value has=
 been raised to 120s, to handle slow http/socks
-  proxies graciously=2E  T=
he old "fail TCP fast" behaviour can be achieved by
-  adding "``--connect-=
timeout 10``" to the client config=2E
-
-- ``--http-proxy-retry`` and ``--s=
ock-proxy-retry`` have been removed=2E Proxy connections
-  will now behave=
 like regular connection entries and generate a USR1 on failure=2E
-
-- ``-=
-connect-retry`` gets an optional second argument that specifies the maximu=
m
-  time in seconds to wait between reconnection attempts when an exponent=
ial
-  backoff is triggered due to repeated retries=2E Default =3D 300 seco=
nds=2E
-
-- Data channel cipher negotiation (see New features section) can =
override
-  ciphers configured in the config file=2E  Use ``--ncp-disable``=
 if you do not want
-  this behavior=2E
-
-- All tun devices on all platfor=
ms are always considered to be IPv6
-  capable=2E The ``--tun-ipv6`` option=
 is ignored (behaves like it is always
-  on)=2E
-
-- On the client side re=
cursively routed packets, which have the same destination
-  as the VPN ser=
ver, are dropped=2E This can be disabled with
-  --allow-recursive-routing =
option=2E
-
-- On Windows, when the ``--register-dns`` option is set, OpenV=
PN no longer
-  restarts the ``dnscache`` service - this had unwanted side =
effects, and
-  seems to be no longer necessary with currently supported Wi=
ndows versions=2E
-
-- If no flags are given, and the interactive Windows s=
ervice is used, "def1"
-  is implicitly set (because "delete and later rein=
stall the existing
-  default route" does not work well here)=2E  If not us=
ing the service,
-  the old behaviour is kept=2E
-
-- OpenVPN now reloads a=
 CRL only if the modication time or file size has
-  changed, instead of fo=
r each new connection=2E  This reduces the connection
-  setup time, in par=
ticular when using large CRLs=2E
-
-- OpenVPN now ships with more up-to-dat=
e systemd unit files which take advantage
-  of the improved service manage=
ment as well as some hardening steps=2E  The
-  configuration files are pic=
ked up from the /etc/openvpn/server/ and
-  /etc/openvpn/client/ directorie=
s (depending on unit file)=2E  This also avoids
-  these new unit files and=
 how they work to collide with older pre-existing
-  unit files=2E
-
-- Usi=
ng ``--no-iv`` (which is generally not a recommended setup) will
-  require=
 explicitly disabling NCP with ``--disable-ncp``=2E  This is
-  intentional=
 because NCP will by default use AES-GCM, which requires
-  an IV - so we w=
ant users of that option to consciously reconsider=2E
-
-
-Maintainer-visib=
le changes
---------------------------
-- OpenVPN no longer supports buildi=
ng with crypto support, but without TLS
-  support=2E  As a consequence, OP=
ENSSL_CRYPTO_{CFLAGS,LIBS} and
-  OPENSSL_SSL_{CFLAGS,LIBS} have been merge=
d into OPENSSL_{CFLAGS,LIBS}=2E  This
-  is particularly relevant for maint=
ainers who build their own OpenSSL library,
-  e=2Eg=2E when cross-compilin=
g=2E
-
-- Linux distributions using systemd is highly encouraged to ship th=
ese new unit
-  files instead of older ones, to provide a unified behaviour=
 across systemd
-  based Linux distributions=2E
-
-- With OpenVPN 2=2E4, th=
e project has moved over to depend on and actively use
-  the official C99 =
standard (-std=3Dc99)=2E  This may fail on some older compiler/libc
-  head=
er combinations=2E  In most of these situations it is recommended to
-  use=
 -std=3Dgnu99 in CFLAGS=2E  This is known to be needed when doing
-  i386/i=
686 builds on RHEL5=2E
-
-
-Version 2=2E4=2E5
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-New features
-------------
-- The new option ``--tls-cert-p=
rofile`` can be used to restrict the set of
-  allowed crypto algorithms in=
 TLS certificates in mbed TLS builds=2E  The
-  default profile is 'legacy'=
 for now, which allows SHA1+, RSA-1024+ and any
-  elliptic curve certifica=
tes=2E  The default will be changed to the 'preferred'
-  profile in the fu=
ture, which requires SHA2+, RSA-2048+ and any curve=2E
-
-
-Version 2=2E4=
=2E3
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-New features
-------------=

-- Support building with OpenSSL 1=2E1 now (in addition to older versions)=

-
-- On Win10, set low interface metric for TAP adapter when block-outside=
-dns
-  is in use, to make Windows prefer the TAP adapter for DNS queries
-=
  (avoiding large delays)
-
-
-Security
---------
-- CVE-2017-7522: Fix ``-=
-x509-track`` post-authentication remote DoS
-  A client could crash a v2=
=2E4+ mbedtls server, if that server uses the
-  ``--x509-track`` option an=
d the client has a correct, signed and unrevoked
-  certificate that contai=
ns an embedded NUL in the certificate subject=2E
-  Discovered and reported=
 to the OpenVPN security team by Guido Vranken=2E
-
-- CVE-2017-7521: Fix p=
ost-authentication remote-triggerable memory leaks
-  A client could cause =
a server to leak a few bytes each time it connects to the
-  server=2E  Tha=
t can eventually cause the server to run out of memory, and thereby
-  caus=
ing the server process to terminate=2E Discovered and reported to the
-  Op=
enVPN security team by Guido Vranken=2E  (OpenSSL builds only=2E)
-
-- CVE-=
2017-7521: Fix a potential post-authentication remote code execution
-  att=
ack on servers that use the ``--x509-username-field`` option with an X=2E50=
9
-  extension field (option argument prefixed with ``ext:``)=2E  A client =
that can
-  cause a server to run out-of-memory (see above) might be able t=
o cause the
-  server to double free, which in turn might lead to remote co=
de execution=2E
-  Discovered and reported to the OpenVPN security team by =
Guido Vranken=2E
-  (OpenSSL builds only=2E)
-
-- CVE-2017-7520: Pre-authen=
tication remote crash/information disclosure for
-  clients=2E If clients u=
se a HTTP proxy with NTLM authentication (i=2Ee=2E
-  ``--http-proxy <serve=
r> <port> [<authfile>|'auto'|'auto-nct'] ntlm2``),
-  a man-in-the-middle a=
ttacker between the client and the proxy can cause
-  the client to crash o=
r disclose at most 96 bytes of stack memory=2E The
-  disclosed stack memor=
y is likely to contain the proxy password=2E If the
-  proxy password is no=
t reused, this is unlikely to compromise the security
-  of the OpenVPN tun=
nel itself=2E  Clients who do not use the ``--http-proxy``
-  option with n=
tlm2 authentication are not affected=2E
-
-- CVE-2017-7508: Fix remotely-tr=
iggerable ASSERT() on malformed IPv6 packet=2E
-  This can be used to remot=
ely shutdown an openvpn server or client, if
-  IPv6 and ``--mssfix`` are e=
nabled and the IPv6 networks used inside the VPN
-  are known=2E
-
-- Fix n=
ull-pointer dereference when talking to a malicious http proxy
-  that retu=
rns a malformed ``Proxy-Authenticate:`` headers for digest auth=2E
-
-- Fix=
 overflow check for long ``--tls-cipher`` option
-
-- Windows: Pass correct=
 buffer size to ``GetModuleFileNameW()``
-  (OSTIF/Quarkslabs audit, findin=
g 5=2E6)
-
-
-User-visible Changes
---------------------
-- ``--verify-hash=
`` can now take an optional flag which changes the hashing
-  algorithm=2E =
It can be either SHA1 or SHA256=2E  The default if not provided is
-  SHA1 =
to preserve backwards compatibility with existing configurations=2E
-
-- Re=
strict the supported ``--x509-username-field`` extension fields to subjectA=
ltName
-  and issuerAltName=2E  Other extensions probably didn't work anywa=
y, and would
-  cause OpenVPN to crash when a client connects=2E
-
-
-Bugfi=
xes
---------
-- Fix fingerprint calculation in mbed TLS builds=2E  This me=
ans that mbed TLS users
-  of OpenVPN 2=2E4=2E0, v2=2E4=2E1 and v2=2E4=2E2 =
that rely on the values of the
-  ``tls_digest_*`` env vars, or that use ``=
--verify-hash`` will have to change
-  the fingerprint values they check ag=
ainst=2E  The security impact of the
-  incorrect calculation is very minim=
al; the last few bytes (max 4, typically
-  4) are not verified by the fing=
erprint=2E  We expect no real-world impact,
-  because users that used this=
 feature before will notice that it has suddenly
-  stopped working, and us=
ers that didn't will notice that connection setup
-  fails if they specify =
correct fingerprints=2E
-
-- Fix edge case with NCP when the server sends a=
n empty PUSH_REPLY message
-  back, and the client would not initialize it'=
s data channel crypto layer
-  properly (trac #903)
-
-- Fix SIGSEGV on una=
ligned buffer access on OpenBSD/Sparc64
-
-- Fix TCP_NODELAY on OpenBSD
-
-=
- Remove erroneous limitation on max number of args for ``--plugin``
-
-- F=
ix NCP behaviour on TLS reconnect (Server would not send a proper
-  "ciphe=
r =2E=2E=2E" message back to the client, leading to client and server
-  us=
ing different ciphers) (trac #887)
-
-
-Version 2=2E4=2E2
-=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-
-Bugfixes
---------
-- Fix memory leak introduce=
d in OpenVPN 2=2E4=2E1: if ``--remote-cert-tls`` is
-  used, we leaked some=
 memory on each TLS (re)negotiation=2E
-
-
-Security
---------
-- Fix a pre=
-authentication denial-of-service attack on both clients and
-  servers=2E =
 By sending a too-large control packet, OpenVPN 2=2E4=2E0 or v2=2E4=2E1 can=

-  be forced to hit an ASSERT() and stop the process=2E  If ``--tls-auth``=
 or
-  ``--tls-crypt`` is used, only attackers that have the ``--tls-auth``=
 or
-  ``--tls-crypt`` key can mount an attack=2E
-  (OSTIF/Quarkslab audit=
 finding 5=2E1, CVE-2017-7478)
-
-- Fix an authenticated remote DoS vulnera=
bility that could be triggered by
-  causing a packet id roll over=2E  An a=
ttack is rather inefficient; a peer
-  would need to get us to send at leas=
t about 196 GB of data=2E
-  (OSTIF/Quarkslab audit finding 5=2E2, CVE-2017=
-7479)
-
-
-Version 2=2E4=2E1
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- `=
`--remote-cert-ku`` now only requires the certificate to have at least the
=
-  bits set of one of the values in the supplied list, instead of requiring=
 an
-  exact match to one of the values in the list=2E
-- ``--remote-cert-t=
ls`` now only requires that a keyUsage is present in the
-  certificate, an=
d leaves the verification of the value up to the crypto
-  library, which h=
as more information (i=2Ee=2E the key exchange method in use)
-  to verify =
that the keyUsage is correct=2E
-- ``--ns-cert-type`` is deprecated=2E  Use=
 ``--remote-cert-tls`` instead=2E
-  The nsCertType x509 extension is very =
old, and barely used=2E
-  ``--remote-cert-tls`` uses the far more common k=
eyUsage and extendedKeyUsage
-  extension instead=2E  Make sure your certif=
icates carry these to be able to
-  use ``--remote-cert-tls``=2E
-
diff --g=
it a/Makefile=2Eam b/Makefile=2Eam
index 2df7eea=2E=2Ef96b945 100644
--- a/=
Makefile=2Eam
+++ b/Makefile=2Eam
@@ -59,7 +59,7 @@
 dist_doc_DATA =3D \
 	=
README \
 	README=2Embedtls \
-	Changes=2Erst \
+	Changes=2Emd \
 	COPYRIGH=
T=2EGPL \
 	COPYING
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1767?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I8887fa7ccf407d727c2b59397000149e45487e13
Gerrit-Change-Number: 1767
Ger=
rit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>

--R7Q4Skx7Hfc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Convert Changes=2Erst to Markdown<br><br>Since all of our release publ=
ishing infrastructure now uses<br>Markdown (Wiki, Forums, Github), preparin=
g this documentation<br>in rst just creates more work for the people creati=
ng the<br>release (so often me ;))=2E<br><br>This conversion to Markdown tr=
ies to also fix several instances<br>of weird formatting=2E But I tried to =
limit myself to not go<br>too much in the direction of actually &quot;impro=
ving&quot; the text=2E<br><br>Change-Id: I8887fa7ccf407d727c2b59397000149e4=
5487e13<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>---<br>A Changes=2Emd<br>D Changes=2Erst<br>M Makefile=2Eam<br>3 files =
changed, 1,423 insertions(+), 1,461 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/1767/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>new file =
mode 100644</span><br><span>index 0000000=2E=2E7590ac9</span><br><span>--- =
/dev/null</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -0,0 +1,142=
2 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Overview of c=
hanges in 2=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Overview of changes i=
n 2=2E7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+## New features</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+**Multi-socket support for servers**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+OpenVPN servers now can listen on multiple sockets at th=
e same time=2E Multiple</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+`--local` statements in the configuration can be used to configure this=
=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+way the sam=
e server can e=2Eg=2E listen for UDP and TCP connections at the same</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+time, or listen on multipl=
e addresses and/or ports=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Client im=
plementations for DNS options sent by server for Linux/BSD/macOS**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Linux, BSD and macOS versions of OpenVPN now sh=
ip with a per-platform default</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+`--dns-updown` script that implements proper handling of DNS con=
figuration sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+by t=
he server=2E The scripts should work on systems that use `systemd` or</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+`resolveconf` to manage t=
he DNS setup, as well as raw `/etc/resolv=2Econf` files=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+However, the exact features supporte=
d will depend on the configuration method=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+On Linux and MacOS this should usually make split-=
DNS configurations supported</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+out-of-the-box now=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Note tha=
t this new script will not be used by default if a `--up` script is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+already in use to reduce pr=
oblems with backwards compatibility=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
See documentation for `--dns-updown` and `--dns` for more details=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+**New client implementation for DNS options s=
ent by server for Windows**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The Windows=
 client now uses NRPT (Name Resolution Policy Table) to handle DNS</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+configurations=2E This adds =
support for split-DNS and DNSSEC and improves the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+compatbility with local DNS resolvers=2E Requ=
ires the interactive service=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**On Wi=
ndows the `block-local` flag is now enforced with WFP filters=2E**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+The `block-local` flag to `--redirect-gateway` =
and `--redirect-private` is now</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+also enforced via the Windows Firewall, making sure packets can=
&#39;t be sent to the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+local network=2E This provides stronger protection against TunnelCrack-st=
yle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+attacks=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+**Windows network adapters are now generated=
 on demand**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+This means that on systems=
 that run multiple OpenVPN connections at the same</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+time the users don&#39;t need to manually cr=
eate enough network adapters anymore (in</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+addition to the ones created by the installer)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**Windows automatic service now runs as a=
n unpriviledged user**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+All tasks that n=
eed privileges are now delegated to the interactive service=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+**NOTE** this has the risk of br=
eaking existing setups if the Windows</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+certificate store is used (cryptoapi), and the certificat=
es are not readable for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+`NT SERVICE\OpenVPNService`=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Su=
pport for new version of Linux DCO module**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+The OpenVPN DCO module has been merged into the Linux kernel as of 6=
=2E16=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+requir=
ed some API changes and OpenVPN 2=2E7 only supports the new API=2E The new<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+module is called `ov=
pn`=2E Out-of-tree builds for older kernels are available from</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&lt;https://github=2Ecom/OpenVPN=
/ovpn-backports&gt;=2E Please see the release</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+announcements for further information=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+**Support for server mode in win-dco driver**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+On Windows the win-dco driver can now be=
 used in server setups=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Support for=
 TLS client floating in DCO implementations**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+The kernel modules will detect clients floating to a new IP address =
and notify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+userland =
so both data packets (kernel) and TLS packets (sent by userland) can</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+reach the new client IP=2E=
 (Actual support depends on recent-enough kernel</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+implementation)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+**Enforcement of AES-GCM usage limit**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+OpenVPN will now enforce the usage limits on AES-GCM with the same</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+confidentiality margin=
 as TLS 1=2E3 does=2E This mean that renegotiation will be</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+triggered after roughly 2^28 to 2^31=
 packets depending of the packet size=2E More</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+details about usage limit of AES-GCM can be found=
 here:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&lt;https://datatracker=2Eietf=
=2Eorg/doc/draft-irtf-cfrg-aead-limits/&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+**Epoch data keys and packet format**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+This introduces the epoch data format for AEAD data channel ciphers in =
TLS mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ciphers=2E =
This new data format has a number of improvements over the standard</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;DATA_V2&quot; format=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- AEAD tag at the end of packet whi=
ch is more hardware implementation friendly</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+- Automatic key switchover when cipher usage limits=
 are hit, similar to the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  epoch data keys in (D)TLS 1=2E3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+- 64 bit instead of 32 bit packet ids to allow the data =
channel to be ready for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  10 GBit/s without having frequent renegotiation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- IV constructed with XOR instead of conc=
atenation to not have (parts) of the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  real IV on the wire</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
**Support for Epoch data channel on Windows, using the win-dco driver (2=2E=
8=2E0+)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+**Default ciphers in `--data-=
ciphers`**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Ciphers in `--data-ciphers` =
can contain the string DEFAULT that is replaced by</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+the default ciphers used by OpenVPN, making =
it easier to add an allowed cipher</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+without having to spell out the default ciphers=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+**TLS alerts**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+OpenVPN 2=2E7 will send out TLS alerts to peers informing them if the TL=
S session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shuts down=
 or when the TLS implementation informs the peer about an error in the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+TLS session (e=2Eg=2E mi=
smatching TLS versions)=2E This improves the user experience</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+as the client shows an error inste=
ad of running into a timeout when the server</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+just stops responding completely=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+**Support for tun/tap via unix domain socket and lwip=
ovpn support**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+To allow better testing =
and emulating a full client with a full network stack</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OpenVPN now allows a program executed to =
provide a tun/tap device instead of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+opening a device=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The=
 co-developed lwipovpn program based on lwIP stack allows to simulate full =
IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stack=2E An OpenV=
PN client using `--dev-node unix:/path/to/lwipovpn` can emulate a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+full client that can be pinge=
d, can serve a website and more without requiring</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+any elevated permission=2E This can make test=
ing OpenVPN much easier=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+For more det=
ails see [lwipovpn on Github](https://github=2Ecom/OpenVPN/lwipovpn)=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**Allow overriding username with `--overr=
ide-username`**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+This is intended to all=
ow using `--auth-gen-token` in scenarios where the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+clients use certificates and multi-factor au=
thentication=2E This will also</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+generate a `push &quot;auth-token-user newusername&quot;` direct=
ive in push replies=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**`--port-share`=
 now properly supports IPv6**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Issues wi=
th logging of IPv6 addresses were fixed=2E The feature now allows IPv6</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+connections towards the =
proxy receiver=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Support for Haiku O=
S**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**TLS1=2E3 support with mbedTLS (re=
quires mbedTLS &gt;=3D 3=2E6=2E4)**</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**P=
USH_UPDATE client support**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+It is now p=
ossible to update parts of the client-side configuration (IP address,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+routes, MTU, DNS) by send=
ing a new server-to-client control message,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+`PUSH_UPDATE,&lt;options&gt;`=2E See also:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+&lt;https://openvpn=2Egithub=
=2Eio/openvpn-rfc/openvpn-wire-protocol=2Ehtml&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+NOTE: PUSH_UPDATE client support is currently disabled if DCO i=
s active (on all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pla=
tforms)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+**PUSH_UPDATE server support=
 (minimal)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+New management interface c=
ommands `push-update-broad` and `push-update-cid` to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send PUSH_UPDATE option updates to all cl=
ients (&quot;there is a new DNS server&quot;) or</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+only a specific client ID (&quot;privileges ha=
ve changed, here&#39;s a new IP address&quot;)=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+See doc/management-notes=2Etxt</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+NOTE: PUSH_UPDATE server support is currently disabled if DCO is active<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+(on all platforms)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**Support for user-defined routing =
tables on Linux**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+See the `--route-tabl=
e` option in the manpage</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**PQE support =
for WolfSSL**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Two new environment varia=
bles have been introduced to communicate desired</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+default gateway redirection to plugins like Ne=
twork Manager,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`rout=
e_redirect_gateway_ipv4` and `route_redirect_gateway_ipv6`=2E See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;Environmental Varia=
bles&quot; section in the man page</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Im=
proved logging of service events/errors to event log on Windows=2E**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+**Improved &quot;Recursive Routing&quot; chec=
k**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+The check is now more granular, and=
 will only drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pack=
ets-in-tunnel if destination IP, protocol and port matches with those neede=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to reach the VPN s=
erver=2E With that change, you can now use policies that direct</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+&quot;everything that is not Op=
enVPN&quot; into the tunnel, and have IP packets to the VPN</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+server address arrive as expected (=
no such policies are currently installed by</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+OpenVPN) (GH: OpenVPN/openvpn#669)=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+**COPYING: license details only relevant to our Wind=
ows installers have</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
been updated and moved to the openvpn-build repo**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+**Improved BYTECOUNT support**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+More strictly adhere to timing interval requested, correctly support cl=
ient and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+server coun=
ters with Linux and Windows DCO offloading=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+**Improve compatibility with OpenSSL 3=2E6=2E0 (do not fail t_lpback=
 selftest)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+**New option `--tls-crypt-=
v2-max-age n` to check tls-crypt-v2 timestamps**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+When a client is older than n days or has no timestamp, the serve=
r will reject</span><br><span style=3D"color: hsl(120, 100%, 40%);">+it=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+**mbedTLS 4 support has been added=2E**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Note that with mbedTLS 4 algorithms ne=
ed to be translated to mbedTLS 4 internal</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+IDs by OpenVPN, and some names might be missing=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+## Deprecated features</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+**`secret` support has been removed (by default)=2E**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static key mode (non-TLS) is no longer co=
nsidered &quot;good and secure enough&quot; for</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+today&#39;s requirements=2E Use TLS mode instea=
d=2E If deploying a PKI CA is considered</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+&quot;too complicated&quot;, using `--peer-fingerprint=
` makes TLS mode about as easy as</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+using `--secret`=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This =
mode can still be enabled by using</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+`--allow-deprecated-insecure-static-crypto` but will be remo=
ved in OpenVPN 2=2E8=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Support for w=
intun Windows driver has been removed=2E**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+OpenVPN 2=2E6 added support for the new dco-win driver, so it supported=
 three</span><br><span style=3D"color: hsl(120, 100%, 40%);">+different dev=
ice drivers: dco-win, wintun, and tap-windows6=2E OpenVPN 2=2E7 now</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+drops the support for wintu=
n driver=2E By default all modern configs should be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+supported by dco-win driver=2E In all oth=
er cases OpenVPN will fall back</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+automatically to tap-windows6 driver=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+**NTLMv1 authentication support for HTTP proxies has been re=
moved=2E**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+This is considered an insecu=
re method of authentication that uses obsolete</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+crypto algorithms=2E NTLMv2 support is still ava=
ilable, but will be removed in a</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+future release=2E When configured to authenticate with NTLMv1 =
(`ntlm` keyword in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`=
--http-proxy`) OpenVPN will try NTLMv2 instead=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+**`persist-key` option has been enabled by default=2E**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+All the keys will be kept in memory across rest=
art=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+**OpenSSL 1=2E0=2E2 support has =
been removed=2E**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+Support for building =
with OpenSSL 1=2E0=2E2 has been removed=2E The minimum supported</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+OpenSSL version is now 1=2E1=
=2E0=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+**mbedTLS 2=2Ex support has bee=
n removed**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Support for building with m=
bedTLS 2=2Ex has been removed (it is out of support</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+since March 2025, and the necessary compa=
tibility code is making maintenance and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+support for mbedTLS 4=2Ex hard)=2E The minimum supporte=
d mbedTLS version is now</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+3=2E2=2E1=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Compression on send=
 has been removed=2E**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN 2=2E7 wi=
ll never compress data before sending=2E Decompression of received</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+data is still supported=2E `=
--allow-compression yes` is now an alias for</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+`--allow-compression asym`=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+**`--memstats` feature removed**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+The `--memstats` option was largely undocumented and there is no =
known user of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+this f=
eature=2E This feature provided very limited statistics (number of users,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+link bytes read/writt=
en) and we do not except any usage because of this=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Using `--push` in a mode that is not `--mode server` will no=
w print a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clear warn=
ing that this is an unsupported operation and might cause negotiation</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+failures=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+`--reneg-bytes` and `--reneg-packets` do not work in=
 DCO mode, and will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
now print an appropriate warning=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On-=
connect resolving of `--remote` addresses in `--tcp-server` mode</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+was not working since 2=2E4, s=
o the code was completely removed=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+##=
 User-visible Changes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Default for `--=
topology` changed to `subnet` for `--mode server`=2E Previous</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  releases always used `net30` as=
 default=2E This only affects configs with</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  `--mode server` or `--server` (the latter implies =
the former), and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `=
--dev tun`, and only if IPv4 is enabled=2E Note that this changes the seman=
tics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of `--ifconfi=
g`, so if you have manual settings for that in your config but</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  not set `--topology` your conf=
ig might fail to parse with the new version=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Just adding `--topology net30` to the config s=
hould fix the problem=2E By</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  default `--topology` is pushed from server to client=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- `--x509-username-field` wil=
l no longer automatically convert fieldnames to</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  uppercase=2E This was deprecated since OpenVP=
N 2=2E4, and has now been removed=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- `--dh none` is now the default if `--dh` is not specifie=
d=2E Modern TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  im=
plementations will prefer ECDH and other more modern algorithms anyway=2E A=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  finite field Di=
ffie Hellman is in the proces of being deprecated (see</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  draft-ietf-tls-deprecate-obsolete-kex)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--lport 0` does =
not imply `--bind` anymore=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+- `--redirect-gateway` now works correctly if the VPN remote is n=
ot reachable by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  th=
e default gateway=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- `--show-gateway` now supports querying the gateway for IPv4 addresses=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--static-challen=
ge` option now has a third parameter `format` that can change</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  how password and challenge resp=
onse should be combined=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- `--key` and `--cert` now accept URIs implemented in OpenSSL 3 as w=
ell as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  optional Op=
enSSL 3 providers loaded using `--providers` option=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+- `--cryptoapicert` now supports issuer =
name as well as Windows CA template name</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  or OID as selector string=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- TLS handshake debugging information con=
tains much more details now when using</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  recent versions of OpenSSL=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- The `IV_PLAT_VER` variable sent by Windows=
 clients now contains the full</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  Windows build version to make it possible to determine the Win=
dows 10 or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Windows=
 11 version used=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- The `--windows-driver` option to select between various windows drivers w=
ill</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  no longer do a=
nything - it&#39;s kept so existing configs will not become invalid,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  but it is ignored with a=
 warning=2E The default is now `ovpn-dco` if all options</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  used are compatible with DCO, with a=
 fallback to `tap-windows6`=2E To force TAP</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  (for example because a server pushes DCO incompat=
ible options), use the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  `--disable-dco` option=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- Apply more checks to incoming TLS handshake packets before cre=
ating new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  state - =
namely, verify message ID / acked ID for &quot;valid range for an initial</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  packet&quot;=2E Thi=
s fixes a problem with clients that float very early but send</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  control channel packet from the=
 pre-float IP (Github: OpenVPN/openvpn#704)=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- Use of `--dh dh2048=2Epem` in all sample confi=
gs has been replaced with</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  `--dh none`=2E The `dh2048=2Epem` file has been removed=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+- The startup delay in `t_cl=
ient=2Esh` has been reduced from 3s to 1s, making a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  noticeable difference for setups with m=
any tests=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Chang=
ed from using `uncrustify` for code formatting and pre-commit checks to</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  `clang-format`=2E Thi=
s reformatted quite a bit of code, and requires that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  regular committers change their pre-com=
mit checks accordingly=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- On Linux, on interfaces where applicable, OpenVPN explicitly config=
ures the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  broadcast=
 address again=2E This was dropped for 2=2E6=2E0 &quot;because computers ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  smart and can do=
 it themselves&quot;, but the kernel netlink interface isn&#39;t, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  will install &quot;0=2E=
0=2E0=2E0&quot;=2E This does not normally matter, but for broadcast-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  applications that g=
et the address to use from &quot;ifconfig&quot;, this change repairs</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  functionality (this has =
been backported to 2=2E6=2E15, but is not in earlier 2=2E6</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  versions)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- `max-routes-per-client 0` used to be si=
lently upgraded to `1`=2E This now</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  produces an error=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- `ifconfig` and `ifconfig-ipv6` values are now stored in=
 pre-connect options</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  cache, and will be restored to pre-connect values on reconnects if the s=
erver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  stops pushin=
g the respective option=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- `tapctl=2Eexe` helper binary on Windows has been reworked to impro=
ve help texts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (mak=
ing clear that it can not only do TAP-Adapters but Win-DCO as well), add</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  printing of the hwid=
 to all adapter outputs, and change the default adapter</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  type created to `ovpn-dco`=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- The default for `multihom=
e` egress interface handling has changed=2E 2=2E7=2E0 will</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  default to ipi_ifindex=3D0, that i=
s, leave the decision to the routing/policy</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  setup of the operating system=2E The pre-2=2E7 be=
haviour (force egress =3D ingress</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  interface) can be achieved with the new `--multihome same-i=
nterface`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sub-opti=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Windows `ope=
nvpn=2Eexe` binary manifest now sets code page UTF8 - which has no</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  direct effect on OpenVPN i=
tself, but this repairs OpenSSL file loading for</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  key/cert files with non-ASCII characters in =
their file names (GH:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  OpenVPN/openvpn#920)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+- The `test-crypto` option no longer requires a `--secret` argument=
 and will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  automati=
cally generate a random key=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- The configure-time option `--enable-x509-alt-username` is no l=
onger</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  conditional,=
 and always-on (GH: OpenVPN/openvpn#917)=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+## Deprecated features</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**`--opt-ve=
rify` feature removed**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This option was=
 already deprecated and it is now being converted to a no-op=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Using this option will only pri=
nt a warning=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Overview of changes i=
n 2=2E6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+## Project changes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+We want to deprecate our old Trac bug tracking syst=
em=2E Please report any issues</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+with this release in GitHub instead: &lt;https://github=2Ecom/Op=
enVPN/openvpn/issues&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## New feature=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+**Support unlimited number of connect=
ion entries and remote entries**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**New =
management commands to enumerate and list remote entries**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Use `remote-entry-count` and `remote-entry-get` command=
s from the management</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+interface to get the number of remote entries and the entries themselves=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**Keying Material Exporters (RFC 57=
05) based key generation**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+As part of t=
he cipher negotiation OpenVPN will automatically prefer the RFC5705</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+based key material generati=
on to the current custom OpenVPN PRF=2E This feature</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+requires OpenSSL or mbed TLS 2=2E18+=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+**Compatibility with OpenSSL in FIPS mod=
e**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+OpenVPN will now work with OpenSSL =
in FIPS mode=2E Note, no effort has been made</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+to check or implement all the requirements/recomm=
endation of FIPS 140-2=2E This</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+just allows OpenVPN to be run on a system that be configured Ope=
nSSL in FIPS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mode=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+`mlock` will now check if enough memlo=
ck-able memory has been reserved,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+and if less than 100MB RAM are available, use setrlimit() to =
upgrade the limit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+See Trac #1390=2E Not available on OpenSolaris=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+**Certificate pinning/verify peer fingerprint**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+The `--peer-fingerprint` option has been introduced to=
 give users an easy to use</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+alternative to the `tls-verify` for matching the fingerprint of the =
peer=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option t=
akes use a number of allowed SHA256 certificate fingerprints=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+See the man page section &quot;Small OpenVPN setup=
 with peer-fingerprint&quot; for a</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tutorial on how to use this feature=2E This is also availabl=
e online under</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;h=
ttps://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/example-fi=
ngerprint=2Erst&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**TLS mode with sel=
f-signed certificates**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+When `--peer-fi=
ngerprint` is used, the `--ca` and `--capath` option become</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+optional=2E This allows for small O=
penVPN setups without setting up a PKI with</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+Easy-RSA or similar software=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+**Deferred auth support for scripts**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+The `--auth-user-pass-verify` script supports now deferred =
authentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Pending auth suppor=
t for plugins and scripts**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Both auth p=
lugin and script can now signal pending authentication to the client</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+when using deferred authen=
tication=2E The new `client-crresponse` script option</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+and `OPENVPN_PLUGIN_CLIENT_CRRESPONSE` pl=
ugin function can be used to parse a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+client response to a `CR_TEXT` two factor challenge=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+See `sample/sample-scripts/totpauth=2Epy`=
 for an example=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Compatibility mode=
 (`--compat-mode`)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The modernisation =
of defaults can impact the compatibility of OpenVPN 2=2E6=2E0 with</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+older peers=2E The options `=
--compat-mode` allows UIs to provide users with an</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+easy way to still connect to older servers=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**OpenSSL 3=2E0 support**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+OpenSSL 3=2E0 has been added=2E Most of OpenSSL =
3=2E0 changes are not user visible but</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+improve general compatibility with OpenSSL 3=2E0=2E `--t=
ls-cert-profile insecure`</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+has been added to allow selecting the lowest OpenSSL security level (=
not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+recommended, use=
 only if you must)=2E OpenSSL 3=2E0 no longer supports the Blowfish</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+(and other deprecated) algo=
rithm by default and the new option `--providers`</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+allows loading the legacy provider to renable=
 these algorithms=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Optional ciphers=
 in `--data-ciphers`**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ciphers in `--da=
ta-ciphers` can now be prefixed with a `?` to mark those as</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+optional and only use them if the S=
SL library supports them=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Improved =
`--mssfix` and `--fragment` calculation**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+The `--mssfix` and `--fragment` options now allow an optional `mtu` para=
meter to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+specify tha=
t different overhead for IPv4/IPv6 should taken into account and the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+resulting size is specifie=
d as the total size of the VPN packets including IP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+and UDP headers=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+**Cookie based handshake for UDP server**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+Instead of allocating a connection for each client on the=
 initial packet OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+server will now use an HMAC based cookie as its session id=2E This way =
the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+can verif=
y it on completing the handshake without keeping state=2E This eliminates</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the amplification and=
 resource exhaustion attacks=2E For tls-crypt-v2 clients,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+this requires OpenVPN 2=2E6 clients o=
r later because the client needs to resend</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+its client key on completing the hand shake=2E The t=
ls-crypt-v2 option allows</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+controlling if older clients are accepted=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+By default the rate of initial packet responses is limited to 1=
00 per 10s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+interval =
to avoid OpenVPN servers being abused in reflection attacks (see</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+`--connect-freq-initial`)=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+**Data channel offloading with ovpn-dco*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+2=2E6=2E0+ implements support for dat=
a-channel offloading where the data packets are</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+directly processed and forwarded in kernel spac=
e thanks to the ovpn-dco kernel</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+module=2E The userspace openvpn program acts purely as a contro=
l plane</span><br><span style=3D"color: hsl(120, 100%, 40%);">+application=
=2E Note that DCO will use DATA_V2 packets in P2P mode, therefore, this</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+implies that peers must=
 be running 2=2E6=2E0+ in order to have P2P-NCP which brings</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+DATA_V2 packet support=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+**Session timeout**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+It is now possible to terminate a session (or all) after a specifi=
ed amount of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+seconds=
 has passed session commencement=2E This behaviour can be configured using<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+`--session-timeout`=
=2E This option can be configured on the server, on the client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+or can also be pushed=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+**Inline auth username and password**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Username and password can now be specified inli=
ne in the configuration file</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+within the `&lt;auth-user-pass&gt;&lt;/auth-user-pass&gt;` tags=2E=
 If the password is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
missing OpenVPN will prompt for input via stdin=2E This applies to inline&#=
39;d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+http-proxy-user=
-pass too=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+**Tun MTU can be pushed**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+The client can now also dynamically con=
figure its MTU and the server will try to</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+push the client MTU when the client supports it=2E Th=
e directive `--tun-mtu-max`</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+has been introduced to increase the maximum pushable MTU size (defa=
ults to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+1600)=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**Dynamic TLS Crypt**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+When both peers are OpenVPN 2=2E6=2E1+, OpenVPN will dynam=
ically create a tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+key that is used for renegotiation=2E This ensure that only the previ=
ously</span><br><span style=3D"color: hsl(120, 100%, 40%);">+authenticated =
peer can do trigger renegotiation and complete renegotiations=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+**Improved control channel packet size control (`=
max-packet-size`)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The size of control=
 channel is no longer tied to `--link-mtu`/`--tun-mtu` and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+can be set using `--max-packet-size`=
=2E Sending large control channel frames is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+also optimised by allowing 6 outstanding packets in=
stead of just 4=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`=
max-packet-size` will also set `mssfix` to try to limit data-channel packet=
s as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+well=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+## Deprecated features</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+**`inetd` has been removed**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+This was a very limited and not-well-tested way to run OpenVPN, on TCP=
 and TAP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mode only=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**`verify-hash` has been deprecated=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+This option has very limited usefuln=
ess and should be replaced by either a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+better `--ca` configuration or with a `--tls-verify` scr=
ipt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+**`secret` has been deprecated**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static key mode (non-TLS) is no longer=
 considered &quot;good and secure enough&quot; for</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+today&#39;s requirements=2E Use TLS mode ins=
tead=2E If deploying a PKI CA is considered</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+&quot;too complicated&quot;, using `--peer-fingerpr=
int` makes TLS mode about as easy as</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+using `--secret`=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**=
`ncp-disable` has been removed**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This o=
ption mainly served a role as debug option when NCP was first introduced=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+It should now no lo=
nger be necessary=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**TLS 1=2E0 and 1=
=2E1 are deprecated**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`tls-version-min`=
 is set to 1=2E2 by default=2E OpenVPN 2=2E6=2E0 defaults to a minimum</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+TLS version of 1=2E2 as =
TLS 1=2E0 and 1=2E1 should be generally avoided=2E Note that</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+OpenVPN versions older than 2=2E3=
=2E7 use TLS 1=2E0 only=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**`--cipher`=
 argument is no longer appended to `--data-ciphers`**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+by default=2E Data cipher negotiation has been introduced in=
 2=2E4=2E0 and been</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
significantly improved in 2=2E5=2E0=2E The implicit fallback to the cipher =
specified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in `--ciph=
er` has been removed=2E Effectively, `--cipher` is a no-op in TLS mode</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+now, and will only have =
an effect in pre-shared-key mode (`--secret`)=2E From now</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+on `--cipher` should not be used in n=
ew configurations for TLS mode=2E Should</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+backwards compatibility with older OpenVPN peers be re=
quired, please see the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+`--compat-mode` instead=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**`--prng=
` has beeen removed**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN used to i=
mplement its own PRNG based on a hash=2E However implementing a</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+PRNG is better left to a crypto=
 library=2E So we use the PRNG mbed TLS or OpenSSL</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+now=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
*`--keysize` has been removed**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The `--=
keysize` option was only useful to change the key length when using the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+BF, CAST6 or RC2 cipher=
s=2E For all other ciphers the key size is fixed with the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+chosen cipher=2E As OpenVPN v2=2E6 no=
 longer supports any of these variable length</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ciphers, this option was removed as well to avoid=
 confusion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+**Compression no longer e=
nabled by default**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Unless an explicit =
compression option is specified in the configuration,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+`--allow-compression` defaults to `no` in=
 OpeNVPN 2=2E6=2E0=2E By default, OpenVPN 2=2E5</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+still allowed a server to enable compression by=
 pushing compression related</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+options=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**PF (Packet Filter=
ing) support has been removed**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The bui=
lt-in PF functionality has been removed from the code base=2E This feature<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+wasn&#39;t really ea=
sy to use and was long unmaintained=2E This implies that also</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+`--management-client-pf` and any =
other compile time or run time related option</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+do not exist any longer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+**Option conflict checking is being deprecated and phased ou=
t**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+The static option checking (OCC) is=
 no longer useful in typical setups that</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+negotiate most connection parameters=2E The `--opt-ver=
ify` and `--occ-disable`</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+options are deprecated, and the configure option `--enable-strict-opti=
ons` has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+been remove=
d=2E Logging of mismatched options has been moved to debug logging</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+(verb 7)=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+## User-visible Changes</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- CHACHA20-POLY1305 is included in the default of `--data-ciphers` whe=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  available=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- Option `--prng` is ig=
nored as we rely on the SSL library random number</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  generator=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+- Option `--nobind` is default when `--client` or =
`--pull` is used in the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  configuration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- `link_mtu` parameter is removed from environment or replaced with 0 when<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  scripts are called=
 with parameters=2E This parameter is unreliable and no longer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  internally calculated=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+- control channel packet =
maximum size is no longer influenced by</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  `--link-mtu`/`--tun-mtu` and must be set by `--max-pa=
cket-size` now=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  default is 1250 for the control channel size=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- In point-to-point OpenVPN setups (no `-=
-server`), using `--explict-exit-notiy`</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  on one end would terminate the other side at session =
end=2E This is considered a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  no longer useful default and has been changed to &quot;restart on=
 reception of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  expl=
icit-exit-notify message&quot;=2E If the old behaviour is still desired,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--remap-usr1 SIGTER=
M` can be used=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- =
FreeBSD tun interfaces with `--topology subnet` are now put into real subne=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  mode (IFF_BROADC=
AST instead of IFF_POINTOPOINT) - this might upset software</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  that enumerates interfaces, looki=
ng for &quot;broadcast capable?&quot; and expecting</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  certain results=2E Normal uses should n=
ot see any difference=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- The default configurations will no longer allow connections to OpenV=
PN 2=2E3=2Ex</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  peer =
or earlier, use the new `--compat-mode` option if you need compatibility</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  with older versions=
=2E See the manual page on the `--compat-mode` for details=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+- The `client-pending-auth` manag=
ement command now requires also the key id=2E The</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  management version has been changed to 5 to=
 indicate this change=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- (OpenVPN 2=2E6=2E2) A client will now refuse a connection if pushed =
compression</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  settin=
gs will contradict the setting of allow-compression as this almost</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  always results in a non-wo=
rking connection=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- The &quot;kill&quot; by addr management command now requires also the pro=
tocol as string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  e=
=2Eg=2E &quot;udp&quot;, &quot;tcp&quot;=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+## Common errors with OpenSSL 3=2E0 and OpenVPN 2=2E6</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Both OpenVPN 2=2E6 and OpenSSL 3=2E0 tighten the securi=
ty considerable, so some</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+configuration will no longer work=2E This section will cover the most =
common</span><br><span style=3D"color: hsl(120, 100%, 40%);">+causes and er=
ror message we have seen and explain their reason and temporary</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+workarounds=2E You should fix t=
he underlying problems as soon as possible since</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+these workaround are not secure and will event=
ually stop working in a future</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+update=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- weak SHA1 or MD5=
 signature on certificates</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This will =
happen on either loading of certificates or on connection to a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  server:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      OpenSSL: error:0A00018E:SSL routines::ca md too weak</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Cannot load cer=
tificate file cert=2Ecrt</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Exiting due to fatal error</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 OpenSSL 3=2E0 no longer allows weak signatures on certificates=2E You can<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  downgrade your sec=
urity to allow them by using `--tls-cert-profile insecure`</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  but should replace/regenerate thes=
e certificates as soon as possible=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
 1024 bit RSA certificates, 1024 bit DH parameters, other weak keys</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  This happens if you use private keys or othe=
r cryptographic material that does</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  not meet today&#39;s cryptographic standards anymore=2E Me=
ssages are similar to:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      OpenSSL: e=
rror:0A00018F:SSL routines::ee key too small</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      OpenSSL: error:1408518A:SSL routines:ssl3_ct=
x_ctrl:dh key too small</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  DH parameters=
 (`--dh`) can be regenerated with `openssl dhparam 2048`=2E For</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  other cryptographic keys, the=
se keys and certificates need to be regenerated=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  TLS Security level can be temporarily lowe=
red with `--tls-cert-profile legacy`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  or even `--tls-cert-profile insecure`=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+- Connecting to a OpenVPN 2=2E3=2Ex server or allowing=
 OpenVPN 2=2E3=2Ex or earlier</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  clients</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This will normall=
y result in messages like:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      OPTION=
S ERROR: failed to negotiate cipher with server=2E Add the server&#39;s cip=
her (&#39;AES-128-CBC&#39;) to --data-ciphers (currently &#39;AES-256-GCM:A=
ES-128-GCM:CHACHA20-POLY1305&#39;) if you want to connect to this server=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  or</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      client/127=2E0=2E0=2E1:49954 SENT CONTROL [client]: &#39;AUTH_FAIL=
ED,Data channel cipher negotiation failed (no shared cipher)&#39; (status=
=3D1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  You can manually add the missin=
g cipher to the `--data-ciphers`=2E The standard</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  ciphers should be included as well, e=2Eg=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--data-ciphers A=
ES-256-GCM:AES-128-GCM:?Chacha20-Poly1305:?AES-128-CBC`=2E You</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  can also use the `--compat-mod=
e` option=2E Note that these message may also</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  indicate other cipher configuration problems=2E=
 See the data channel cipher</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  negotiation manual section for more details=2E (Available online=
 under</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;https:/=
/github=2Ecom/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-negotiati=
on=2Erst&gt;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+- Use of a legacy or depr=
ecated cipher (e=2Eg=2E 64bit block ciphers)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  OpenSSL 3=2E0 no longer supports a number of insecure and outdated =
ciphers in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  its def=
ault configuration=2E Some of these ciphers are known to be vulnerable</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  (SWEET32 attack)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  This will typically manifest itself in =
messages like:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      OpenSSL: error:030=
8010C:digital envelope routines::unsupported</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Cipher algorithm &#39;BF-CBC&#39; not found<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Unsupported ci=
pher in --data-ciphers: BF-CBC</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If you=
r OpenSSL distribution comes with the legacy provider (see also</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  `man OSSL_PROVIDER-legacy`), =
you can load it with</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  `--providers legacy default`=2E This will re-enable the old algorithms=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- OpenVPN version not supporting TL=
S 1=2E2 or later</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  The default in OpenV=
PN 2=2E6 and also in many distributions is now TLS 1=2E2 or</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  later=2E Connecting to a peer tha=
t does not support this will results in</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  messages like:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    TLS error: Unsupported protocol=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  This typically indicates that client and server have no common TLS versio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  enabled=2E This =
can be caused by mismatched tls-version-min and tls-version-max</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  options on client and server=
=2E If your OpenVPN client is between v2=2E3=2E6 and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  v2=2E3=2E2 try adding `tls-version-min =
1=2E0` to the client configuration to use</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  TLS 1=2E0+ instead of TLS 1=2E0 only=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      OpenSSL: error:0A000102:SSL routines::unsupp=
orted protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  This can be an OpenVPN=
 2=2E3=2E6 or earlier version=2E `compat-version 2=2E3=2E0` will</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  enable TLS 1=2E0 support if =
supported by the OpenSSL distribution=2E Note that on</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  some Linux distributions enabling TLS 1=
=2E1 or 1=2E0 is not possible=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Over=
view of changes in 2=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## New feature=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+**Client-specific tls-crypt keys (`--=
tls-crypt-v2`)**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+`tls-crypt-v2` adds th=
e ability to supply each client with a unique tls-crypt</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+key=2E This allows large organisations =
and VPN providers to profit from the same</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+DoS and TLS stack protection that small deployments c=
an already achieve using</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+`tls-auth` or `tls-crypt`=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Cha=
Cha20-Poly1305 cipher support**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Added s=
upport for using the ChaCha20-Poly1305 cipher in the OpenVPN data</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+channel=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+**Improved Data channel cipher negotiation**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+The option `ncp-ciphers` has been renamed to `data-=
ciphers`=2E The old name is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+still accepted=2E The change in name signals that `data-ciphers` is=
 the preferred</span><br><span style=3D"color: hsl(120, 100%, 40%);">+way t=
o configure data channel ciphers and the data prefix is chosen to avoid the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ambiguity that exis=
ts with `--cipher` for the data cipher and `tls-cipher` for</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+the TLS ciphers=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+OpenVPN clients will now signal all supported ciphers f=
rom the `data-ciphers`</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+option to the server via `IV_CIPHERS`=2E OpenVPN servers will select the=
 first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+common cipher=
 from the `data-ciphers` list instead of blindly pushing the first</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+cipher of the list=2E This a=
llows to use a configuration like</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+`data-ciphers ChaCha20-Poly1305:AES-256-GCM` on the server th=
at prefers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ChaCha20-=
Poly1305 but uses it only if the client supports it=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+See the data channel negotiation section in the manual for =
more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+**Removal of BF-CBC sup=
port in default configuration:**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+By def=
ault OpenVPN 2=2E5 will only accept AES-256-GCM and AES-128-GCM as data</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ciphers=2E OpenVPN 2=2E=
4 allows AES-256-GCM,AES-128-GCM and BF-CBC when no --cipher</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+and --ncp-ciphers options are pres=
ent=2E Accepting BF-CBC can be enabled by adding</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+&gt; data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+and when you need to support very old peers also</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+&gt; data-ciphers-fallback BF-CBC</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+To offer backwards compatibility with older config=
s an *explicit*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+&gt; cipher BF-CBC</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+in the configuration will be automaticall=
y translated into adding BF-CBC to the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+data-ciphers option and setting data-ciphers-fallback to=
 BF-CBC (as in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
xample commands above)=2E We strongly recommend to switching away from BF-C=
BC to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a more secure =
cipher=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+**Asynchronous (deferred) aut=
hentication support for auth-pam plugin=2E**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+See src/plugins/auth-pam/README=2Eauth-pam for details=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+**Deferred client-connect**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+The `--client-connect` option and the connect plugin API all=
ow</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asynchronous/defe=
rred return of the configuration file in the same way as the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+auth-plugin=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+**Faster connection setup**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+A client will signal in the `IV_PROTO` variable that it is in pull mo=
de=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+allows th=
e server to push the configuration options to the client without</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+waiting for a `PULL_REQUEST` m=
essage=2E The feature is automatically enabled if</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+both client and server support it and signifi=
cantly reduces the connection setup</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+time by avoiding one extra packet round-trip and 1s of inte=
rnal event delays=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Netlink support*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+On Linux, if configured without `--en=
able-iproute2`, configuring IP addresses</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+and adding/removing routes is now done via the netlink=
(3) kernel interface=2E This</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+is much faster than calling `ifconfig` or `route` and also enables=
 OpenVPN to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run with=
 less privileges=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+If configured with =
--enable-iproute2, the `ip` command is used (as in 2=2E4)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Support for `ifconfig` and `route`=
 is gone=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+**Wintun support**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+On Windows, OpenVPN can now use `wintun` device=
s=2E They are faster than the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+traditional `tap9` tun/tap devices, but do not provide `--dev tap=
` mode - so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+offi=
cial installers contain both=2E To use a wintun device, add</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+`--windows-driver wintun` to your c=
onfig (and use of the interactive service is</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+required as wintun needs SYSTEM privileges to enab=
le access)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+**IPv6-only operation**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+It is now possible to have only IPv6 add=
resses inside the VPN tunnel, and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+IPv6-only address pools (2=2E4 always required IPv4 config/po=
ols and IPv6 was the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+&quot;optional extra&quot;)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Impro=
ved Windows 10 detection**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Correctly lo=
g OS on Windows 10 now=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Linux VRF s=
upport**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+Using the new `--bind-dev` opt=
ion, the OpenVPN outside socket can now be put</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+into a Linux VRF=2E See the &quot;Virtual Routin=
g and Forwarding&quot; documentation in the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+man page=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**T=
LS 1=2E3 support**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+TLS 1=2E3 support ha=
s been added to OpenVPN=2E Currently, this requires OpenSSL</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+1=2E1=2E1+=2E The options `--tls-ci=
phersuites` and `--tls-groups` have been added to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+fine tune TLS protocol options=2E Most of the=
 improvements were also backported to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+OpenVPN 2=2E4 as part of the maintainance releases=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**Support setting DHCP search domain**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+A new option `--dhcp-option DOMAIN-SEARCH=
 my=2Eexample=2Ecom` has been defined, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+Windows support for it is implemented (tun/tap only,=
 no wintun support yet)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Other platforms need to support this via `--up` script (Linux) or GU=
I</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(OSX/Tunnelblick)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**per-client changing of `--data-ci=
phers` or `data-ciphers-fallback`**</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fro=
m client-connect script/dir (NOTE: this only changes preference of ciphers<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+for NCP, but can not=
 override what the client announces as &quot;willing to accept&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+**Handle setting of tun/tap interface MTU on=
 Windows**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+If IPv6 is in use, MTU must =
be &gt;=3D 1280 (Windows enforces IETF requirements)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+**Add support for OpenSSL engines to access private key mate=
rial (like TPM)=2E**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**HMAC based auth-=
token support**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+The `--auth-gen-token` =
support has been improved and now generates HMAC based</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+user token=2E If the optional `--auth-ge=
n-token-secret` option is used clients</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+will be able to seamlessly reconnect to a different serv=
er using the same secret</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+file or to the same server after a server restart=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+**Improved support for pending authentication**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+The protocol has been enhanced to be able to si=
gnal that the authentication</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+should use a secondary authentication via web (like SAML) or a two=
 factor</span><br><span style=3D"color: hsl(120, 100%, 40%);">+authenticati=
on without disconnecting the OpenVPN session with AUTH_FAILED=2E The</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+session will instead be st=
ay in a authenticated state and wait for the second</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+factor authentication to complete=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+This feature currently requires usage of =
the managent interface on both client</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+and server side=2E See the `management-notes=2Etxt` `clie=
nt-pending-auth` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+`cr-response` commands for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+**VLAN support**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN servers i=
n TAP mode can now use 802=2E1q tagged VLANs on the TAP interface</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+to separate clients into diff=
erent groups that can then be handled differently</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+(different subnets / DHCP, firewall zones, =
=2E=2E=2E) further down the network=2E See</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+the new options `--vlan-tagging`, `--vlan-accept`, `=
--vlan-pvid`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+802=2E1q tagging on the=
 client side TAP interface is not handled today (=3D tags are</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+just forwarded transparently to t=
he server)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+**Support building of =2E=
msi installers for Windows**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Allow un=
icode search string in `--cryptoapicert` option (Windows)**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+**Support IPv4 configs with /31 netmasks now**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+(By no longer trying to configure `broadcast x=
=2Ex=2Ex=2Ex` in ifconfig calls, /31</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+support &quot;just works&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+**New option `--block-ipv6` to reject all IPv6 packets (ICMPv6)**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+This is useful if the VPN service has =
no IPv6, but the clients might have (LAN),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+to avoid client connections to IPv6-enabled servers =
leaking &quot;around&quot; the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+IPv4-only VPN=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`--ifconfig=
-ipv6` and `--ifconfig-ipv6-push` will now accept hostnames and do</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+a DNS lookup to get the IPv6=
 address to use=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Deprecated featur=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+For an up-to-date list of all deprec=
ated options, see this wiki page:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+&lt;https://community=2Eopenvpn=2Enet/openvpn/wiki/Deprecated=
Options&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- `ncp-disable` has been de=
precated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  With the improved and mat=
ured data channel cipher negotiation, the use of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  `ncp-disable` should not be necessary anymor=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- `inetd` has been deprecated=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  This is a very limited and not-well-te=
sted way to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  run Op=
enVPN, on TCP and TAP mode only, which complicates the code quite a bit</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  for little gain=2E To=
 be removed in OpenVPN 2=2E6 (unless users protest)=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- `no-iv` has been removed=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  This option was made into a NOOP option with OpenVPN</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  2=2E4=2E This has now been comp=
letely removed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--client-cert-not-=
required` has been removed</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This optio=
n will now cause server configurations to not start=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Use `--verify-client-cert none` instea=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- `--ifconfig-pool-linear` has bee=
n removed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  This option is removed=
=2E Use `--topology p2p` or `--topology subnet` instead=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- `--compress xxx` is considered risky and is warned ag=
ainst, see below=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--key-method 1` =
has been removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+## User-visible Change=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- If multiple connect handlers are us=
ed (client-connect, ccd, connect plugin)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  and one of the handler succeeds but a subsequent fai=
ls, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client-dis=
connect-script is now called immediately=2E Previously it was called,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  when the VPN session wa=
s terminated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Su=
pport for building with OpenSSL 1=2E0=2E1 has been removed=2E The minimum</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  supported OpenSSL v=
ersion is now 1=2E0=2E2=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- The GET_CONFIG management state is omitted if the server pushes th=
e client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configura=
tion almost immediately as result of the faster connection setup</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  feature=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- `--compress` is nowadays considered=
 risky, because attacks exist leveraging</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  compression-inside-crypto to reveal plaintext (VORAC=
LE)=2E So by default,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  `--compress xxx` will now accept incoming compressed packets (for</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  compatibility with peer=
s that have not been upgraded yet), but will not use</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  compression outgoing packets=2E This ca=
n be controlled with the new option</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  `--allow-compression yes|no|asym`=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+- Stop changing `--txlen` aways from OS =
defaults unless explicitly specified in</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  config file=2E OS defaults nowadays are actually larg=
er then what we used to</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  configure, so our defaults sometimes caused packet drops =3D bad perf=
ormance=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- remove =
`--writepid` pid file on exit now</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+- plugin-auth-pam now logs via OpenVPN logging method, no lon=
ger to stderr (this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  means you&#39;ll have log messages in syslog or openvpn log file now)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- use ISO 8601 time for=
mat for file based logging now (YYYY-MM-DD hh:mm:dd)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  (syslog is not affected, nor is `--mach=
ine-readable-output`)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+- `--clr-verify` now loads all CRLs if more than one CRL is in the same f=
ile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (OpenSSL backe=
nd only, mbedTLS always did that)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+- when `--auth-user-pass file` has no password, and the manag=
ement interface is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 active, query management interface (instead of trying console query, which=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  does not work on =
windows)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- skip expi=
red certificates in Windows certificate store (`--cryptoapicert`)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- `--socks-proxy` + `--proto =
udp*` will now allways use IPv4, even if IPv6 is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  requested and available=2E Our SOCKS code do=
es not handle IPv6+UDP, and before</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  that change it would just fail in non-obvious ways=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- TCP listen() backlog q=
ueue is now set to 32 - this helps TCP servers that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  receive lots of &quot;invalid&quot; con=
nects by TCP port scanners</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- do no longer print OCC warnings (&quot;option mismatch&quot;) abou=
t `key-method`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `k=
eydir`, `tls-auth` and `cipher` - these are either gone now, or negotiated,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and the warnings =
do not serve a useful purpose=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+- `dhcp-option DNS` and `dhcp-option DNS6` are now treated ide=
ntically (=3D both</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 accept an IPv4 or IPv6 address for the nameserver)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+## Maintainer-visible changes</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- the man page is now in maintained in =2Erst format, so building the=
 openvpn=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  manpa=
ge from a git checkout now requires python-docutils (if this is missing,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  the manpage will not=
 be built - which is not considered an error generally,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  but for package builders or `make dis=
tcheck` it is)=2E Release tarballs contain</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  the openvpn=2E8 file, so unless some =2Erst is cha=
nged, doc-utils are not needed</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  for building=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- OCC support can no longer be disabled</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- AEAD support is now required in the crypto l=
ibrary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--disable-=
server` has been removed from configure (so it is no longer</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  possible to build a client-/p2p-o=
nly OpenVPN binary) - the saving in code size</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  no longer outweighs the extra maintenance effor=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--enable-ipr=
oute2` will disable netlink(3) support, so maybe remove that from</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  package building configs (s=
ee above)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- support =
building with MSVC 2019</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+- cmocka based unit tests are now only run if cmocka is installed exter=
nally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2=2E4 used =
to ship a local git submodule which was painful to maintain)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- `--disable-crypto` configure opt=
ion has been removed=2E OpenVPN is now always</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  built with crypto support, which makes the code=
 much easier to maintain=2E This</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  does not affect `--cipher none` to do a tunnel without encry=
ption=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--disabl=
e-multi` configure option has been removed</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Overview of changes in 2=2E4</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## N=
ew features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+**Seamless client IP/port f=
loating**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+Added new packet format P_DAT=
A_V2, which includes peer-id=2E If both the server</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+and client support it, the client sends all =
data packets in the new format=2E When</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+a data packet arrives, the server identifies peer by pee=
r-id=2E If peer&#39;s ip/port</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+has changed, server assumes that client has floated, verifies HMA=
C and updates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ip/por=
t in internal structs=2E This allows the connection to be immediately</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+restored, instead of requ=
iring a TLS handshake before the server accepts packets</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+from the new client ip/port=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+**Data channel cipher negotiation**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+Data channel ciphers (`--cipher`) are now by defau=
lt negotiated=2E If a client</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+advertises support for Negotiable Crypto Parameters (NCP), the ser=
ver will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+choose a ci=
pher (by default AES-256-GCM) for the data channel, and tell the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+client to use that cipher=2E D=
ata channel cipher negotiation can be controlled</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+using `--ncp-ciphers` and `--ncp-disable`=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+A more limited version also works in cli=
ent-to-server and server-to-client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+scenarios where one of the end points uses a v2=2E4 client o=
r server and the other</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+side uses an older version=2E In such scenarios the v2=2E4 side will cha=
nge to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`--cipher=
` set by the remote side, if permitted by by `--ncp-ciphers`=2E For</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+example, a v2=2E4 client wi=
th `--cipher BF-CBC` and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+`ncp-ciphers AES-256-GCM:AES-256-CBC` can connect to both a v2=2E3 ser=
ver with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`cipher BF-=
CBC` as well as a server with `cipher AES-256-CBC` in its config=2E The</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+other way around, a v2=
=2E3 client with either `cipher BF-CBC` or</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+`cipher AES-256-CBC` can connect to a v2=2E4 server =
with e=2Eg=2E `cipher BF-CBC` and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+`ncp-ciphers AES-256-GCM:AES-256-CBC` in its config=2E For th=
is to work it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+requir=
es that OpenVPN was built without disabling OCC support=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+**AEAD (GCM) data channel cipher support**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+The data channel now supports AEAD ciphers (current=
ly only GCM)=2E The AEAD packet</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+format has a smaller crypto overhead than the CBC packet format=
, (e=2Eg=2E 20 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+per packet for AES-128-GCM instead of 36 bytes per packet for AES-128-CBC =
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+HMAC-SHA1)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**ECDH key exchange**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+The TLS control channel now supports for elliptic curve di=
ffie-hellmann key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ex=
change (ECDH)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+**Improved Certificate=
 Revocation List (CRL) processing**</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CRL=
s are now handled by the crypto library (OpenSSL or mbed TLS), instead of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+inside OpenVPN itself=
=2E The crypto library implementations are more strict than</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+the OpenVPN implementation was=2E T=
his might reject peer certificates that would</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+previously be accepted=2E If this occurs, OpenVPN=
 will log the crypto library&#39;s</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+error description=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**D=
ualstack round-robin DNS client connect**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Instead of only using the first address of each `--remote` OpenVPN will =
now try</span><br><span style=3D"color: hsl(120, 100%, 40%);">+all addresse=
s (IPv6 and IPv4) of a `--remote` entry=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+**Support for providing IPv6 DNS servers**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+A new DHCP sub-option `DNS6` is added alongside with the already ex=
isting `DNS`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sub-opt=
ion=2E This is used to provide DNS resolvers available over IPv6=2E This ma=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+be pushed to clien=
ts where `--up` scripts and `--plugin` can act upon it through</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+the `foreign_option_&lt;n&gt;` e=
nvironment variables=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Support for the=
 Windows client picking up this new sub-option is added, however</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+IPv6 DNS resolvers need to be =
configured via `netsh` which requires</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+administrator privileges unless the new interactive servi=
ces on Windows is being</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+used=2E If the interactive service is used, this service will execute `=
netsh` in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the backgr=
ound with the proper privileges=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Ne=
w improved Windows Background service**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+The new OpenVPNService is based on openvpnserv2, a complete rewrite of the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN service wra=
pper=2E It is intended for launching OpenVPN instances that</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+should be up at all times, instead =
of being manually launched by a user=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+OpenVPNService is able to restart individual OpenVPN pr=
ocesses if they crash,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+and it also works properly on recent Windows versions=2E OpenVPNServiceL=
egacy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tends to work =
poorly, if at all, on newer Windows versions (8+) and its use is</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+not recommended=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+**New interactive Windows service**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+The installer starts OpenVPNServiceInteractive automa=
tically and configures it</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+to start at system startup=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The=
 interactive Windows service allows unprivileged users to start OpenVPN</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+connections in the glob=
al config directory (usually C:\Program</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Files\OpenVPN\config) using OpenVPN GUI without any ext=
ra configuration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Users who belong to=
 the built-in Administrator group or to the local &quot;OpenVPN</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Administrator&quot; group can a=
lso store configuration files under</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+%USERPROFILE%\OpenVPN\config for use with the interactive s=
ervice=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+**redirect-gateway ipv6**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OpenVPN has now feature parity between IP=
v4 and IPv6 for redirect gateway</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+including the handling of overlapping IPv6 routes with IPv6 re=
mote VPN server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addr=
ess=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+**LZ4 Compression and pushable c=
ompression**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Additionally to LZO compre=
ssion OpenVPN now also supports LZ4 compression=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Compression options are now pushable from th=
e server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+**Filter pulled options cli=
ent-side: pull-filter**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+New option to e=
xplicitly allow or reject options pushed by the server=2E May be</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+used multiple times and is app=
lied in the order specified=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Per-cl=
ient remove push options: push-remove**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+New option to remove options on a per-client basis from the &quot;push&quo=
t; list (more</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fine-g=
rained than `--push-reset`)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**Http p=
roxy password inside config file**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Http=
 proxy passwords can be specified with the inline file option</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+`&lt;http-proxy-user-pass&gt;` =
=2E=2E `&lt;/http-proxy-user-pass&gt;`</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
**Windows version detection**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Windows v=
ersion is detected, logged and possibly signalled to server</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+(`IV_PLAT_VER=3D&lt;nn&gt;` if `--p=
ush-peer-info` is set on client)=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**A=
uthentication tokens**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In situations wh=
ere it is not suitable to save user passwords on the client,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+OpenVPN has support for pushing a =
--auth-token since v2=2E3=2E This option is pushed</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+from the server to the client with a token v=
alue to be used instead of the users</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+password=2E For this to work, the authentication plug-in w=
ould need to implement</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+this support as well=2E In OpenVPN 2=2E4 --auth-gen-token is introduced,=
 which will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+allow th=
e OpenVPN server to generate a random token and push it to the client</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+without any changes to th=
e authentication modules=2E When the clients need to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+re-authenticate the OpenVPN server will d=
o the authentication internally,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+instead of sending the re-authentication request to the authen=
tication module =2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
This feature is especially useful in configurations which use One Time Pass=
word</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(OTP) authentic=
ation schemes, as this allows the tunnel keys to be renegotiated</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+regularly without any need to =
supply new OTP codes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+**keying-materi=
al-exporter**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Keying Material Exporter =
\[RFC-5705\] allow additional keying material to be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+derived from existing TLS channel=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**Android platform support**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+Support for running on Android using Android&#39;s =
VPNService API has been added=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+See doc/android=2Etxt for more details=2E This support is prim=
arily used in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Op=
enVPN for Android app (&lt;https://github=2Ecom/schwabe/ics-openvpn&gt;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+**AIX platform support**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AIX platform support has been added=2E The support only=
 includes tap devices since</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+AIX does not provide tun interface=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+**Control channel encryption (`--tls-crypt`)**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Use a pre-shared static key (like the `--tls-auth` key) to e=
ncrypt control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chann=
el packets=2E Provides more privacy, some obfuscation and poor-man&#39;s</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+post-quantum security=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+**Asynchronous push reply**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+Plug-ins providing support for deferred authen=
tication can benefit from a more</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+responsive authentication where the server sends PUSH_REPLY im=
mediately once the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
uthentication result is ready, instead of waiting for the client to to send=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+PUSH_REQUEST once m=
ore=2E This requires OpenVPN to be built with</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+`=2E/configure --enable-async-push`=2E This is a =
compile-time only switch=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Deprecat=
ed features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+For an up-to-date list of a=
ll deprecated options, see this wiki page:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+&lt;https://community=2Eopenvpn=2Enet/openvpn/wiki/D=
eprecatedOptions&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--key-method 1`=
 is deprecated in OpenVPN 2=2E4 and will be removed in v2=2E5=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Migrate away from `--key-met=
hod 1` as soon as possible=2E The recommended</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  approach is to remove the `--key-method` option=
 from the configuration files,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  OpenVPN will then use `--key-method 2` by default=2E Note that=
 this requires</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  cha=
nging the option in both the client and server side configs=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+- `--tls-remote` is removed in O=
penVPN 2=2E4, as indicated in the v2=2E3 man-pages=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Similar functionality is provided via `=
--verify-x509-name`, which does the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  same job in a better way=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+- `--compat-names` and `--no-name-remapping` were=
 deprecated in OpenVPN 2=2E3 and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  will be removed in v2=2E5=2E All scripts and plug-ins depend=
ing on the old</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  non=
-standard X=2E509 subject formatting must be updated to the standardized</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  formatting=2E See th=
e man page for more information=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- `--no-iv` is deprecated in OpenVPN 2=2E4 and will be remov=
ed in v2=2E5=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `-=
-keysize` is deprecated in OpenVPN 2=2E4 and will be removed in v2=2E6 toge=
ther</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  with the supp=
ort of ciphers with cipher block size less than 128-bits=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- `--comp-lzo` is deprecated in Ope=
nVPN 2=2E4=2E Use `--compress` instead=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+- `--ifconfig-pool-linear` has been deprecated since =
OpenVPN 2=2E1 and will be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  removed in v2=2E5=2E Use `--topology p2p` instead=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- `--client-cert-not-required` is =
deprecated in OpenVPN 2=2E4 and will be removed</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  in v2=2E5=2E Use `--verify-client-cert none` =
for a functional equivalent=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- `--ns-cert-type` is deprecated in OpenVPN 2=2E3=2E18 and v2=2E=
4=2E It will be removed</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  in v2=2E5=2E Use the far better `--remote-cert-tls` option which repl=
aces this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  feature=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+## User-visible Changes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+- When using ciphers with cipher blocks less than =
128-bits, OpenVPN will</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  complain loudly if the configuration uses ciphers considered weak, suc=
h as the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  SWEET32 a=
ttack vector=2E In such scenarios, OpenVPN will by default renegotiate</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  for each 64MB of trans=
ported data (`--reneg-bytes`)=2E This renegotiation can be</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  disabled, but is HIGHLY DISCOURAGE=
D=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- For certificate DNs with duplica=
te fields, e=2Eg=2E &quot;OU=3Done,OU=3Dtwo&quot;, both fields</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  are now exported to the enviro=
nment, where each second and later occurrence of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  a field get _$N appended to it&#39;s field n=
ame, starting at N=3D1=2E For the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  example above, that would result in e=2Eg=2E X509_0_OU=3Don=
e, X509_0_OU_1=3Dtwo=2E Note</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  that this breaks setups that rely on the fact that OpenVPN would=
 previously</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (incor=
rectly) only export the last occurrence of a field=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- `proto udp` and `proto tcp` now use both IPv4 and IPv6=2E =
The new options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `p=
roto udp4` and `proto tcp4` use IPv4 only=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- `--sndbuf` and `--recvbuf` default now to OS defaults instead of 64=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- OpenVPN exits with an error if an o=
ption has extra parameters; previously they</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  were silently ignored</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- `--tls-auth` always requires OpenVPN static key files and will n=
o longer work</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  with=
 free form files</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--proto udp6/tcp6` =
in server mode will now try to always listen to both IPv4</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  and IPv6 on platforms that allow it=
=2E Use `--bind ipv6only` to explicitly</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  listen only on IPv6=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- Removed `--enable-password-save` from configure=2E This option is n=
ow always</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  enabled=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- Stricter default TLS cipher list =
(override with `--tls-cipher`), that now also</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  disables:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 - Non-ephemeral key exchange using static (EC)DH keys</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  - DSS private keys</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- mbed TLS builds: changed the tls_digest_N values exporte=
d to the script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  en=
vironment to be equal to the ones exported by OpenSSL builds, namely the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  certificate fingerpr=
int (was the hash of the &#39;to be signed&#39; data)=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- mbed TLS builds: minimum RSA key size is now 2048 bits=
=2E Shorter keys will not</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  be accepted, both local and from the peer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- `--connect-timeout` now specifies the timeout until the fi=
rst TLS packet is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
received (identical to `--server-poll-timeout`) and this timeout now includ=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the removed soc=
ks proxy timeout and http proxy timeout=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  In `--static` mode `connect-timeout` specifies the timeout for TCP an=
d proxy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connection=
 establishment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--connect-retry-max` =
now specifies the maximum number of unsuccessful</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  attempts of each remote/connection entry bef=
ore exiting=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--http-proxy-timeout`=
 and the static non-changeable socks timeout (5s) have</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  been folded into a &quot;unified&quot;=
 `--connect-timeout` which covers all steps needed</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  to connect to the server, up to the start =
of the TLS exchange=2E The default</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  value has been raised to 120s, to handle slow http/socks p=
roxies graciously=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  The old &quot;fail TCP fast&quot; behaviour can be achieved by adding</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;`--connect-tim=
eout 10`&quot; to the client config=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- `--http-proxy-retry` and `--sock-proxy-retry` have been removed=2E Proxy<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connections will n=
ow behave like regular connection entries and generate a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  USR1 on failure=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+- `--connect-retry` gets an optional second argument tha=
t specifies the maximum</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  time in seconds to wait between reconnection attempts when an exponen=
tial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  backoff is tr=
iggered due to repeated retries=2E Default =3D 300 seconds=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- Data channel cipher negotiation (see New features =
section) can override</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ciphers configured in the config file=2E Use `--ncp-disable` if you do =
not want</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  this beha=
vior=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+- All tun devices on all platfo=
rms are always considered to be IPv6 capable=2E The</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `--tun-ipv6` option is ignored (behaves=
 like it is always on)=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- On the clie=
nt side recursively routed packets, which have the same destination</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  as the VPN server, are dr=
opped=2E This can be disabled with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  --allow-recursive-routing option=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- On Windows, when the `--register-dns` option is set, OpenV=
PN no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  resta=
rts the `dnscache` service - this had unwanted side effects, and seems to</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  be no longer necess=
ary with currently supported Windows versions=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+- If no flags are given, and the interactive Windows service is u=
sed, &quot;def1&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  implicitly set (because &quot;delete and later reinstall the existin=
g default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  route&qu=
ot; does not work well here)=2E If not using the service, the old behaviour=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is kept=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- OpenVPN now reloads a CRL only if the modic=
ation time or file size has</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  changed, instead of for each new connection=2E This reduces the c=
onnection setup</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ti=
me, in particular when using large CRLs=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+- OpenVPN now ships with more up-to-date systemd unit files which take =
advantage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of the i=
mproved service management as well as some hardening steps=2E The</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  configuration files are pic=
ked up from the /etc/openvpn/server/ and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  /etc/openvpn/client/ directories (depending on unit =
file)=2E This also avoids</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  these new unit files and how they work to collide with older pre-ex=
isting unit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  files=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- Using `--no-iv` (which is general=
ly not a recommended setup) will require</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  explicitly disabling NCP with `--disable-ncp`=2E Thi=
s is intentional because NCP</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  will by default use AES-GCM, which requires an IV - so we want u=
sers of that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  optio=
n to consciously reconsider=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Maint=
ainer-visible changes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- OpenVPN no long=
er supports building with crypto support, but without TLS</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  support=2E As a consequence, `OPENS=
SL_CRYPTO_{CFLAGS,LIBS}` and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  `OPENSSL_SSL_{CFLAGS,LIBS}` have been merged into `OPENSSL_{CFLA=
GS,LIBS}`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This =
is particularly relevant for maintainers who build their own OpenSSL</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  library, e=2Eg=2E when c=
ross-compiling=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- =
Linux distributions using systemd is highly encouraged to ship these new un=
it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  files instead o=
f older ones, to provide a unified behaviour across systemd</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  based Linux distributions=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- With OpenVPN 2=2E4, th=
e project has moved over to depend on and actively use the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  official C99 standard (-std=3Dc99)=
=2E This may fail on some older compiler/libc</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  header combinations=2E In most of these situati=
ons it is recommended to use</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  -std=3Dgnu99 in CFLAGS=2E This is known to be needed when doing =
i386/i686 builds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  o=
n RHEL5=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# Version 2=2E4=2E5</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+## New features</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- The new option `--tls-cert-profile` can be used to restrict the set =
of allowed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  crypto =
algorithms in TLS certificates in mbed TLS builds=2E The default profile</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  is &#39;legacy&#39; =
for now, which allows SHA1+, RSA-1024+ and any elliptic curve</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  certificates=2E The default wil=
l be changed to the &#39;preferred&#39; profile in the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  future, which requires SHA2+, RSA-2048=
+ and any curve=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Version 2=2E4=2E3<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+## New features</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- Support building with OpenSSL 1=2E1 now (in addition to ol=
der versions)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- On W=
in10, set low interface metric for TAP adapter when block-outside-dns is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  in use, to make Wind=
ows prefer the TAP adapter for DNS queries (avoiding large</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  delays)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+## Security</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- CVE-2017-7522: =
Fix `--x509-track` post-authentication remote DoS A client</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  could crash a v2=2E4+ mbedtls serv=
er, if that server uses the `--x509-track`</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  option and the client has a correct, signed and un=
revoked certificate that</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  contains an embedded NUL in the certificate subject=2E Discovered an=
d reported</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to the =
OpenVPN security team by Guido Vranken=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+- CVE-2017-7521: Fix post-authentication remote-trigg=
erable memory leaks A</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  client could cause a server to leak a few bytes each time it connects t=
o the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server=2E Th=
at can eventually cause the server to run out of memory, and thereby</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  causing the server proce=
ss to terminate=2E Discovered and reported to the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  OpenVPN security team by Guido Vranken=2E (=
OpenSSL builds only=2E)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+- CVE-2017-7521: Fix a potential post-authentication remote code execut=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  attack on serv=
ers that use the `--x509-username-field` option with an X=2E509</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  extension field (option argum=
ent prefixed with `ext:`)=2E A client that can</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  cause a server to run out-of-memory (see above=
) might be able to cause the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  server to double free, which in turn might lead to remote code e=
xecution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Discov=
ered and reported to the OpenVPN security team by Guido Vranken=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  (OpenSSL builds only=2E)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- CVE-2017-7520: Pre-=
authentication remote crash/information disclosure for</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  clients=2E If clients use a HTTP proxy=
 with NTLM authentication (i=2Ee=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  `--http-proxy &lt;server&gt; &lt;port&gt; [&lt;authfile&g=
t;|&#39;auto&#39;|&#39;auto-nct&#39;] ntlm2`), a</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  man-in-the-middle attacker between the clien=
t and the proxy can cause the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  client to crash or disclose at most 96 bytes of stack memory=2E=
 The disclosed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sta=
ck memory is likely to contain the proxy password=2E If the proxy password =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  not reused, thi=
s is unlikely to compromise the security of the OpenVPN tunnel</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  itself=2E Clients who do not u=
se the `--http-proxy` option with ntlm2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  authentication are not affected=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- CVE-2017-7508: Fix remotely-triggera=
ble ASSERT() on malformed IPv6 packet=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  This can be used to remotely shutdown an openvpn ser=
ver or client, if IPv6 and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  `--mssfix` are enabled and the IPv6 networks used inside the VPN a=
re known=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix nu=
ll-pointer dereference when talking to a malicious http proxy that</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  returns a malformed `Proxy=
-Authenticate:` headers for digest auth=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- Fix overflow check for long `--tls-cipher` option<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Windows: Pass corr=
ect buffer size to `GetModuleFileNameW()` (OSTIF/Quarkslabs</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  audit, finding 5=2E6)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+## User-visible Changes</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+- `--verify-hash` can now take an optional flag which changes the=
 hashing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  algorithm=
=2E It can be either SHA1 or SHA256=2E The default if not provided is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  SHA1 to preserve backwa=
rds compatibility with existing configurations=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- Restrict the supported `--x509-username-fie=
ld` extension fields to</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  subjectAltName and issuerAltName=2E Other extensions probably didn&#3=
9;t work</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  anyway, a=
nd would cause OpenVPN to crash when a client connects=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+## Bugfixes</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix fi=
ngerprint calculation in mbed TLS builds=2E This means that mbed TLS users<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of OpenVPN 2=2E4=
=2E0, v2=2E4=2E1 and v2=2E4=2E2 that rely on the values of the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  `tls_digest_*` env vars, or th=
at use `--verify-hash` will have to change the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  fingerprint values they check against=2E The s=
ecurity impact of the incorrect</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  calculation is very minimal; the last few bytes (max 4, typic=
ally 4) are not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ve=
rified by the fingerprint=2E We expect no real-world impact,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  because users that used this fea=
ture before will notice that it has suddenly</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  stopped working, and users that didn&#39;t will =
notice that connection setup fails</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  if they specify correct fingerprints=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- Fix edge case with NCP when the server sends an empty P=
USH_REPLY message back,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  and the client would not initialize it&#39;s data channel crypto laye=
r properly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (trac #=
903)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- Fix SIGSEGV on unaligned buffer =
access on OpenBSD/Sparc64</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix TCP_NOD=
ELAY on OpenBSD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+- Remove erroneous limi=
tation on max number of args for `--plugin`</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- Fix NCP behaviour on TLS reconnect (Server would not send a proper &=
quot;cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =2E=2E=
=2E&quot; message back to the client, leading to client and server using di=
fferent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ciphers) (=
trac #887)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# Version 2=2E4=2E2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+## Bugfixes</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- Fix memory leak introduced in OpenVPN 2=2E4=2E1: if `--remote-cert-tls` =
is used,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  we leaked=
 some memory on each TLS (re)negotiation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+## Security</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix a pre-authentica=
tion denial-of-service attack on both clients and servers=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  By sending a too-large control p=
acket, OpenVPN 2=2E4=2E0 or v2=2E4=2E1 can be forced</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  to hit an ASSERT() and stop the process=
=2E If `--tls-auth` or `--tls-crypt` is</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  used, only attackers that have the `--tls-auth` or `-=
-tls-crypt` key can mount</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  an attack=2E (OSTIF/Quarkslab audit finding 5=2E1, CVE-2017-7478)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Fix an authenticate=
d remote DoS vulnerability that could be triggered by</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  causing a packet id roll over=2E An att=
ack is rather inefficient; a peer would</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  need to get us to send at least about 196 GB of data=
=2E (OSTIF/Quarkslab audit</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  finding 5=2E2, CVE-2017-7479)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Version 2=2E4=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--remote-cert-ku=
` now only requires the certificate to have at least the bits</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  set of one of the values in the=
 supplied list, instead of requiring an exact</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  match to one of the values in the list=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+- `--remote-cert-tls` now=
 only requires that a keyUsage is present in the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  certificate, and leaves the verification of =
the value up to the crypto</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  library, which has more information (i=2Ee=2E the key exchange met=
hod in use) to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ver=
ify that the keyUsage is correct=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- `--ns-cert-type` is deprecated=2E Use `--remote-cert-tls`=
 instead=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ns=
CertType x509 extension is very old, and barely used=2E `--remote-cert-tls`=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  uses the far more=
 common keyUsage and extendedKeyUsage extension instead=2E Make</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  sure your certificates carry =
these to be able to use `--remote-cert-tls`=2E</span><br><span>diff --git a=
/Changes=2Erst b/Changes=2Erst</span><br><span>deleted file mode 100644</sp=
an><br><span>index 1f992b2=2E=2E0000000</span><br><span>--- a/Changes=2Erst=
</span><br><span>+++ /dev/null</span><br><span>@@ -1,1460 +0,0 @@</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-Overview of changes in 2=2E8</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Overview =
of changes in 2=2E7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-New features</span=
><br><span>-------------</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-Multi-socket support for servers</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    OpenVPN servers now can listen on multiple sockets at the=
 same time=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Mult=
iple ``--local`` statements in the configuration can be used to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    configure this=2E This way th=
e same server can e=2Eg=2E listen for UDP</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    and TCP connections at the same time, or listen on =
multiple addresses</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 and/or ports=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Client implementations for=
 DNS options sent by server for Linux/BSD/macOS</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    Linux, BSD and macOS versions of OpenVPN now =
ship with a per-platform</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    default ``--dns-updown`` script that implements proper handling of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DNS configuration s=
ent by the server=2E  The scripts should work on</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    systems that use ``systemd`` or ``resolvecon=
f`` to manage the DNS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    setup, as well as raw ``/etc/resolv=2Econf`` files=2E However, the exac=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    features support=
ed will depend on the configuration method=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    On Linux and MacOS this should usually make spl=
it-DNS configurations</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    supported out-of-the-box now=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Not=
e that this new script will not be used by default if a ``--up``</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    script is already in use to =
reduce problems with</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   backwards compatibility=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    See docum=
entation for ``--dns-updown`` and ``--dns`` for more details=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-New client implementation for DNS options sent by serv=
er for Windows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The=
 Windows client now uses NRPT (Name Resolution Policy Table) to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    handle DNS configurations=2E =
This adds support for split-DNS and DNSSEC</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    and improves the compatbility with local DNS resol=
vers=2E Requires the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   interactive service=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-On Windows the ``=
block-local`` flag is now enforced with WFP filters=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    The ``block-local`` flag to ``--redire=
ct-gateway`` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    `=
`--redirect-private`` is now also enforced via the Windows Firewall,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    making sure packets can&=
#39;t be sent to the local network=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    This provides stronger protection against TunnelCrack-s=
tyle attacks=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Windows network adapters ar=
e now generated on demand</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    This means that on systems that run multiple OpenVPN connections at=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the same time the=
 users don&#39;t need to manually create enough network</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    adapters anymore (in addition to the =
ones created by the installer)=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Windows a=
utomatic service now runs as an unpriviledged user</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    All tasks that need privileges are now del=
egated to the interactive</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    service=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 **NOTE** this has the risk of breaking existing setups if the</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    Windows certificate store is u=
sed (cryptoapi), and the certificates</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    are not readable for ``NT SERVICE\OpenVPNService``=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Support for new version of Linux DCO module=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The OpenVPN DCO m=
odule has been merged into the Linux kernel as of</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    6=2E16=2E  This required some API changes a=
nd OpenVPN 2=2E7 only supports</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    the new API=2E The new module is called ``ovpn``=2E Out-of-tre=
e builds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for older=
 kernels are available from</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    https://github=2Ecom/OpenVPN/ovpn-backports=2E Please</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    see the release announcements=
 for further information=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for ser=
ver mode in win-dco driver</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    On Windows the win-dco driver can now be used in server setups=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Support for TLS client floating in DCO impl=
ementations</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ke=
rnel modules will detect clients floating to a new IP address</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    and notify userland so both dat=
a packets (kernel) and TLS packets</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    (sent by userland) can reach the new client IP=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    (Actual support depends on=
 recent-enough kernel implementation)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Enfor=
cement of AES-GCM usage limit</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    OpenVPN will now enforce the usage limits on AES-GCM with the s=
ame</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    confidentialit=
y margin as TLS 1=2E3 does=2E This mean that renegotiation will</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    be triggered after roughly 2^=
28 to 2^31 packets depending of the packet</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    size=2E More details about usage limit of AES-GCM =
can be found here:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    https://datatracker=
=2Eietf=2Eorg/doc/draft-irtf-cfrg-aead-limits/</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-Epoch data keys and packet format</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    This introduces the epoch data format for AEAD data cha=
nnel</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ciphers in TL=
S mode ciphers=2E This new data format has a number of</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    improvements over the standard &quot;D=
ATA_V2&quot; format=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    - AEAD tag at th=
e end of packet which is more hardware implementation</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      friendly</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    - Automatic key switchover when cipher usage l=
imits are hit, similar to</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      the epoch data keys in (D)TLS 1=2E3</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    - 64 bit instead of 32 bit packet ids to allow =
the data channel to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      ready for 10 GBit/s without having frequent renegotiation</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    - IV constructed with XOR in=
stead of concatenation to not have (parts) of</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      the real IV on the wire</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Support for Epoch data channel on Windows, using the win-dco dri=
ver (2=2E8=2E0+)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Default ciphers in ``--dat=
a-ciphers``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Cipher=
s in ``--data-ciphers`` can contain the string DEFAULT that is</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    replaced by the default cipher=
s used by OpenVPN, making it easier to</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    add an allowed cipher without having to spell out the =
default ciphers=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-TLS alerts</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN 2=2E7 will send out TLS=
 alerts to peers informing them if the TLS</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    session shuts down or when the TLS implementation =
informs the peer about</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    an error in the TLS session (e=2Eg=2E mismatching TLS versions)=2E Thi=
s improves</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the use=
r experience as the client shows an error instead of running into</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    a timeout when the server j=
ust stops responding completely=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support =
for tun/tap via unix domain socket and lwipovpn support</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    To allow better testing and emulating=
 a full client with a full</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    network stack OpenVPN now allows a program executed to provide</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    a tun/tap device inst=
ead of opening a device=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The co-devel=
oped lwipovpn program based on lwIP stack allows to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    simulate full IP stack=2E An OpenVPN cl=
ient using</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--dev=
-node unix:/path/to/lwipovpn`` can emulate a full client that</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    can be pinged, can serve a webs=
ite and more without requiring any</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    elevated permission=2E This can make testing OpenVPN much =
easier=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    For more details see</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    `lwipovpn on Github &lt;ht=
tps://github=2Ecom/OpenVPN/lwipovpn&gt;`_=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-Allow overriding username with ``--override-username``</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    This is intended to allow using ``--=
auth-gen-token`` in scenarios where the</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    clients use certificates and multi-factor authenticat=
ion=2E  This will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
also generate a ``push &quot;auth-token-user newusername&quot;`` directive =
in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    push replies=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-``--port-share`` now properly supports IPv=
6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Issues with logg=
ing of IPv6 addresses were fixed=2E The feature now allows</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    IPv6 connections towards the proxy=
 receiver=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-Support for Haiku OS</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-TLS1=2E3 support with mbedTLS (requires mbedTLS &gt;=
=3D 3=2E6=2E4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-PUSH_UPDATE client support</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    It is now possible =
to update parts of the client-side configuration</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    (IP address, routes, MTU, DNS) by sending a =
new server-to-client</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   control message, ``PUSH_UPDATE,&lt;options&gt;``=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    See also: https://openvpn=2Egithub=2Ei=
o/openvpn-rfc/openvpn-wire-protocol=2Ehtml</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    NOTE: PUSH_UPDATE client support is currently disa=
bled if DCO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is act=
ive (on all platforms)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-PUSH_UPDATE serve=
r support (minimal)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  New management interface commands ``push-update-broad`` and</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ``push-update-cid`` to send PUS=
H_UPDATE option updates to all</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    clients (&quot;there is a new DNS server&quot;) or only a spec=
ific client ID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (&q=
uot;privileges have changed, here&#39;s a new IP address&quot;)=2E  See</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    doc/management-notes=
=2Etxt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NOTE: PUSH_=
UPDATE server support is currently disabled if DCO</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    is active (on all platforms)=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-Support for user-defined routing tables on Linux</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    See the ``--route-tabl=
e`` option in the manpage</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-PQE support for W=
olfSSL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-Two new environment variables have b=
een introduced to communicate desired</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    default gateway redirection to plugins like Network Man=
ager,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``route_redi=
rect_gateway_ipv4`` and ``route_redirect_gateway_ipv6``=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    See the &quot;Environmental Variab=
les&quot; section in the man page</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Improved =
logging of service events/errors to event log on Windows=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-&quot;Recursive Routing&quot; check is now more granular, =
and will only drop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
packets-in-tunnel if destination IP, protocol and port matches with</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   those needed to reach the =
VPN server=2E  With that change, you can now</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   use policies that direct &quot;everything that is=
 not OpenVPN&quot; into the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   tunnel, and have IP packets to the VPN server address arrive as</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   expected (no such pol=
icies are currently installed by OpenVPN)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   (GH: OpenVPN/openvpn#669)=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-COPYING: license details only relevant to our Windows installers=
 have</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   been updated =
and moved to the openvpn-build repo</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Improve=
d BYTECOUNT support - more strictly adhere to timing interval</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   requested, correctly support cli=
ent and server counters with Linux and</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   Windows DCO offloading=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-Improve compatibility with OpenSSL 3=2E6=2E0 (do not fail t_lpback selft=
est)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-New option ``--tls-crypt-v2-max-age n`=
` to check tls-crypt-v2 timestamps</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   (When a client is older than n days or has no timestamp, th=
e server</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    will reje=
ct it)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbedTLS 4 support has been added=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Note that with mbed=
TLS 4 algorithms need to be translated to</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   mbedTLS 4 internal IDs by OpenVPN, and some names mi=
ght be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   missing=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Deprecated features</span><br><span>--------------------</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-``secret`` support has been r=
emoved (by default)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    static key mode (non-TLS) is no longer considered &quot;good and secur=
e enough&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for=
 today&#39;s requirements=2E  Use TLS mode instead=2E  If deploying a PKI C=
A</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is considered &q=
uot;too complicated&quot;, using ``--peer-fingerprint`` makes</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    TLS mode about as easy as using=
 ``--secret``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    This mode can still be=
 enabled by using</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
``--allow-deprecated-insecure-static-crypto`` but will be removed in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN 2=2E8=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Support for wintun Windows driver has been removed=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN 2=2E6 =
added support for the new dco-win driver, so it supported</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    three different device drivers: dco=
-win, wintun, and tap-windows6=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    OpenVPN 2=2E7 now drops the support for wintun driver=2E By=
 default</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    all moder=
n configs should be supported by dco-win driver=2E In all</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    other cases OpenVPN will fall back =
automatically to tap-windows6</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    driver=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-NTLMv1 authentication=
 support for HTTP proxies has been removed=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    This is considered an insecure method of authen=
tication that uses</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 obsolete crypto algorithms=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    NTLMv2 support is still available, but will be removed in a fu=
ture</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    release=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    When configured to a=
uthenticate with NTLMv1 (``ntlm`` keyword in</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ``--http-proxy``) OpenVPN will try NTLMv2 instea=
d=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-``persist-key`` option has been enable=
d by default=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Al=
l the keys will be kept in memory across restart=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-OpenSSL 1=2E0=2E2 support has been removed=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    Support for building with OpenSSL 1=
=2E0=2E2 has been removed=2E The minimum</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    supported OpenSSL version is now 1=2E1=2E0=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-mbedTLS 2=2Ex support has been removed</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    Support for building with mb=
edTLS 2=2Ex has been removed (it is out</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    of support since March 2025, and the necessary compat=
ibility code</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is ma=
king maintenance and support for mbedTLS 4=2Ex hard)=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    The minimum supported mbedTLS version=
 is now 3=2E2=2E1=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-Compression on send ha=
s been removed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
OpenVPN 2=2E7 will never compress data before sending=2E Decompression of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    received data is st=
ill supported=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    `=
`--allow-compression yes`` is now an alias for</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ``--allow-compression asym``=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-``--memstats`` feature removed</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    The ``--memstats`` option was largely undocu=
mented and there is no known</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    user of this feature=2E  This feature provided very limited stat=
istics</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (number of =
users, link bytes read/written) and we do not except any</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    usage because of this=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-Using ``--push`` in a mode that is not ``--mode server=
`` will now print a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  clear warning that this is an unsupported operation and might cause</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    negotiation failures=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-``--reneg-bytes`` and ``--reneg-packets`` =
do not work in DCO mode, and will</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    now print an appropriate warning=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-On-connect resolving of ``--remote`` addresses in ``--tcp-server=
`` mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    was not wo=
rking since 2=2E4, so the code was completely removed=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-User-vi=
sible Changes</span><br><span>---------------------</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- Default for ``--topology`` changed to ``s=
ubnet`` for ``--mode server``=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  Previous releases always used ``net30`` as default=2E This onl=
y affects</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  configs wi=
th ``--mode server`` or ``--server`` (the latter implies the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  former), and ``--dev tun``, and on=
ly if IPv4 is enabled=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  Note that this changes the semantics of ``--ifconfig``, so if you have=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  manual settings for=
 that in your config but not set ``--topology``</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  your config might fail to parse with the new ve=
rsion=2E Just adding</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 ``--topology net30`` to the config should fix the problem=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  By default ``--topology`` is push=
ed from server to client=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--x509-user=
name-field`` will no longer automatically convert fieldnames to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  uppercase=2E This was deprecate=
d since OpenVPN 2=2E4, and has now been removed=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- ``--dh none`` is now the default if ``--dh`` is not specified=2E =
Modern TLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  implement=
ations will prefer ECDH and other more modern algorithms anyway=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  And finite field Diffie Hell=
man is in the proces of being deprecated</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  (see draft-ietf-tls-deprecate-obsolete-kex)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- ``--lport 0`` does not imply ``--bind`` anymore=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- ``--redirect-gateway`` now works correctl=
y if the VPN remote is not</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  reachable by the default gateway=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
- ``--show-gateway`` now supports querying the gateway for IPv4 addresses=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- ``--static-challenge`` option now has=
 a third parameter ``format`` that</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  can change how password and challenge response should be com=
bined=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- ``--key`` and ``--cert`` now acc=
ept URIs implemented in OpenSSL 3 as well as</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  optional OpenSSL 3 providers loaded using ``--prov=
iders`` option=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--cryptoapicert`` now=
 supports issuer name as well as Windows CA template</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  name or OID as selector string=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-- TLS handshake debugging information contains muc=
h more details now when</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  using recent versions of OpenSSL=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- T=
he ``IV_PLAT_VER`` variable sent by Windows clients now contains the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  full Windows build version=
 to make it possible to determine the</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  Windows 10 or Windows 11 version used=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-- The ``--windows-driver`` option to select between various=
 windows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  drivers wil=
l no longer do anything - it&#39;s kept so existing configs</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  will not become invalid, but it is =
ignored with a warning=2E  The default</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  is now ``ovpn-dco`` if all options used are compatible w=
ith DCO, with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  a fall=
back to ``tap-windows6``=2E  To force TAP (for example because a</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  server pushes DCO incompatible=
 options), use the ``--disable-dco``</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  option=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Apply more che=
cks to incoming TLS handshake packets before creating</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  new state - namely, verify message ID / a=
cked ID for &quot;valid range for</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  an initial packet&quot;=2E  This fixes a problem with clients=
 that float</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  very ear=
ly but send control channel packet from the pre-float IP</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  (Github: OpenVPN/openvpn#704)=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- Use of ``--dh dh2048=2Epem`` in all sample con=
figs has been replaced</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  with ``--dh none``=2E  The ``dh2048=2Epem`` file has been removed=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- The startup delay in ``t_client=2Esh`` has b=
een reduced from 3s to 1s,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  making a noticeable difference for setups with many tests=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-- Changed from using ``uncrustify`` for code forma=
tting and pre-commit checks</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  to ``clang-format``=2E  This reformatted quite a bit of code, and r=
equires</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  that regular=
 committers change their pre-commit checks accordingly=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-- On Linux, on interfaces where applicable, OpenVPN explicit=
ly configures</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the br=
oadcast address again=2E  This was dropped for 2=2E6=2E0 &quot;because</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  computers are smart and =
can do it themselves&quot;, but the kernel netlink</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  interface isn&#39;t, and will install &quot;=
0=2E0=2E0=2E0&quot;=2E  This does not normally</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  matter, but for broadcast-based applications tha=
t get the address to</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 use from &quot;ifconfig&quot;, this change repairs functionality (this has=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  been backported to =
2=2E6=2E15, but is not in earlier 2=2E6 versions)=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-- ``max-routes-per-client 0`` used to be silently upgraded to ``=
1``=2E  This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  now pro=
duces an error=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``ifconfig`` and ``ifco=
nfig-ipv6`` values are now stored in pre-connect</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  options cache, and will be restored to pre-con=
nect values on reconnects</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  if the server stops pushing the respective option=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-- ``tapctl=2Eexe`` helper binary on Windows has been rework=
ed to improve</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  help t=
exts (making clear that it can not only do TAP-Adapters but</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  Win-DCO as well), add printing of t=
he hwid to all adapter outputs, and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  change the default adapter type created to ``ovpn-dco``=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- The default for ``multihome`` egress inte=
rface handling has changed=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  2=2E7=2E0 will default to ipi_ifindex=3D0, that is, leave the dec=
ision to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  routing=
/policy setup of the operating system=2E  The pre-2=2E7 behaviour</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  (force egress =3D ingress int=
erface) can be achieved with the new</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  ``--multihome same-interface`` sub-option=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-- Windows ``openvpn=2Eexe`` binary manifest now sets cod=
e page UTF8 - which</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
has no direct effect on OpenVPN itself, but this repairs OpenSSL file</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  loading for key/cert file=
s with non-ASCII characters in their file names</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  (GH: OpenVPN/openvpn#920)=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-- The ``test-crypto`` option no longer requires a ``--secret`=
` argument and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  will =
automatically generate a random key=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Th=
e configure-time option ``--enable-x509-alt-username`` is no longer</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  conditional, and always-on =
(GH: OpenVPN/openvpn#917)=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-Deprecated features</span><br><span=
>--------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
``--opt-verify`` feature removed</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    This option was already deprecated and it is now being conve=
rted to a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    no-op=2E=
 Using this option will only print a warning=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Overview of chan=
ges in 2=2E6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Project changes</span><br><span>----------------=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-We want to deprecate our old Trac bug trac=
king system=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Please =
report any issues with this release in GitHub</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-instead: https://github=2Ecom/OpenVPN/openvpn/issue=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-New features</span><br><span>------------=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support unlimited nu=
mber of connection entries and remote entries</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-New management commands to enumerate and list remote entries</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    Use ``remote-entry-count`` an=
d ``remote-entry-get``</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    commands from the management interface to get the number of</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    remote entries and the entri=
es themselves=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Keying Material Exporters =
(RFC 5705) based key generation</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    As part of the cipher negotiation OpenVPN will automatically =
prefer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the RFC5705=
 based key material generation to the current custom</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenVPN PRF=2E This feature requires Op=
enSSL or mbed TLS 2=2E18+=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Compatibility =
with OpenSSL in FIPS mode</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    OpenVPN will now work with OpenSSL in FIPS mode=2E Note, no effort<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    has been made to c=
heck or implement all the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    requirements/recommendation of FIPS 140-2=2E This just allows OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to be run on a =
system that be configured OpenSSL in FIPS mode=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-``mlock`` will now check if enough memlock-able memory has been rese=
rved,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    and if less =
than 100MB RAM are available, use setrlimit() to upgrade</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    the limit=2E  See Trac #1390=2E  Not=
 available on OpenSolaris=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Certificate pi=
nning/verify peer fingerprint</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    The ``--peer-fingerprint`` option has been introduced to give u=
sers an</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    easy to us=
e alternative to the ``tls-verify`` for matching the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    fingerprint of the peer=2E The option t=
akes use a number of allowed</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SHA256 certificate fingerprints=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    See the man page section &quot;Small OpenVPN setup with peer-fingerp=
rint&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for a t=
utorial on how to use this feature=2E This is also available online</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    under https://github=2Eco=
m/openvpn/openvpn/blob/master/doc/man-sections/example-fingerprint=2Erst</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-TLS mode with self-signed certificates</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    When ``--peer-fingerpr=
int`` is used, the ``--ca`` and ``--capath`` option</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    become optional=2E This allows for smal=
l OpenVPN setups without setting up</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    a PKI with Easy-RSA or similar software=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-Deferred auth support for scripts</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    The ``--auth-user-pass-verify`` script =
supports now deferred authentication=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Pen=
ding auth support for plugins and scripts</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    Both auth plugin and script can now signal pending =
authentication to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
the client when using deferred authentication=2E The new ``client-crrespons=
e``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    script option =
and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin function can</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    be used to parse a client respon=
se to a ``CR_TEXT`` two factor challenge=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    See ``sample/sample-scripts/totpauth=2Epy`` for an example=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-Compatibility mode (``--compat-mode``)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    The modernisation of defaults =
can impact the compatibility of OpenVPN 2=2E6=2E0</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    with older peers=2E The options ``--compat-=
mode`` allows UIs to provide users</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    with an easy way to still connect to older servers=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-OpenSSL 3=2E0 support</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    OpenSSL 3=2E0 has been added=2E Most of Ope=
nSSL 3=2E0 changes are not user visible but</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    improve general compatibility with OpenSSL 3=2E0=
=2E ``--tls-cert-profile insecure``</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    has been added to allow selecting the lowest OpenSSL secu=
rity level (not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
commended, use only if you must)=2E OpenSSL 3=2E0 no longer supports the Bl=
owfish</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (and other =
deprecated) algorithm by default and the new option ``--providers``</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    allows loading the legacy=
 provider to renable these algorithms=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Op=
tional ciphers in ``--data-ciphers``</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    Ciphers in ``--data-ciphers`` can now be prefixed with a=
 ``?`` to mark</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tho=
se as optional and only use them if the SSL library supports them=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-Improved ``--mssfix`` and ``--fragment`` calculation</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    The ``--mssfix`` and ``--fragment``=
 options now allow an optional :code:`mtu`</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    parameter to specify that different overhead for I=
Pv4/IPv6 should taken into</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    account and the resulting size is specified as the total size of t=
he VPN packets</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inc=
luding IP and UDP headers=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Cookie based h=
andshake for UDP server</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    Instead of allocating a connection for each client on the initial pac=
ket</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN server=
 will now use an HMAC based cookie as its session id=2E This</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    way the server can verify it on =
completing the handshake without keeping</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    state=2E This eliminates the amplification and resou=
rce exhaustion attacks=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    For tls-crypt-v2 clients, this requires OpenVPN 2=2E6 clients or la=
ter</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    because the cl=
ient needs to resend its client key on completing the hand</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    shake=2E The tls-crypt-v2 option a=
llows controlling if older clients are</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    accepted=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    By def=
ault the rate of initial packet responses is limited to 100 per 10s</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    interval to avoid OpenVPN=
 servers being abused in reflection attacks</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    (see ``--connect-freq-initial``)=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-Data channel offloading with ovpn-dco</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    2=2E6=2E0+ implements support for da=
ta-channel offloading where the data packets</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    are directly processed and forwarded in kernel s=
pace thanks to the ovpn-dco</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    kernel module=2E The userspace openvpn program acts purely as a c=
ontrol plane</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    appli=
cation=2E Note that DCO will use DATA_V2 packets in P2P mode, therefore,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    this implies that pe=
ers must be running 2=2E6=2E0+ in order to have P2P-NCP</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    which brings DATA_V2 packet support=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-Session timeout</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    It is now possible to terminate a sessi=
on (or all) after a specified amount</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    of seconds has passed session commencement=2E This behav=
iour can be configured</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    using ``--session-timeout``=2E This option can be configured on the se=
rver, on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the clien=
t or can also be pushed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Inline auth user=
name and password</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
Username and password can now be specified inline in the configuration file=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    within the &lt;au=
th-user-pass&gt;&lt;/auth-user-pass&gt; tags=2E If the password is</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    missing OpenVPN will promp=
t for input via stdin=2E This applies to inline&#39;d</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    http-proxy-user-pass too=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-Tun MTU can be pushed</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    The  client can now also dynamically configure its=
 MTU and the server</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  will try to push the client MTU when the client supports it=2E The</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    directive ``--tun-mtu-ma=
x`` has been introduced to increase the maximum</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    pushable MTU size (defaults to 1600)=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Dynamic TLS Crypt</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    When both peers are OpenVPN 2=2E6=2E1+, OpenVPN =
will dynamically create</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    a tls-crypt key that is used for renegotiation=2E This ensure that on=
ly the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    previously =
authenticated peer can do trigger renegotiation and complete</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    renegotiations=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-Improved control channel packet size control (``max-packe=
t-size``)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The size=
 of control channel is no longer tied to</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ``--link-mtu``/``--tun-mtu`` and can be set using ``=
--max-packet-size``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    Sending large control channel frames is also optimised by allowing 6</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    outstanding packets=
 instead of just 4=2E ``max-packet-size`` will also set</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ``mssfix`` to try to limit data-chann=
el packets as well=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Deprecated features</=
span><br><span>--------------------</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-``inetd`` has been removed</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    This was a very limited and not-well-tested way to r=
un OpenVPN, on TCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 and TAP mode only=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``verify-hash`` has b=
een deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Thi=
s option has very limited usefulness and should be replaced by either</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    a better ``--ca`` confi=
guration or with a ``--tls-verify`` script=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-``secret`` has been deprecated</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    static key mode (non-TLS) is no longer considered &quot;goo=
d and secure enough&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for today&#39;s requirements=2E  Use TLS mode instead=2E  If deploy=
ing a PKI CA</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is co=
nsidered &quot;too complicated&quot;, using ``--peer-fingerprint`` makes</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    TLS mode about as ea=
sy as using ``--secret``=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``ncp-disable``=
 has been removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
This option mainly served a role as debug option when NCP was first</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    introduced=2E It should n=
ow no longer be necessary=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TLS 1=2E0 and =
1=2E1 are deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ``tls-version-min`` is set to 1=2E2 by default=2E  OpenVPN 2=2E6=2E0 def=
aults</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to a minimum=
 TLS version of 1=2E2 as TLS 1=2E0 and 1=2E1 should be generally</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    avoided=2E Note that OpenVPN=
 versions older than 2=2E3=2E7 use TLS 1=2E0 only=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-``--cipher`` argument is no longer appended to ``--data-ciphers`=
`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    by default=2E Da=
ta cipher negotiation has been introduced in 2=2E4=2E0</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    and been significantly improved in 2=
=2E5=2E0=2E The implicit fallback</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    to the cipher specified in ``--cipher`` has been removed=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Effectively, ``--=
cipher`` is a no-op in TLS mode now, and will</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    only have an effect in pre-shared-key mode (``-=
-secret``)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    From=
 now on ``--cipher`` should not be used in new configurations</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for TLS mode=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    Should backwards compatibility wi=
th older OpenVPN peers be</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    required, please see the ``--compat-mode`` instead=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-``--prng`` has beeen removed</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    OpenVPN used to implement its own PRNG based =
on a hash=2E However implementing</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    a PRNG is better left to a crypto library=2E So we use the =
PRNG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbed TLS or O=
penSSL now=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-``--keysize`` has been remove=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--keysize`=
` option was only useful to change the key length when using the</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    BF, CAST6 or RC2 ciphers=2E =
For all other ciphers the key size is fixed with the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    chosen cipher=2E As OpenVPN v2=2E6 no l=
onger supports any of these variable length</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ciphers, this option was removed as well to avoid=
 confusion=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Compression no longer enabled=
 by default</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Unless=
 an explicit compression option is specified in the configuration,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ``--allow-compression`` de=
faults to ``no`` in OpeNVPN 2=2E6=2E0=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    By default, OpenVPN 2=2E5 still allowed a server to =
enable compression by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    pushing compression related options=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
PF (Packet Filtering) support has been removed</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   The built-in PF functionality has been removed =
from the code base=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   feature wasn&#39;t really easy to use and was long unmaintained=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   This implies that a=
lso ``--management-client-pf`` and any other compile</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   time or run time related option do not e=
xist any longer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-Option conflict checking=
 is being deprecated and phased out</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    The static option checking (OCC) is no longer useful in t=
ypical setups</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    that=
 negotiate most connection parameters=2E The ``--opt-verify`` and</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ``--occ-disable`` options a=
re deprecated, and the configure option</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ``--enable-strict-options`` has been removed=2E Loggi=
ng of mismatched</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
ptions has been moved to debug logging (verb 7)=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-User-visible Changes</span><br><span>---------------------</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-- CHACHA20-POLY1305 is include=
d in the default of ``--data-ciphers`` when available=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-- Option ``--prng`` is ignored as we rel=
y on the SSL library random number generator=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-- Option ``--nobind`` is default when ``--client`=
` or ``--pull`` is used in the configuration</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-- :code:`link_mtu` parameter is removed from environ=
ment or replaced with 0 when scripts are</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  called with parameters=2E This parameter is unreliable=
 and no longer internally calculated=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- c=
ontrol channel packet maximum size is no longer influenced by</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  ``--link-mtu``/``--tun-mtu`` and =
must be set by ``--max-packet-size`` now=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  The default is 1250 for the control channel size=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- In point-to-point OpenVPN setups (no ``-=
-server``), using</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``=
--explict-exit-notiy`` on one end would terminate the other side at</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  session end=2E  This is con=
sidered a no longer useful default and has</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  been changed to &quot;restart on reception of explic=
it-exit-notify message&quot;=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  If the old behaviour is still desired, ``--remap-usr1 SIGTERM``=
 can be used=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-- FreeBSD tun interfaces wi=
th ``--topology subnet`` are now put into real</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  subnet mode (IFF_BROADCAST instead of IFF_POINTO=
POINT) - this might upset</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  software that enumerates interfaces, looking for &quot;broadcast capa=
ble?&quot; and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  expec=
ting certain results=2E  Normal uses should not see any difference=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- The default configurations will no longer allo=
w connections to OpenVPN 2=2E3=2Ex</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  peer or earlier, use the new ``--compat-mode`` option if you=
 need</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compatibility =
with older versions=2E See the manual page on the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  ``--compat-mode`` for details=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- The ``client-pending-auth`` management command now re=
quires also the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  key =
id=2E The management version has been changed to 5 to indicate this change=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- (OpenVPN 2=2E6=2E2) A client will now=
 refuse a connection if pushed compression</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  settings will contradict the setting of allow-compre=
ssion as this almost</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 always results in a non-working connection=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- The &quot;kill&quot; by addr management command now requires also the=
 protocol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  as string =
e=2Eg=2E &quot;udp&quot;, &quot;tcp&quot;=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-Common errors with OpenSSL 3=2E0 and OpenVPN 2=2E6</span><br><span>------=
-----------------------------------------</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Both OpenVPN 2=2E6 and OpenSSL 3=2E0 tighten the securi=
ty considerable, so some</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-configuration will no longer work=2E This section will cover the most co=
mmon</span><br><span style=3D"color: hsl(0, 100%, 40%);">-causes and error =
message we have seen and explain their reason and temporary</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-workarounds=2E You should fix the und=
erlying problems as soon as possible since</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-these workaround are not secure and will eventually st=
op working in a future</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-update=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-- weak SHA1 or MD5 signature on =
certificates</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  This will happen on either l=
oading of certificates or on connection</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  to a server::</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      Ope=
nSSL: error:0A00018E:SSL routines::ca md too weak</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      Cannot load certificate file cert=2Ecrt</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      Exiting due to fa=
tal error</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  OpenSSL 3=2E0 no longer allows =
weak signatures on certificates=2E You can</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  downgrade your security to allow them by using ``--t=
ls-cert-profile insecure``</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  but should replace/regenerate these certificates as soon as possible=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-- 1024 bit RSA certificates, 1024 bit DH parameters, other w=
eak keys</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  This happens if you use private =
keys or other cryptographic material that</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  does not meet today&#39;s cryptographic standards any=
more=2E Messages are similar</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  to::</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-      OpenSSL: error:0A00018F=
:SSL routines::ee key too small</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      OpenSSL: error:1408518A:SSL routines:ssl3_ctx_ctrl:dh key t=
oo small</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  DH parameters (``--dh``) can be =
regenerated with ``openssl dhparam 2048``=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  For other cryptographic keys, these keys and certi=
ficates need to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  r=
egenerated=2E TLS Security level can be temporarily lowered with</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-cert-profile legacy`` =
or even ``--tls-cert-profile insecure``=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
- Connecting to a OpenVPN 2=2E3=2Ex server or allowing OpenVPN 2=2E3=2Ex or=
 earlier</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  clients</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  This will normally result in messages like::=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     OPTIONS ERROR: failed to negotiate ci=
pher with server=2E  Add the server&#39;s cipher (&#39;AES-128-CBC&#39;) to=
 --data-ciphers (currently &#39;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&#=
39;) if you want to connect to this server=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     client/127=2E0=2E0=2E1:4995=
4 SENT CONTROL [client]: &#39;AUTH_FAILED,Data channel cipher negotiation f=
ailed (no shared cipher)&#39; (status=3D1)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  You can manually add the missing cipher to the ``--data-ciphers``=2E The<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  standard ciphers sho=
uld be included as well, e=2Eg=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``--data-ciphers AES-256-GCM:AES-128-GCM:?Chacha20-Poly1305:?=
AES-128-CBC``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  You=
 can also use the ``--compat-mode`` option=2E Note that these message may</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  also indicate other c=
ipher configuration problems=2E See the data channel</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  cipher negotiation manual section for mor=
e details=2E (Available online under</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  https://github=2Ecom/OpenVPN/openvpn/blob/master/doc/man-s=
ections/cipher-negotiation=2Erst)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Use of =
a legacy or deprecated cipher (e=2Eg=2E 64bit block ciphers)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  OpenSSL 3=2E0 no longer supports a number of insecure a=
nd outdated ciphers in</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  its default configuration=2E Some of these ciphers are known to be vulne=
rable (SWEET32 attack)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This will typic=
ally manifest itself in messages like::</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   OpenSSL: error:0308010C:digital envelope routines::unsupported</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      Cipher algorithm &#39;BF-=
CBC&#39; not found</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   Unsupported cipher in --data-ciphers: BF-CBC</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  If your OpenSSL distribution comes with the legacy provider (see</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  also ``man OSSL_PROVIDE=
R-legacy``), you can load it with</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``--providers legacy default``=2E  This will re-enable the ol=
d algorithms=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-- OpenVPN version not suppo=
rting TLS 1=2E2 or later</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The default in O=
penVPN 2=2E6 and also in many distributions is now TLS 1=2E2 or</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  later=2E Connecting to a peer t=
hat does not support this will results in</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  messages like::</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    T=
LS error: Unsupported protocol=2E This typically indicates that client and<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    server have no com=
mon TLS version enabled=2E This can be caused by mismatched</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    tls-version-min and tls-version-m=
ax options on client and server=2E If your</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    OpenVPN client is between v2=2E3=2E6 and v2=2E3=2E=
2 try adding tls-version-min 1=2E0</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    to the client configuration to use TLS 1=2E0+ instead of T=
LS 1=2E0 only</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Open=
SSL: error:0A000102:SSL routines::unsupported protocol</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  This can be an OpenVPN 2=2E3=2E6 or earlier version=2E ``comp=
at-version 2=2E3=2E0`` will</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  enable TLS 1=2E0 support if supported by the OpenSSL distribution=
=2E Note that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  on som=
e Linux distributions enabling TLS 1=2E1 or 1=2E0 is not possible=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Overview of chan=
ges in 2=2E5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-New features</span><br><span>-------------</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Client-specific tls-crypt k=
eys (``--tls-crypt-v2``)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ``tls-crypt-v2`` adds the ability to supply each client with a uniqu=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls-crypt key=2E=
  This allows large organisations and VPN providers to profit</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    from the same DoS and TLS stack=
 protection that small deployments can</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    already achieve using ``tls-auth`` or ``tls-crypt``=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-ChaCha20-Poly1305 cipher support</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    Added support for using the=
 ChaCha20-Poly1305 cipher in the OpenVPN data</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    channel=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Impr=
oved Data channel cipher negotiation</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    The option ``ncp-ciphers`` has been renamed to ``data-ci=
phers``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The old=
 name is still accepted=2E The change in name signals that</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ``data-ciphers`` is the preferred =
way to configure data channel</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ciphers and the data prefix is chosen to avoid the ambiguity th=
at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exists with ``-=
-cipher`` for the data cipher and ``tls-cipher``</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for the TLS ciphers=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    OpenVPN clients will now signal all supported ciphers from t=
he</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``data-ciphers`=
` option to the server via ``IV_CIPHERS``=2E OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    servers will select the first common ci=
pher from the ``data-ciphers``</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    list instead of blindly pushing the first cipher of the list=
=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    allows to=
 use a configuration like</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    prefers ChaCha20-Po=
ly1305 but uses it only if the client supports it=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    See the data channel negotiation section in the manual for m=
ore details=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-Removal of BF-CBC support in=
 default configuration:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    By default OpenVPN 2=2E5 will only accept AES-256-GCM and AES-128-GCM=
 as</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    data ciphers=
=2E OpenVPN 2=2E4 allows AES-256-GCM,AES-128-GCM and BF-CBC when</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    no --cipher and --ncp-cipher=
s options are present=2E Accepting BF-CBC can be</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    enabled by adding</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    and when you need to support very old peers also</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        data-ciphers-fallback BF-CBC</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    To offer backwards compatibility with older configs =
an *explicit*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cipher BF-CBC</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    in the configuration will be automatically tra=
nslated into adding BF-CBC</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    to the data-ciphers option and setting data-ciphers-fallback to BF=
-CBC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (as in the ex=
ample commands above)=2E We strongly recommend to switching</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    away from BF-CBC to a more secure=
 cipher=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-Asynchronous (deferred) authenti=
cation support for auth-pam plugin=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    See src/plugins/auth-pam/README=2Eauth-pam for details=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-Deferred client-connect</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    The ``--client-connect`` option a=
nd the connect plugin API allow</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    asynchronous/deferred return of the configuration file in the=
 same way</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as the a=
uth-plugin=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Faster connection setup</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    A client will signal in=
 the ``IV_PROTO`` variable that it is in pull</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mode=2E This allows the server to push the conf=
iguration options to</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   the client without waiting for a ``PULL_REQUEST`` message=2E The feature=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is automatically =
enabled if both client and server support it and</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    significantly reduces the connection setup t=
ime by avoiding one</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  extra packet round-trip and 1s of internal event delays=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-Netlink support</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    On Linux, if configured without ``--enable-iproute2``, conf=
iguring IP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    address=
es and adding/removing routes is now done via the netlink(3)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    kernel interface=2E  This is muc=
h faster than calling ``ifconfig`` or</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ``route`` and also enables OpenVPN to run with less pri=
vileges=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    If configured with --enable-=
iproute2, the ``ip`` command is used</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    (as in 2=2E4)=2E  Support for ``ifconfig`` and ``route``=
 is gone=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-Wintun support</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    On Windows, OpenVPN can now use ``=
wintun`` devices=2E  They are faster</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    than the traditional ``tap9`` tun/tap devices, but do no=
t provide</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--dev =
tap`` mode - so the official installers contain both=2E  To use</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    a wintun device, add ``--wind=
ows-driver wintun`` to your config</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    (and use of the interactive service is required as wintun =
needs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SYSTEM privi=
leges to enable access)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IPv6-only operat=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    It is now poss=
ible to have only IPv6 addresses inside the VPN tunnel,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    and IPv6-only address pools (2=2E4 al=
ways required IPv4 config/pools</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    and IPv6 was the &quot;optional extra&quot;)=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-Improved Windows 10 detection</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    Correctly log OS on Windows 10 now=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-Linux VRF support</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    Using the new ``--bind-dev`` option, the OpenVPN =
outside socket can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 now be put into a Linux VRF=2E  See the &quot;Virtual Routing and Forwardi=
ng&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    documenta=
tion in the man page=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TLS 1=2E3 support</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    TLS 1=2E3 support h=
as been added to OpenVPN=2E  Currently, this requires</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenSSL 1=2E1=2E1+=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    The options ``--tls-ciphersuites`` =
and ``--tls-groups`` have been</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    added to fine tune TLS protocol options=2E  Most of the improv=
ements</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    were also b=
ackported to OpenVPN 2=2E4 as part of the maintainance</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    releases=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-Support setting DHCP search domain</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    A new option ``--dhcp-option DOMAIN-SEARCH my=2Eexam=
ple=2Ecom`` has been</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   defined, and Windows support for it is implemented (tun/tap only, no</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    wintun support yet)=
=2E  Other platforms need to support this via ``--up``</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    script (Linux) or GUI (OSX/Tunnelblick=
)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-per-client changing of ``--data-cipher=
s`` or ``data-ciphers-fallback``</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    from client-connect script/dir (NOTE: this only changes pref=
erence of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ciphers =
for NCP, but can not override what the client announces as</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;willing to accept&quot;)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Handle setting of tun/tap interface MTU on Win=
dows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    If IPv6 is in=
 use, MTU must be &gt;=3D 1280 (Windows enforces IETF requirements)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-Add support for OpenSSL engines to access private =
key material (like TPM)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-HMAC based auth-=
token support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The =
``--auth-gen-token`` support has been improved and now generates HMAC</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    based user token=2E If =
the optional ``--auth-gen-token-secret`` option is</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    used clients will be able to seamlessly re=
connect to a different server</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    using the same secret file or to the same server after a server=
 restart=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-Improved support for pending au=
thentication</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The p=
rotocol has been enhanced to be able to signal that</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    the authentication should use a seconda=
ry authentication</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
via web (like SAML) or a two factor authentication without</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    disconnecting the OpenVPN session =
with AUTH_FAILED=2E The</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    session will instead be stay in a authenticated state and</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    wait for the second factor au=
thentication to complete=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    This featur=
e currently requires usage of the managent interface</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    on both client and server side=2E See t=
he ``management-notes=2Etxt``</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ``client-pending-auth`` and ``cr-response`` commands for more</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    details=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-VLAN support</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    OpenVPN servers in TAP mode can now use 802=2E1q tagged =
VLANs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    on the TAP i=
nterface to separate clients into different groups</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    that can then be handled differently (diff=
erent subnets / DHCP,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    firewall zones, =2E=2E=2E) further down the network=2E  See the new</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    options ``--vlan-tagg=
ing``, ``--vlan-accept``, ``--vlan-pvid``=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    802=2E1q tagging on the client side TAP interface is not handled</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    today (=3D tags are ju=
st forwarded transparently to the server)=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-Support building of =2Emsi installers for Windows</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Allow unicode search string in ``--cryptoapicert`` option (Windo=
ws)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-Support IPv4 configs with /31 netmasks =
now</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (By no longer =
trying to configure ``broadcast x=2Ex=2Ex=2Ex`` in</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ifconfig calls, /31 support &quot;just wor=
ks&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-New option ``--block-ipv6`` to re=
ject all IPv6 packets (ICMPv6)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    this is useful if the VPN service has no IPv6, but the clients=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    might have (LAN),=
 to avoid client connections to IPv6-enabled</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    servers leaking &quot;around&quot; the IPv4-only=
 VPN=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-``--ifconfig-ipv6`` and ``--ifconfi=
g-ipv6-push`` will now accept</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    hostnames and do a DNS lookup to get the IPv6 address to use</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Deprecated features</span><br><span>--------------------</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-For an up-to-date list of all=
 deprecated options, see this wiki page:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-https://community=2Eopenvpn=2Enet/openvpn/wiki/Deprecate=
dOptions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- ``ncp-disable`` has been depreca=
ted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    With the impro=
ved and matured data channel cipher negotiation, the use</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    of ``ncp-disable`` should not be nec=
essary anymore=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``inetd`` has been depr=
ecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This is a ver=
y limited and not-well-tested way to run OpenVPN, on TCP</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  and TAP mode only, which complicates t=
he code quite a bit for little gain=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  To be removed in OpenVPN 2=2E6 (unless users protest)=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``no-iv`` has been removed</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  This option was made into a NOOP =
option with OpenVPN 2=2E4=2E  This has now</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  been completely removed=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-- ``--client-cert-not-required`` has been removed</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  This option will now cause server conf=
igurations to not start=2E  Use</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  ``--verify-client-cert none`` instead=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-- ``--ifconfig-pool-linear`` has been removed</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  This option is removed=2E  Use ``--top=
ology p2p`` or ``--topology subnet``</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  instead=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--compress =
xxx`` is considered risky and is warned against, see below=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-- ``--key-method 1`` has been removed</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-User-vi=
sible Changes</span><br><span>---------------------</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- If multiple connect handlers are used (cl=
ient-connect, ccd, connect</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  plugin) and one of the handler succeeds but a subsequent fails, the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  client-disconnect-sc=
ript is now called immediately=2E Previously it</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  was called, when the VPN session was terminated=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- Support for building with OpenSSL 1=
=2E0=2E1 has been removed=2E The minimum</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  supported OpenSSL version is now 1=2E0=2E2=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-- The GET_CONFIG management state is omitted if the=
 server pushes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the c=
lient configuration almost immediately as result of the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  faster connection setup feature=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-- ``--compress`` is nowadays considered risky, =
because attacks exist</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  leveraging compression-inside-crypto to reveal plaintext (VORACLE)=2E  So=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  by default, ``--com=
press xxx`` will now accept incoming compressed</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  packets (for compatibility with peers that have=
 not been upgraded yet),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  but will not use compression outgoing packets=2E  This can be controll=
ed with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the new opti=
on ``--allow-compression yes|no|asym``=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">--=
 Stop changing ``--txlen`` aways from OS defaults unless explicitly specifi=
ed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in config file=2E=
  OS defaults nowadays are actually larger then what we used</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  to configure, so our defaults some=
times caused packet drops =3D bad performance=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- remove ``--writepid`` pid file on exit now</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- plugin-auth-pam now logs via OpenVPN logging method, no longer to=
 stderr</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (this means =
you&#39;ll have log messages in syslog or openvpn log file now)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-- use ISO 8601 time format for file based logging now =
(YYYY-MM-DD hh:mm:dd)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  (syslog is not affected, nor is ``--machine-readable-output``)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- ``--clr-verify`` now loads all CRLs if more than on=
e CRL is in the same</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 file (OpenSSL backend only, mbedTLS always did that)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-- when ``--auth-user-pass file`` has no password, and the manage=
ment interface</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is ac=
tive, query management interface (instead of trying console query,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  which does not work on windo=
ws)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- skip expired certificates in Windows =
certificate store (``--cryptoapicert``)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `=
`--socks-proxy`` + ``--proto udp*`` will now allways use IPv4, even if</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  IPv6 is requested and av=
ailable=2E  Our SOCKS code does not handle IPv6+UDP,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  and before that change it would just fail=
 in non-obvious ways=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- TCP listen() back=
log queue is now set to 32 - this helps TCP servers that</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  receive lots of &quot;invalid&quot; co=
nnects by TCP port scanners</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- do no longer =
print OCC warnings (&quot;option mismatch&quot;) about ``key-method``,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``keydir``, ``tls-auth``=
 and ``cipher`` - these are either gone now, or</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  negotiated, and the warnings do not serve a use=
ful purpose=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-- ``dhcp-option DNS`` and ``=
dhcp-option DNS6`` are now treated identically</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  (=3D both accept an IPv4 or IPv6 address for the=
 nameserver)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-Maintainer-visible changes</span><br><span>--------=
-------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- =
the man page is now in maintained in =2Erst format, so building the openvpn=
=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  manpage from a =
git checkout now requires python-docutils (if this is missing,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  the manpage will not be built - =
which is not considered an error generally,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  but for package builders or ``make distcheck`` it i=
s)=2E  Release tarballs</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  contain the openvpn=2E8 file, so unless some =2Erst is changed, doc-uti=
ls are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  not needed fo=
r building=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- OCC support can no longer b=
e disabled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-- AEAD support is now required i=
n the crypto library</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--disable-server``=
 has been removed from configure (so it is no longer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  possible to build a client-/p2p-only Open=
VPN binary) - the saving in code</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  size no longer outweighs the extra maintenance effort=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- ``--enable-iproute2`` will disable netlink(3) =
support, so maybe remove</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  that from package building configs (see above)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-- support building with MSVC 2019</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- cmocka based unit tests are now only run if cmocka is installed externa=
lly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2=2E4 used to s=
hip a local git submodule which was painful to maintain)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-- ``--disable-crypto`` configure option has been removed=2E  =
OpenVPN is now always</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  built with crypto support, which makes the code much easier to maintain=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This does not af=
fect ``--cipher none`` to do a tunnel without encryption=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-- ``--disable-multi`` configure option has been removed</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Overview o=
f changes in 2=2E4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-New features</span><br><span>-------------</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-Seamless client IP/port floating</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    Added new packet format P_D=
ATA_V2, which includes peer-id=2E If both the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    server and client support it, the client sends =
all data packets in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  the new format=2E When a data packet arrives, the server identifies peer<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    by peer-id=2E If p=
eer&#39;s ip/port has changed, server assumes that</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    client has floated, verifies HMAC and upda=
tes ip/port in internal structs=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    This allows the connection to be immediately restored, ins=
tead of requiring</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
a TLS handshake before the server accepts packets from the new client</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ip/port=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-Data channel cipher negotiation</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    Data channel ciphers (``--cipher``) are=
 now by default negotiated=2E  If a</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    client advertises support for Negotiable Crypto Parameter=
s (NCP), the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    serve=
r will choose a cipher (by default AES-256-GCM) for the data channel,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    and tell the client to =
use that cipher=2E  Data channel cipher negotiation</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    can be controlled using ``--ncp-ciphers=
`` and ``--ncp-disable``=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A more limi=
ted version also works in client-to-server and server-to-client</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    scenarios where one of the en=
d points uses a v2=2E4 client or server and the</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    other side uses an older version=2E  In such =
scenarios the v2=2E4 side will</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    change to the ``--cipher`` set by the remote side, if permitte=
d by by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--ncp-ci=
phers``=2E  For example, a v2=2E4 client with ``--cipher BF-CBC``</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    and ``ncp-ciphers AES-256-G=
CM:AES-256-CBC`` can connect to both a v2=2E3</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    server with ``cipher BF-CBC`` as well as a serv=
er with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``cipher A=
ES-256-CBC`` in its config=2E  The other way around, a v2=2E3 client</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    with either ``cipher BF-=
CBC`` or ``cipher AES-256-CBC`` can connect to a</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    v2=2E4 server with e=2Eg=2E ``cipher BF-CBC`=
` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``ncp-cipher=
s AES-256-GCM:AES-256-CBC`` in its config=2E  For this to work</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    it requires that OpenVPN was b=
uilt without disabling OCC support=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AEAD =
(GCM) data channel cipher support</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    The data channel now supports AEAD ciphers (currently only =
GCM)=2E  The AEAD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
packet format has a smaller crypto overhead than the CBC packet format,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    (e=2Eg=2E 20 bytes pe=
r packet for AES-128-GCM instead of 36 bytes per packet</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for AES-128-CBC + HMAC-SHA1)=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ECDH key exchange</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    The TLS control channel now supports for ellipti=
c curve diffie-hellmann</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    key exchange (ECDH)=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Improved Certi=
ficate Revocation List (CRL) processing</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    CRLs are now handled by the crypto library (OpenSSL o=
r mbed TLS), instead</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   of inside OpenVPN itself=2E  The crypto library implementations are more=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strict than the O=
penVPN implementation was=2E  This might reject peer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    certificates that would previously be a=
ccepted=2E  If this occurs, OpenVPN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    will log the crypto library&#39;s error description=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Dualstack round-robin DNS client connect</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    Instead of only usin=
g the first address of each ``--remote`` OpenVPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    will now try all addresses (IPv6 and IPv4) o=
f a ``--remote`` entry=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for provi=
ding IPv6 DNS servers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    A new DHCP sub-option ``DNS6`` is added alongside with the already exis=
ting</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``DNS`` sub-o=
ption=2E  This is used to provide DNS resolvers available over</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    IPv6=2E  This may be pushed to=
 clients where `` --up`` scripts and ``--plugin``</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    can act upon it through the ``foreign_optio=
n_&lt;n&gt;`` environment variables=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
Support for the Windows client picking up this new sub-option is added,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    however IPv6 DNS reso=
lvers need to be configured via ``netsh`` which requires</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    administrator privileges unless the =
new interactive services on Windows is</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    being used=2E  If the interactive service is used, thi=
s service will execute</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ``netsh`` in the background with the proper privileges=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-New improved Windows Background service</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    The new OpenVPNService is based o=
n openvpnserv2, a complete rewrite of the OpenVPN</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    service wrapper=2E It is intended for launc=
hing OpenVPN instances that should be</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    up at all times, instead of being manually launched by =
a user=2E OpenVPNService is</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    able to restart individual OpenVPN processes if they crash, and i=
t also works</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    prope=
rly on recent Windows versions=2E OpenVPNServiceLegacy tends to work poorly=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if at all, on ne=
wer Windows versions (8+) and its use is not recommended=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-New interactive Windows service</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    The installer starts OpenVPNServiceInteracti=
ve automatically and configures</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    it to start	at system startup=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    The interactive Windows service allows unprivileged users to start<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN connection=
s in the global config directory (usually</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    C:\\Program Files\\OpenVPN\\config) using OpenVPN G=
UI without any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ext=
ra configuration=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Users who belong to=
 the built-in Administrator group or to the</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    local &quot;OpenVPN Administrator&quot; group can=
 also store configuration</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    files under %USERPROFILE%\\OpenVPN\\config for use with the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    interactive service=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-redirect-gateway ipv6</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenVPN has now feature parity between =
IPv4 and IPv6 for redirect</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    gateway including the handling of overlapping IPv6 routes with</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    IPv6 remote VPN serve=
r address=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-LZ4 Compression and pushable c=
ompression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Additio=
nally to LZO compression OpenVPN now also supports LZ4 compression=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    Compression options are=
 now pushable from the server=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Filter pul=
led options client-side: pull-filter</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    New option to explicitly allow or reject options pushed =
by the server=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    M=
ay be used multiple times and is applied in the order specified=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-Per-client remove push options: push-remove</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    New option to remove opti=
ons on a per-client basis from the &quot;push&quot; list</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    (more fine-grained than ``--push-res=
et``)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-Http proxy password inside config =
file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Http proxy pa=
sswords can be specified with the inline file option</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ``&lt;http-proxy-user-pass&gt;`` =2E=2E=
 ``&lt;/http-proxy-user-pass&gt;``</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Windows =
version detection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
Windows version is detected, logged and possibly signalled to server</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    (IV_PLAT_VER=3D&lt;nn&gt=
; if ``--push-peer-info`` is set on client)=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-Authentication tokens</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    In situations where it is not suitable to save user passwords on th=
e client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN =
has support for pushing a --auth-token since v2=2E3=2E  This option is</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    pushed from the server=
 to the client with a token value to be used instead</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    of the users password=2E  For this to w=
ork, the authentication plug-in would</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    need to implement this support as well=2E  In OpenVPN 2=
=2E4 --auth-gen-token</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    is introduced, which will allow the OpenVPN server to generate a random=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    token and push it=
 to the client without any changes to the authentication</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    modules=2E  When the clients need to=
 re-authenticate the OpenVPN server will</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    do the authentication internally, instead of sending=
 the re-authentication</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    request to the authentication module =2E  This feature is especially</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    useful in configura=
tions which use One Time Password (OTP) authentication</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    schemes, as this allows the tunnel key=
s to be renegotiated regularly without</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    any need to supply new OTP codes=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-keying-material-exporter</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    Keying Material Exporter [RFC-5705] allow additional k=
eying material to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   derived from existing TLS channel=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-And=
roid platform support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    Support for running on Android using Android&#39;s VPNService API has b=
een added=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    See d=
oc/android=2Etxt for more details=2E This support is primarily used in</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    the OpenVPN for Androi=
d app (https://github=2Ecom/schwabe/ics-openvpn)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-AIX platform support</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    AIX platform support has been added=2E The support only includes t=
ap</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    devices since A=
IX does not provide tun interface=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Contro=
l channel encryption (``--tls-crypt``)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    Use a pre-shared static key (like the ``--tls-auth`` k=
ey) to encrypt control</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    channel packets=2E  Provides more privacy, some obfuscation and poor-m=
an&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    post-quan=
tum security=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Asynchronous push reply</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    Plug-ins providing su=
pport for deferred authentication can benefit from a more</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    responsive authentication where the=
 server sends PUSH_REPLY immediately once</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    the authentication result is ready, instead of wait=
ing for the client to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    to send PUSH_REQUEST once more=2E  This requires OpenVPN to be built wi=
th</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``=2E/configure=
 --enable-async-push``=2E  This is a compile-time only switch=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-Deprecated features</span><br><span>--------------------</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-For an up-to-date list of all deprecate=
d options, see this wiki page:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-https://community=2Eopenvpn=2Enet/openvpn/wiki/DeprecatedOptions</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- ``--key-method 1`` is deprecated in OpenV=
PN 2=2E4 and will be removed in v2=2E5=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  Migrate away from ``--key-method 1`` as soon as possi=
ble=2E  The recommended</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  approach is to remove the ``--key-method`` option from the configuratio=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  files, OpenVPN wil=
l then use ``--key-method 2`` by default=2E  Note that this</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  requires changing the option in bot=
h the client and server side configs=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `=
`--tls-remote`` is removed in OpenVPN 2=2E4, as indicated in the v2=2E3</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  man-pages=2E  Similar f=
unctionality is provided via ``--verify-x509-name``,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  which does the same job in a better way=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- ``--compat-names`` and ``--no-name-re=
mapping`` were deprecated in OpenVPN 2=2E3</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  and will be removed in v2=2E5=2E  All scripts and pl=
ug-ins depending on the old</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  non-standard X=2E509 subject formatting must be updated to the stan=
dardized</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  formatting=
=2E  See the man page for more information=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-- ``--no-iv`` is deprecated in OpenVPN 2=2E4 and will be removed in v2=
=2E5=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-- ``--keysize`` is deprecated in Op=
enVPN 2=2E4 and will be removed in v2=2E6</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  together with the support of ciphers with cipher bloc=
k size less than</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  128=
-bits=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-- ``--comp-lzo`` is deprecated in =
OpenVPN 2=2E4=2E  Use ``--compress`` instead=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-- ``--ifconfig-pool-linear`` has been deprecated since OpenVPN 2=2E1 a=
nd will be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  removed i=
n v2=2E5=2E  Use ``--topology p2p`` instead=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- ``--client-cert-not-required`` is deprecated in OpenVPN 2=2E4 and wil=
l be removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in v2=
=2E5=2E  Use ``--verify-client-cert none`` for a functional equivalent=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- ``--ns-cert-type`` is deprecated in OpenV=
PN 2=2E3=2E18 and v2=2E4=2E  It will be removed</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  in v2=2E5=2E  Use the far better ``--remote-cer=
t-tls`` option which replaces this</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  feature=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-User-visible Changes</span><br><span>-=
--------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">--=
 When using ciphers with cipher blocks less than 128-bits,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN will complain loudly if the =
configuration uses ciphers considered</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  weak, such as the SWEET32 attack vector=2E  In such scena=
rios, OpenVPN will by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  default renegotiate for each 64MB of transported data (``--reneg-bytes``)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This renegotiati=
on can be disabled, but is HIGHLY DISCOURAGED=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- For certificate DNs with duplicate fields, e=2Eg=2E &quot;OU=3Done,=
OU=3Dtwo&quot;, both fields</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  are now exported to the environment, where each second and later oc=
currence</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  of a field =
get _$N appended to it&#39;s field name, starting at N=3D1=2E  For the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  example above, that woul=
d result in e=2Eg=2E X509_0_OU=3Done, X509_0_OU_1=3Dtwo=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  Note that this breaks setups that re=
ly on the fact that OpenVPN would</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  previously (incorrectly) only export the last occurrence of a=
 field=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-- ``proto udp`` and ``proto tcp``=
 now use both IPv4 and IPv6=2E The new</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  options ``proto udp4`` and ``proto tcp4`` use IPv4 only=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- ``--sndbuf`` and ``--recvbuf`` defaul=
t now to OS defaults instead of 64k</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- OpenV=
PN exits with an error if an option has extra parameters;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  previously they were silently ignored=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``--tls-auth`` always requires OpenVPN s=
tatic key files and will no</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  longer work with free form files</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- =
``--proto udp6/tcp6`` in server mode will now try to always listen to</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  both IPv4 and IPv6 on pla=
tforms that allow it=2E Use ``--bind ipv6only``</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  to explicitly listen only on IPv6=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-- Removed ``--enable-password-save`` from configure=
=2E This option is now</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  always enabled=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Stricter default TLS=
 cipher list (override with ``--tls-cipher``), that now</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  also disables:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  * Non-ephemeral key exchange using static (EC)DH keys</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  * DSS private keys</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- mbed TLS builds: changed the tls_digest_N values expo=
rted to the script</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  e=
nvironment to be equal to the ones exported by OpenSSL builds, namely</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  the certificate fingerpri=
nt (was the hash of the &#39;to be signed&#39; data)=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- mbed TLS builds: minimum RSA key size is now 2048 bits=2E  S=
horter keys will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  not=
 be accepted, both local and from the peer=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-- ``--connect-timeout`` now specifies the timeout until the first TLS pa=
cket</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is received (id=
entical to ``--server-poll-timeout``) and this timeout now</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  includes the removed socks proxy tim=
eout and http proxy timeout=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In ``--sta=
tic`` mode ``connect-timeout`` specifies the timeout for TCP and</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  proxy connection establishment=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-- ``--connect-retry-max`` now specifies th=
e maximum number of unsuccessful</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  attempts of each remote/connection entry before exiting=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- ``--http-proxy-timeout`` and the static non-=
changeable socks timeout (5s)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  have been folded into a &quot;unified&quot; ``--connect-timeout``=
 which covers all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  st=
eps needed to connect to the server, up to the start of the TLS exchange=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The default value h=
as been raised to 120s, to handle slow http/socks</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  proxies graciously=2E  The old &quot;fail TCP=
 fast&quot; behaviour can be achieved by</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  adding &quot;``--connect-timeout 10``&quot; to the cli=
ent config=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--http-proxy-retry`` and =
``--sock-proxy-retry`` have been removed=2E Proxy connections</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  will now behave like regular conn=
ection entries and generate a USR1 on failure=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- ``--connect-retry`` gets an optional second argument that specifies=
 the maximum</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  time in=
 seconds to wait between reconnection attempts when an exponential</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  backoff is triggered due to =
repeated retries=2E Default =3D 300 seconds=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-- Data channel cipher negotiation (see New features section) can overri=
de</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ciphers configure=
d in the config file=2E  Use ``--ncp-disable`` if you do not want</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  this behavior=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-- All tun devices on all platforms are always considere=
d to be IPv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  capable=
=2E The ``--tun-ipv6`` option is ignored (behaves like it is always</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  on)=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-- On the client side recursively routed packets, which have the=
 same destination</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  as=
 the VPN server, are dropped=2E This can be disabled with</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  --allow-recursive-routing option=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- On Windows, when the ``--register-dns`` o=
ption is set, OpenVPN no longer</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  restarts the ``dnscache`` service - this had unwanted side effe=
cts, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  seems to be=
 no longer necessary with currently supported Windows versions=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-- If no flags are given, and the interactive Windows=
 service is used, &quot;def1&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  is implicitly set (because &quot;delete and later reinstall =
the existing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  default=
 route&quot; does not work well here)=2E  If not using the service,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  the old behaviour is kept=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-- OpenVPN now reloads a CRL only if the=
 modication time or file size has</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  changed, instead of for each new connection=2E  This reduces =
the connection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  setup=
 time, in particular when using large CRLs=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-- OpenVPN now ships with more up-to-date systemd unit files which take a=
dvantage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  of the impr=
oved service management as well as some hardening steps=2E  The</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  configuration files are picked =
up from the /etc/openvpn/server/ and</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  /etc/openvpn/client/ directories (depending on unit file)=
=2E  This also avoids</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  these new unit files and how they work to collide with older pre-existing=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  unit files=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-- Using ``--no-iv`` (which is generally not a re=
commended setup) will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  require explicitly disabling NCP with ``--disable-ncp``=2E  This is</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  intentional because NCP w=
ill by default use AES-GCM, which requires</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  an IV - so we want users of that option to conscious=
ly reconsider=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-Maintainer-visible changes</span><br><span>----=
-----------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- OpenVPN no longer supports building with crypto support, but without TL=
S</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  support=2E  As a c=
onsequence, OPENSSL_CRYPTO_{CFLAGS,LIBS} and</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  OPENSSL_SSL_{CFLAGS,LIBS} have been merged into OP=
ENSSL_{CFLAGS,LIBS}=2E  This</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  is particularly relevant for maintainers who build their own OpenS=
SL library,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  e=2Eg=2E=
 when cross-compiling=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Linux distributi=
ons using systemd is highly encouraged to ship these new unit</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  files instead of older ones, to p=
rovide a unified behaviour across systemd</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  based Linux distributions=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- With OpenVPN 2=2E4, the project has moved over to depend on and a=
ctively use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the offi=
cial C99 standard (-std=3Dc99)=2E  This may fail on some older compiler/lib=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  header combination=
s=2E  In most of these situations it is recommended to</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  use -std=3Dgnu99 in CFLAGS=2E  This is k=
nown to be needed when doing</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  i386/i686 builds on RHEL5=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Version 2=2E4=2E5</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-New features</span><br><span>----=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- The new op=
tion ``--tls-cert-profile`` can be used to restrict the set of</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  allowed crypto algorithms in TLS=
 certificates in mbed TLS builds=2E  The</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  default profile is &#39;legacy&#39; for now, which all=
ows SHA1+, RSA-1024+ and any</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  elliptic curve certificates=2E  The default will be changed to the=
 &#39;preferred&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 profile in the future, which requires SHA2+, RSA-2048+ and any curve=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Version 2=2E4=2E3</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-New features</span><br><span>-------------</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-- Support building with OpenSSL 1=2E1 now (in addi=
tion to older versions)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- On Win10, set low=
 interface metric for TAP adapter when block-outside-dns</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  is in use, to make Windows prefer the =
TAP adapter for DNS queries</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  (avoiding large delays)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-Security</span><br><span>-------=
--</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2017-7522: Fi=
x ``--x509-track`` post-authentication remote DoS</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  A client could crash a v2=2E4+ mbedtls server=
, if that server uses the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  ``--x509-track`` option and the client has a correct, signed and unre=
voked</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  certificate th=
at contains an embedded NUL in the certificate subject=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  Discovered and reported to the OpenVP=
N security team by Guido Vranken=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2=
017-7521: Fix post-authentication remote-triggerable memory leaks</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  A client could cause a server=
 to leak a few bytes each time it connects to the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  server=2E  That can eventually cause the serv=
er to run out of memory, and thereby</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  causing the server process to terminate=2E Discovered and =
reported to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Open=
VPN security team by Guido Vranken=2E  (OpenSSL builds only=2E)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-- CVE-2017-7521: Fix a potential post-authentication r=
emote code execution</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 attack on servers that use the ``--x509-username-field`` option with an X=
=2E509</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  extension fie=
ld (option argument prefixed with ``ext:``)=2E  A client that can</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  cause a server to run out-of-=
memory (see above) might be able to cause the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  server to double free, which in turn might lead t=
o remote code execution=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  Discovered and reported to the OpenVPN security team by Guido Vranke=
n=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (OpenSSL builds=
 only=2E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-- CVE-2017-7520: Pre-authenticati=
on remote crash/information disclosure for</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  clients=2E If clients use a HTTP proxy with NTLM aut=
hentication (i=2Ee=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  ``--http-proxy &lt;server&gt; &lt;port&gt; [&lt;authfile&gt;|&#39;auto&#3=
9;|&#39;auto-nct&#39;] ntlm2``),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  a man-in-the-middle attacker between the client and the proxy =
can cause</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the client=
 to crash or disclose at most 96 bytes of stack memory=2E The</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  disclosed stack memory is likely =
to contain the proxy password=2E If the</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  proxy password is not reused, this is unlikely to compr=
omise the security</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  o=
f the OpenVPN tunnel itself=2E  Clients who do not use the ``--http-proxy``=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  option with ntlm2 a=
uthentication are not affected=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- CVE-201=
7-7508: Fix remotely-triggerable ASSERT() on malformed IPv6 packet=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  This can be used to remot=
ely shutdown an openvpn server or client, if</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  IPv6 and ``--mssfix`` are enabled and the IPv6 net=
works used inside the VPN</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  are known=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix null-pointer deref=
erence when talking to a malicious http proxy</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  that returns a malformed ``Proxy-Authenticate:`` =
headers for digest auth=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix overflow c=
heck for long ``--tls-cipher`` option</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Win=
dows: Pass correct buffer size to ``GetModuleFileNameW()``</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslabs audit, finding 5=
=2E6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-User-visible Changes</span><br><span>---------------------=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--verify-hash`` c=
an now take an optional flag which changes the hashing</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  algorithm=2E It can be either SHA1 or SH=
A256=2E  The default if not provided is</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  SHA1 to preserve backwards compatibility with existing =
configurations=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-- Restrict the supported =
``--x509-username-field`` extension fields to subjectAltName</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  and issuerAltName=2E  Other extens=
ions probably didn&#39;t work anyway, and would</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  cause OpenVPN to crash when a client connects=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-Bugfixes</span><br><span>---------</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-- Fix fingerprint calculation in mbed TLS build=
s=2E  This means that mbed TLS users</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  of OpenVPN 2=2E4=2E0, v2=2E4=2E1 and v2=2E4=2E2 that rely =
on the values of the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 ``tls_digest_*`` env vars, or that use ``--verify-hash`` will have to chan=
ge</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the fingerprint v=
alues they check against=2E  The security impact of the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  incorrect calculation is very minimal; =
the last few bytes (max 4, typically</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  4) are not verified by the fingerprint=2E  We expect no re=
al-world impact,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  bec=
ause users that used this feature before will notice that it has suddenly</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  stopped working, and =
users that didn&#39;t will notice that connection setup</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  fails if they specify correct fingerpri=
nts=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-- Fix edge case with NCP when the se=
rver sends an empty PUSH_REPLY message</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  back, and the client would not initialize it&#39;s data =
channel crypto layer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 properly (trac #903)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix SIGSEGV on unal=
igned buffer access on OpenBSD/Sparc64</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fi=
x TCP_NODELAY on OpenBSD</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Remove erroneous=
 limitation on max number of args for ``--plugin``</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-- Fix NCP behaviour on TLS reconnect (Server would not send a prope=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;cipher =2E=
=2E=2E&quot; message back to the client, leading to client and server</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  using different ciphers) =
(trac #887)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-Version 2=2E4=2E2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-Bugfixes</span><br><span>---------</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-- Fix memory leak introduced in OpenVPN 2=2E4=
=2E1: if ``--remote-cert-tls`` is</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  used, we leaked some memory on each TLS (re)negotiation=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-Security</span><br><span>---------</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-- Fix a pre-authentication denial-of-service attack=
 on both clients and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 servers=2E  By sending a too-large control packet, OpenVPN 2=2E4=2E0 or v2=
=2E4=2E1 can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  be forc=
ed to hit an ASSERT() and stop the process=2E  If ``--tls-auth`` or</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt`` is used, on=
ly attackers that have the ``--tls-auth`` or</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  ``--tls-crypt`` key can mount an attack=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslab audit find=
ing 5=2E1, CVE-2017-7478)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Fix an authenti=
cated remote DoS vulnerability that could be triggered by</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  causing a packet id roll over=2E  An =
attack is rather inefficient; a peer</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  would need to get us to send at least about 196 GB of data=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (OSTIF/Quarkslab=
 audit finding 5=2E2, CVE-2017-7479)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Version 2=2E4=2E1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--remote=
-cert-ku`` now only requires the certificate to have at least the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  bits set of one of the values=
 in the supplied list, instead of requiring an</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  exact match to one of the values in the list=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- ``--remote-cert-tls`=
` now only requires that a keyUsage is present in the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  certificate, and leaves the verification =
of the value up to the crypto</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  library, which has more information (i=2Ee=2E the key exchange me=
thod in use)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  to veri=
fy that the keyUsage is correct=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-- ``--ns-cert-type`` is deprecated=2E  Use ``--remote-cert-tls=
`` instead=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The ns=
CertType x509 extension is very old, and barely used=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ``--remote-cert-tls`` uses the far more=
 common keyUsage and extendedKeyUsage</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  extension instead=2E  Make sure your certificates carry t=
hese to be able to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  u=
se ``--remote-cert-tls``=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br=
><span>index 2df7eea=2E=2Ef96b945 100644</span><br><span>--- a/Makefile=2Ea=
m</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -59,7 +59,7 @@</sp=
an><br><span> dist_doc_DATA =3D \</span><br><span> 	README \</span><br><spa=
n> 	README=2Embedtls \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	Changes=2Erst \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	C=
hanges=2Emd \</span><br><span> 	COPYRIGHT=2EGPL \</span><br><span> 	COPYING=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">change 17=
67</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I8887fa7ccf407d727c2b59397000149e45487e13 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1767 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--R7Q4Skx7Hfc=--


--===============6263506297954399338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6263506297954399338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6263506297954399338==--

