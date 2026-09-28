Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFC8C9832F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9wdwZCi3Sh5Nw+aW1rFu08Bt/BrSn2DhquQ3tkSsZU=; b=EhjBgZvz2diR4e3gbVy/wp9D65
	8THOvar/t7w3TuEvW+EYtwPL+vsXGmkAOGFslDPzzK9xnJ7ciutC3DOg40xMIQWtKy9iQYgjzkvmU
	7oSxJS2kSOaM5cvNK7IdNscC0ogxMdp2pl2JifAYjKbrALynqW0IV8cWcaSucb1xy/cA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB5vc-0000tH-C7;
	Mon, 28 Sep 2026 07:37:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB5va-0000tB-Rx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GwaOxW2Wy+hBUgJxxU3yyNZGGD559Kiu6BRIRC6gq1k=; b=TUhWt0v44BH4ocgHT74Iod8nzV
 HLRFMPExAgVGW5PK0FJMfV9uF3Zw5gBfcZHkNQoCme3dAcw+TUn+hm9D/TJCHCwMmeUZR4vZrWGCo
 +TBs1g3Osny7ICXR/SB0bJdrbqNTx5RhfqBF091kSX15tw7PYbZUs1WGhynrNIegZrz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GwaOxW2Wy+hBUgJxxU3yyNZGGD559Kiu6BRIRC6gq1k=; b=i
 BA3vpkvjXxI1pNYIQS7Fd7Ev8qC+d0pLFoJpuV8iY/LywYORNixS00lQkZlyAGU27NNpyA8ENWOmo
 hj9cHc5FxkJis4itu8fIlscHnwkd41aOFI+XPTn6WD7Rw/sWm/JwfXAv76WwtyYrxMuv6xtkUp+P5
 lkERxPv6cvumlQU0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB5vZ-000226-RN for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:37:34 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso19507315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790581047; x=1791185847; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GwaOxW2Wy+hBUgJxxU3yyNZGGD559Kiu6BRIRC6gq1k=;
 b=BEDWCALupTa+Bb8G2YKvOsZgGj5MR07Dl/rKUAFDc1auz6vzrDptmblOyEU/vQb+f/
 nc5Y21jQvkVMZ32nF5Qo5fl7EYqQV0DfnF5j3E5yHsgEI97cNjKxpj3VK08BFBGfpYqo
 xTa7j4JLlxmnfdWXpaQTTr3lTXno/LWjJF1B7hsNIPNp7GjApkZWy4mFggqevjEouadw
 5LnQkqpvuTBv5RqWyO2Q44bO1YD3LC4caWoMFo6G8e2BvNhqdd6mYi2FWJ9wKsGtZcwB
 HUw8icOQQEOk/yz0B9eqMkFY0JsKDmaqecf07TB8E5Gq0LILquOVS5kzpINmG4G4p/dZ
 NOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790581047; x=1791185847;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GwaOxW2Wy+hBUgJxxU3yyNZGGD559Kiu6BRIRC6gq1k=;
 b=DLkwzXBpyyPnPZn7h4CkJM9IRYKCFZdgMmgR/dnCEmUKw9mESC9VRI2g6JCU+8nbw7
 h7Y05eQwfr6n3x1T6Ok+6SPBVfWG3hURadTRKImtMWs0SZEPhWn/f+IuzE9jXWzW2Msr
 jTQ3zm8lowTDxn6GjS4ptd6m45nsthz/fMu7Qy/FARuxpsyldNkLRiDwM8UaLhBtl/xv
 XiDCdL9cgwuEEQyZ+RL/BTd2JFpsroClwWJuAMXX8wF/WaDNbCTvp6Tt+LxVoPvB6TMx
 Z13fRjsu52zVP34HMo8itn87x+T6iJ91QXuG4jVaoqf/ghSIU3Fti0l3o4lGz4A6INc5
 0kVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/wlwv2lrd5mhnwtMk/VpQdlDAbIFj3/4gXSquo2nM0cLoEqvLZsAQWcOVh7PTaRt6dKzNmqaxH06GCzwb@lists.sourceforge.net
X-Gm-Message-State: AFuF++kLmId4Z3Vz4vvGcJBMFqcXLwmL0efbfQtJ4Q48WZvo04HsTQJb
 dio8LjEE6Qlq5FECpz2A1omzidcZKx9V8vvUkqZ9K3o45RDb4sOXOrNnWD+WXWm6HehtT3ytlOz
 ryC3gQLk7+BvdxYvGKiOXjQm9NN5NBdfmoTplm/04KBg/MzqTseTYhBaP62JJpZY+HMT6zyHnb2
 Js1ca/mQ==
X-Gm-Gg: AYBFou1JkouYYtQ/6ZBas2w2zXnIcCPlKUkz0T2um87BgxfHkKrhLTyCIHqCmNy0aDu
 bfM3EvpDkvW5cc4O/3SdYh+89woLjRYZ2cothAma4CoOd5Jxz3zdQTeZrpDtYhkp+EfACPmx92n
 weMHB/VtoC/PO3Di977GDQnPeZrA7uxiBTfnHAaOFqjZwtIaiXsSnZe9NVeQJnYBuD3PgxdJIza
 x5zYMpx/xz/cwWXiXFc+Eknf/09sKh5UEJcmcfyEq+xw9MpaZ3av6oC3iVSpjFgRRbs4/457L2U
 EIGx07g+/pJB0oEsq0ISuFRgAmnw4kn5X1++Gj+S8NE/MfrAtdEFMchLYMYMhZdUwwTthjZxArp
 FLssztiQFXT7a6jg98hWlb/FcwiLgD2ZAjjYhZ1tstdKczvQkBJlvAYClQvtV5H+sYDs7ghrpQX
 zawNVEThmWXRBf20DhO0Gsi+UFpYUvp3Jw0qghPQUwjGVRHZRuAWLVVXR3Qj0KqvBsnVI90dkcR
 Erziq6xFS0deGJQ1eneM4zAAIZHqofMWhBauTENLDFtDHULHw5ElKGXmoK6kyWP7AyzTryAkdH5
 saeAn2rMo4MU8UTc7N3uV1G82YiBiuL+mtQJSwrH8GHCcTud0kdP9Wo12i+6
X-Received: by 2002:a05:600c:6291:b0:49f:ffed:2cb with SMTP id
 5b1f17b1804b1-49fffed033bmr64475365e9.6.1790581047005; 
 Mon, 28 Sep 2026 00:37:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ffabc3f33sm156891025e9.4.2026.09.28.00.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 00:37:26 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 07:37:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 5b7dd8356d402cce1f8a8b5005c43596a7ee4d12
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 07:37:25 +0000
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9884a3993da26528d67b1ba1c39dd632e6d1d0c2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB5vZ-000226-RN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3666492299696405091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3666492299696405091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nqE42QwdveY="; charset=UTF-8

--nqE42QwdveY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

chugly ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1949?usp=3Demail )

Change subject: tests: add an end-to-end=
 test for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(5 comments)

Thanks, all five are ad=
dressed in PS2=2E

On the *BSD question, I split the script=2E t_route_comm=
on=2Esh holds the parts that do not care how the environment is isolated: s=
tarting the openvpn pair, waiting for the route, and comparing the gateway=
=2E t_route=2Esh supplies three hooks, one to run a command inside the name=
space and two to query the routing table=2E The assertion needed the real c=
hange=2E It used to match "via $GW" against ip route output, and it now com=
pares against a gateway the platform hook extracts, since netstat -rn spell=
s the entry differently=2E

So a BSD front end would define the three hooks=
 and reuse the rest=2E I have not written one and have no way to test one, =
so I would rather not guess at it in this change=2E

One heads up: 1946 add=
s a case to test_networking=2Ec and bumps LAST_TEST in t_net=2Esh, which is=
 the same area 1586 touches=2E Whichever lands first will leave the other n=
eeding a rebase=2E

File tests/t_route=2Esh:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1949/comment/9ab45991_002f433c?usp=3Demail :
PS2, Line 1: #!/b=
in/sh
Nothing needed bash=2E checkbashisms and dash -n are both clean now=
=2E The reason it failed rather than skipped on BSD was the shebang itself:=
 /usr/bin/env bash exits before the uname check at the top of the script ca=
n run, so with /bin/sh the runtime skip works and no Makefile gating is nee=
ded=2E I also replaced seq with a plain counter loop, since seq is not in P=
OSIX either=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/81f=
3d34c_a339030b?usp=3Demail :
PS2, Line 29: TUN=3D"ovpnt$$"
Applied, using t=
he arguments from dev-tools/reformat-shell=2Esh=2E Note that tests/t_client=
=2Esh is also listed by shfmt on current master=2E I left that alone as unr=
elated to this change=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/c=
omment/983cb7ea_f046a1f4?usp=3Demail :
PS2, Line 67: # A namespace needs th=
e same privileges the rest of the test does, so use
Removed=2E


http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/2691b0cb_d3bc84e8?usp=3Demail =
:
PS2, Line 79: cleanup()
Removed, along with the two on lines 80 and 81 th=
at were the same pattern=2E I kept one redirection, on the route query in t=
he polling loop, with a comment saying why: absence of the route is the nor=
mal state while polling, so the unreachable error iproute2 prints there is =
noise rather than a diagnostic=2E Happy to drop that one too if you would r=
ather have it consistent=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
9/comment/4c3a713b_6cb3f26c?usp=3Demail :
PS2, Line 83:     wait
Removed=2E=




-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2e8f1449fe54e7f=
628e2bdb042ee2a567f25e02d
Gerrit-Change-Number: 1949
Gerrit-PatchSet: 2
Ger=
rit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 28 Sep=
 2026 07:37:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--nqE42QwdveY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>chugly has posted =
comments on this change by chugly=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Thanks, all five are addressed in =
PS2=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">On the *BSD question, I split the script=2E t_route_common=2Esh =
holds the parts that do not care how the environment is isolated: starting =
the openvpn pair, waiting for the route, and comparing the gateway=2E t_rou=
te=2Esh supplies three hooks, one to run a command inside the namespace and=
 two to query the routing table=2E The assertion needed the real change=2E =
It used to match &quot;via $GW&quot; against ip route output, and it now co=
mpares against a gateway the platform hook extracts, since netstat -rn spel=
ls the entry differently=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">So a BSD front end would define the three h=
ooks and reuse the rest=2E I have not written one and have no way to test o=
ne, so I would rather not guess at it in this change=2E</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">One heads up: 1=
946 adds a case to test_networking=2Ec and bumps LAST_TEST in t_net=2Esh, w=
hich is the same area 1586 touches=2E Whichever lands first will leave the =
other needing a rebase=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1949?usp=3Demail">View Change</a></p><p>5 comments:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
File tests/t_route=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/9ab45991=
_002f433c?usp=3Demail">Patch Set #2, Line 1:</a> <code style=3D"font-family=
:monospace,monospace">#!/bin/sh</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Nothing needed bash=2E checkbash=
isms and dash -n are both clean now=2E The reason it failed rather than ski=
pped on BSD was the shebang itself: /usr/bin/env bash exits before the unam=
e check at the top of the script can run, so with /bin/sh the runtime skip =
works and no Makefile gating is needed=2E I also replaced seq with a plain =
counter loop, since seq is not in POSIX either=2E</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/81f3d34c_a339030b?usp=
=3Demail">Patch Set #2, Line 29:</a> <code style=3D"font-family:monospace,m=
onospace">TUN=3D&quot;ovpnt$$&quot;</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Applied, using the arguments=
 from dev-tools/reformat-shell=2Esh=2E Note that tests/t_client=2Esh is als=
o listed by shfmt on current master=2E I left that alone as unrelated to th=
is change=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1949/comment/983cb7ea_f046a1f4?usp=3Demail">Patch Set #2, Line 67:</a> <=
code style=3D"font-family:monospace,monospace"># A namespace needs the same=
 privileges the rest of the test does, so use</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Removed=2E</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/2691=
b0cb_d3bc84e8?usp=3Demail">Patch Set #2, Line 79:</a> <code style=3D"font-f=
amily:monospace,monospace">cleanup()</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Removed, along with the two=
 on lines 80 and 81 that were the same pattern=2E I kept one redirection, o=
n the route query in the polling loop, with a comment saying why: absence o=
f the route is the normal state while polling, so the unreachable error ipr=
oute2 prints there is noise rather than a diagnostic=2E Happy to drop that =
one too if you would rather have it consistent=2E</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949/comment/4c3a713b_6cb3f26c?usp=
=3Demail">Patch Set #2, Line 83:</a> <code style=3D"font-family:monospace,m=
onospace">    wait</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Removed=2E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demai=
l">change 1949</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
49?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1949 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly=
 &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 28 Sep 2026 07:37:25 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>

</body></html>
--nqE42QwdveY=--


--===============3666492299696405091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3666492299696405091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3666492299696405091==--

