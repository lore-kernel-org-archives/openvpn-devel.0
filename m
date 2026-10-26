Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D975606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eZvDbRCJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BUh811jB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DACYWIIf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V0q56Paz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PD5Ye1Q7hZ80PMtIxJhvtuD/6ZJX3vAHeH1QqDCKa/4=; b=eZvDbRCJcf2PP22gR6+udKy2qM
	23UoNQyqDFGbLqpWtAW9FIkenmuHvumgB0y0iXlIvxENdxWSdCHr+0hBgDni+cyK24E79hcJQt9JG
	78Q2GwtuiP6G6ygG658hrtg/PL6QMxRZYTwp1f7QhS91+G2IA4Za655a4KTiyFDgetQg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLMSl-000000000KT-3mXv;
	Mon, 26 Oct 2026 15:18:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLMSk-000000000KN-2vIF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VnsCcfU3+CgVw1JLbUuQ0VHOXYCKXVaJkMzr/Fz3p/g=; b=BUh811jBjzrMLg3KllNL0f6qhH
 kB0DMTwTyRGqyv3tHLWrLm+l41a85pEiP5m/kB+GRSWJR0aMsEB44nKZ3oxAKE7nvyGsgLKBmNb7e
 XQPh+l6peehpAVe4AslwndvM5ArpiJRVwIaK7Ap/UsZX8gIaSvhLl2nCrQAOc+dH1dbo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VnsCcfU3+CgVw1JLbUuQ0VHOXYCKXVaJkMzr/Fz3p/g=; b=DACYWIIf3KJ7G/6H6Pa89+fjNf
 ONuWoMawxFH1szGjo3TPRIUH02V98mxZmwHwQxmNStcxMTpDmtVSx6YLtXS9jDvZkpAZI9gN8MSis
 xLitYQFc6pZUq9Lu03BPPz246D6sl3EaYWlLsg/TesU88eyaoNmgvxxv4XdBckUB1ysk=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLMSj-000000004rn-2cQO for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso31719755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793027887; x=1793632687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VnsCcfU3+CgVw1JLbUuQ0VHOXYCKXVaJkMzr/Fz3p/g=;
 b=V0q56PazmHYErqrEvfDNsVtFeyUnQdEgVMhhsM/uMOMyG0uai96DTw4jdNB0c+idIN
 WhhhbYXmdVNTAG1ORAd7qW9Sv7phs+lCG8WAh/QE+yahbcocellC3cYftKAXkGQ2i8sW
 VnwiRJr7XNjLfLbkjMnbfyN9tEkchO6upqyO1LJsFM3DnhTQzY2LM++ICS/ZjXs0DkUc
 nqyBlTCGz9lHs+OsTsHTW2YbkC6pm8BTn5jGUuOb1B/DjyOl2Rnvddsyexx29EjWcQG4
 ZKyScNtk5gpUcNEfGnxYGKj3waCMHsV7obPVC74tnOB9YD7JaonmEjqigqa7Ns9vIFD/
 9VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027887; x=1793632687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VnsCcfU3+CgVw1JLbUuQ0VHOXYCKXVaJkMzr/Fz3p/g=;
 b=Gew3sdiznmFdwel9tNiZzqV1xsn2TonWgS6lMuAGbcjDQFDiOtzOTmDT3LeT5HGp4k
 ub6kdse+UbKMraxKjKdy4jZy+2+XBdGXNrL0M5qgmrbC5NsPgtRTrbEXNp4+ZECCD6z7
 W9dCpjVKoa6IoAcTBaKLCzOWg30l+rvXBDVZHNc91QOu9mDoa5T9Kri+Kclh6G5MT+qC
 2VwkUxYW1/tQm9+A7AY0E3j7h21aR1waeCDJRTq7zQxLA1HcdIpXeZncJ4iWi/Yb17zI
 2UuCRN8kk8A5vKHFFi+ZxqDRX4mJcDqvX1AnzhyfcP+ZMeBUas0x0NopNtn0iYDeNf1S
 H4xw==
X-Gm-Message-State: AFq9FYL/Hb0Ec/JIIj0X2hk361Yn7ZUJ9kbUUJOcPWoSmJovu/flNgvc
 r9z2Hl+0GUI/u9pEif2OPHHJJQyyy+6YrENIogPUBUp2rPXGo5DeFiATw8u+yDkRkg7TDvcTnGJ
 mT2x9msP70PhCdR8H7X+/z0jyEyl6hnXry4qw7eMqD6y6A36nN7XAYFpRbHofUikRSPbc7EnR3U
 4zk2rX4A==
X-Gm-Gg: AYBFou0au6JgjYfknUiGtEGRPx8dx+QdeD2RJFEl84yJtNhE5LYYl+/wPj7JTTz2Fad
 mbDkvl7VyEvWq9wfdoI6r0ppHh63cMM6w+3dRtqa+7SNyts8U/zz4fb4k50K6EAEoq23VChO6sg
 /9s3ZaaWFvzYboicPJi9c3crP6SJSlx5M2duywk3pbxRbbsrsz68yaCJgeeU9P9MfDYzrZsa18E
 CJ4WyGtFOjtwTylHZFG1g8WVDgDwsHggc75y3CbdhCU2ZFmPKJXsJsWW4+p5k24kb5jPtRiNrjZ
 ue8kTr3hFfohEhPv/QKaMDFhnhUTvNXKcmHOcbblm9QQapgjEXE0zxlSgA+LLp0oN6N6+Ro3Nqc
 UO1At3xnfJTheA7UKN5tgZAA8NVWPs8tbbuSCKzQiX8doNYxI6hhXQoRSiywrpCXJbCprwu6X19
 a/LLPhhQRC1a8IL9cU3s1NXdlPTYTht2MDARPM38K/F44oF2Wdje9HrZ0+Fr02J9J1m4VqUnZZs
 BjlA+PcoFBGc+hTd3MmGJgWtZ5gPS+KUWcmqnXAWnbSbFbIrxFzpl7RiUWqFTDy5pD7La1L0DmY
 4ALiFSVQBTxqY43xo0pjxUH1vOAg2nbQUXEANs1YkJLbsmidjjWreGrBQ5eXvRZqtOyr3AZrDO8
 E0qk5hRUPuKEdTU5UYkk6gLHbn7ia04ByMpG8swZqvQ==
X-Received: by 2002:a05:600c:4f84:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4a575d2c6c7mr81237855e9.22.1793027886842; 
 Mon, 26 Oct 2026 08:18:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbb725sm200461925e9.0.2026.10.26.08.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:18:06 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 15:17:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: af84873660297153f11dc113180262fe55200170
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3e11fdbef99f805bf234c201cca91f1aef019d2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLMSj-000000004rn-2cQO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0617460959070989497=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0617460959070989497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+hcd/TJe9ps="; charset=UTF-8

--+hcd/TJe9ps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Hello =
Arne Schwabe, Gert Doering, 

I'd like you to reexamine a change=2E Please =
visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail

to =
look at the new patch set (#11)=2E


Change subject: push: push route-gatew=
ay(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

push: push route-gateway(s) for subnet-pool clients

A sub=
net-pool client sits outside the --server / --server-ipv6 network,
so the g=
lobal route-gateway (the server's own VPN IP) is off-link for
it=2E Replace=
 it with a route-gateway, and for IPv6 a route-ipv6-gateway,
inside the cli=
ent's own subnet, so the client's pushed routes install
on-link=2E

A host =
route to the server's own VPN IP is deliberately not pushed: it
is not need=
ed to reach the networks behind the server=2E An admin whose
clients must r=
each the server's VPN address itself can add an explicit
push "route =2E=2E=
=2E" to the server config=2E

Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578f=
f5dce48
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M sr=
c/openvpn/push=2Ec
2 files changed, 33 insertions(+), 0 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/1787/11

=
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/serve=
r-options=2Erst
index 138fcc9=2E=2Ed14c341 100644
--- a/doc/man-sections/se=
rver-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -366,6 +3=
66,16 @@
   and FreeBSD the IPv4 route is installed on-link, without a gate=
way, so its
   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=
=2E
 
+  A client assigned to a pool is pushed a ``--route-gateway`` (and, =
with
+  ``--subnet-pool-ipv6``, a ``--route-ipv6-gateway``) inside its own =
subnet
+  in place of the global one, so that its pushed routes install on-=
link=2E
+
+  A host route to the server's own VPN IP is not pushed, as it i=
s not needed
+  to reach the networks behind the server=2E If your clients =
need to reach the
+  server's VPN address itself, add an explicit
+  ``push=
 "route <server-VPN-IP> 255=2E255=2E255=2E255"`` (or the ``route-ipv6``
+  =
equivalent) to the server config=2E
+
 --subnet-pool-ipv6 args
   The IPv6 =
counterpart of ``--subnet-pool``=2E Repeatable main-config directive=2E
 
d=
iff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 42259c3=2E=2E=
c550bb9 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -64=
6,6 +646,16 @@
                         print_in6_addr(c->c2=2Epush_ifconfi=
g_ipv6_local, 0, gc),
                         c->c2=2Epush_ifconfig_ipv6_n=
etbits,
                         print_in6_addr(c->c2=2Epush_ifconfig_ipv6_=
remote, 0, gc));
+
+        /* subnet-pool-ipv6 counterpart of the IPv4 pus=
h below: replace the
+         * global route-ipv6-gateway (the server's VP=
N IP, off-link for this
+         * client) with one inside the client's ow=
n subnet=2E */
+        if (o->subnet_pool_ipv6_defined)
+        {
+      =
      push_remove_option(o, "route-ipv6-gateway");
+            push_option=
_fmt(gc, push_list, M_USAGE, "route-ipv6-gateway %s",
+                    =
        print_in6_addr(o->subnet_pool_ipv6_gateway, 0, gc));
+        }
   =
  }
 
     /* ipv4 */
@@ -660,6 +670,19 @@
         push_option_fmt(gc, pus=
h_list, M_USAGE, "ifconfig %s %s",
                         print_in_addr_t=
(ifconfig_local, 0, gc),
                         print_in_addr_t(c->c2=2Ep=
ush_ifconfig_remote_netmask, 0, gc));
+
+        /* A subnet-pool client si=
ts outside the --server network, so the
+         * global route-gateway (t=
he server's own VPN IP) is off-link for it:
+         * replace it with one=
 inside the client's own subnet so that its
+         * pushed routes insta=
ll on-link=2E  A host route to the server's VPN IP
+         * is deliberat=
ely not pushed (not needed to reach the networks behind
+         * the ser=
ver); an admin who needs it adds an explicit push "route"=2E */
+        if=
 (o->subnet_pool_defined)
+        {
+            push_remove_option(o, "ro=
ute-gateway");
+            push_option_fmt(gc, push_list, M_USAGE, "route-=
gateway %s",
+                            print_in_addr_t(o->subnet_pool_ga=
teway, 0, gc));
+        }
     }
 
     if (tls_multi->use_peer_id && !tls=
_multi->use_asymmetric_peer_id)

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1787?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Nu=
mber: 1787
Gerrit-PatchSet: 11
Gerrit-Owner: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=
=2Emuc=2Ede>

--+hcd/TJe9ps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Antonio Quartul=
li <strong>uploaded patch set #11</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Chang=
e</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">push: push route-gateway(s) for subnet-pool clients<=
br><br>A subnet-pool client sits outside the --server / --server-ipv6 netwo=
rk,<br>so the global route-gateway (the server&#39;s own VPN IP) is off-lin=
k for<br>it=2E Replace it with a route-gateway, and for IPv6 a route-ipv6-g=
ateway,<br>inside the client&#39;s own subnet, so the client&#39;s pushed r=
outes install<br>on-link=2E<br><br>A host route to the server&#39;s own VPN=
 IP is deliberately not pushed: it<br>is not needed to reach the networks b=
ehind the server=2E An admin whose<br>clients must reach the server&#39;s V=
PN address itself can add an explicit<br>push &quot;route =2E=2E=2E&quot; t=
o the server config=2E<br><br>Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578f=
f5dce48<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/server-=
options=2Erst<br>M src/openvpn/push=2Ec<br>2 files changed, 33 insertions(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/87/1787/11</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/server-options=2Erst b/doc/man-sections/server-options=2Erst</span=
><br><span>index 138fcc9=2E=2Ed14c341 100644</span><br><span>--- a/doc/man-=
sections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server=
-options=2Erst</span><br><span>@@ -366,6 +366,16 @@</span><br><span>   and =
FreeBSD the IPv4 route is installed on-link, without a gateway, so its</spa=
n><br><span>   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=
=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  A client assigned to a pool is pushed a ``--route-gateway`` (and, with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--subnet-pool-ip=
v6``, a ``--route-ipv6-gateway``) inside its own subnet</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  in place of the global one, so that i=
ts pushed routes install on-link=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A=
 host route to the server&#39;s own VPN IP is not pushed, as it is not need=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to reach the ne=
tworks behind the server=2E If your clients need to reach the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  server&#39;s VPN address itself=
, add an explicit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``push &quot;route &lt;server-VPN-IP&gt; 255=2E255=2E255=2E255&quot;`` (or =
the ``route-ipv6``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 equivalent) to the server config=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --subnet-pool-ipv6 args</span><br><span>=
   The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config dire=
ctive=2E</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2E=
c b/src/openvpn/push=2Ec</span><br><span>index 42259c3=2E=2Ec550bb9 100644<=
/span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvp=
n/push=2Ec</span><br><span>@@ -646,6 +646,16 @@</span><br><span>           =
              print_in6_addr(c-&gt;c2=2Epush_ifconfig_ipv6_local, 0, gc),</=
span><br><span>                         c-&gt;c2=2Epush_ifconfig_ipv6_netbi=
ts,</span><br><span>                         print_in6_addr(c-&gt;c2=2Epush=
_ifconfig_ipv6_remote, 0, gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* subnet-pool-ipv6 counterpart of the IPv4 push below: replace the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * global route-ip=
v6-gateway (the server&#39;s VPN IP, off-link for this</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * client) with one inside the c=
lient&#39;s own subnet=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (o-&gt;subnet_pool_ipv6_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            push_remove_option(o, &quot;route-ipv6-=
gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        push_option_fmt(gc, push_list, M_USAGE, &quot;route-ipv6-gateway %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                print_in6_addr(o-&gt;subnet_pool_ipv6_gateway, 0, gc));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span> </span><br><span>     /* ipv4 */</span><br><span=
>@@ -660,6 +670,19 @@</span><br><span>         push_option_fmt(gc, push_lis=
t, M_USAGE, &quot;ifconfig %s %s&quot;,</span><br><span>                   =
      print_in_addr_t(ifconfig_local, 0, gc),</span><br><span>             =
            print_in_addr_t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* A subnet-pool client sits=
 outside the --server network, so the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * global route-gateway (the server&#39;s own VPN=
 IP) is off-link for it:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * replace it with one inside the client&#39;s own subnet so t=
hat its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * p=
ushed routes install on-link=2E  A host route to the server&#39;s VPN IP</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * is delibera=
tely not pushed (not needed to reach the networks behind</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * the server); an admin who n=
eeds it adds an explicit push &quot;route&quot;=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            push_remove_option(o=
, &quot;route-gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            push_option_fmt(gc, push_list, M_USAGE, &quot;route-g=
ateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                         print_in_addr_t(o-&gt;subnet_pool_gateway, 0, gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span>     }</span><br><span> </span><br><span>     if (tls_multi-&gt;use=
_peer_id &amp;&amp; !tls_multi-&gt;use_asymmetric_peer_id)</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/178=
7?usp=3Demail">change 1787</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1787?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1787 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--+hcd/TJe9ps=--


--===============0617460959070989497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0617460959070989497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0617460959070989497==--

