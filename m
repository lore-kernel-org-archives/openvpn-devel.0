Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6833FC61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Date:
	Message-Id:Mime-Version:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9PliHFKa/Ru7w+aLBUxhF0iU2L/nhQ+xBEH8snxAy5Y=; b=OKlqhjiQ6bzVWdVGatt/FV/kIt
	4rqZiwLZKL2fOl96Elt30AGTSEmgIdAtK+mnqHKb8z1uXmG386PCdv1id4kmAp94n35tMAUb/OLiZ
	rl5iUaZhjamc+PeDwHchiNoWlDy+gV4kfEICD+lAXts2adqftcvQbg8AOCTgLQn963Ms=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2CWK-0000YT-TH;
	Thu, 03 Sep 2026 18:50:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yuriy.darnobyt@openvpn.com>) id 1x2CW6-0000YD-Dv
 for Openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 18:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=duPgS2RJfj1DMLqOcnT2Cm1lUA62+vl5tl6R1dVmlHc=; b=L/C3zu+CohK1zybSGRpLtqi5jt
 7lMKYV0jlXj0B4F+PbNA00JoC4OP/7x8ACI+Khp+nTkyuAuSZT+JuNo8JCZn92GkUmTRbTkV2T7RX
 KL/W7AuNSfGSIBf7Y7DBfI9Q0YI8LFP5yeqjw7HYbMXS5ncd7Cq8YHZlMmQbmnipuetA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:Subject:Mime-Version:Content-Type:From:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=duPgS2RJfj1DMLqOcnT2Cm1lUA62+vl5tl6R1dVmlHc=; b=B
 6LY7QacGwkbOOdDv5FxolgCMXFPPw+J2BETxwfC5i72RjLN4D+LXS6nNpHbSnQjn/mqSRa4poFxEQ
 tzpiQbRsHTyJZxXAxCZCUcKTi6RN1jkQ2DvTVt/v4/8K5jTiuLhNyj6U5xpc4oQNVmDpeFyXvVRHd
 L7PWMWVOWbVNNR34=;
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2CW2-0002fZ-VS for Openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 18:50:27 +0000
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b5e41fe5a4so65223e87.1
 for <Openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1788461420; x=1789066220; darn=lists.sourceforge.net;
 h=to:date:message-id:subject:mime-version:content-type:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=duPgS2RJfj1DMLqOcnT2Cm1lUA62+vl5tl6R1dVmlHc=;
 b=RyYlv1E4k1UUOEZJmpWwpEJLrIrKoeEgtV6n5yApl09J5J+LbWY8iTJHotzn5eUGru
 ieyORw49p46otLxykE+ubYRf2dYIrr+6m7Ug9j2Y6IvGvWA1GcWIW2Ew7543u395qknm
 27WoNKojxaCwRLW9XpL37sfwBJj6PvnW0cg4MyMjvVJ/1ehkfZe5zQ5eCqWHB8apYAiw
 k2H0OtZ5QD0snMacsZBXSgYNgZ+uKBb1iCdRUB59sRGIldB5MeyIke/j19mCG8qG5Lr2
 /ZK8HZMF+Am/wy/JylA5lHzUrS3mXauH/+T6xKZvSo8AobYhzBrzvfloiQYA9y7S1Vej
 l1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461420; x=1789066220;
 h=to:date:message-id:subject:mime-version:content-type:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duPgS2RJfj1DMLqOcnT2Cm1lUA62+vl5tl6R1dVmlHc=;
 b=DbBOLBEt3h+uklXB3UkIYGQghFkMsG9kqIg7XyFK2ffFutz2JuZSIza9wYJ/t0vXA+
 hr4pzo8DNxRba2an6ZtVoU0KkOiX1Jmgx3r/WPetazo+AUbKnH0eKd/bQ0MrN+oAFIG5
 oTdYXxwN+ACVTF20ztdt9FP7FDFsXO9y0vv+/JI7uIfatKNWeVAd6JHgC07+QgRlM6D/
 lMnX+UJXfSHCGtrBXR2vakXzp4LmW4eCrLZeKMHBfLaFcuEk1ENzt8RQ0FPH9zAzJVOE
 BqbiHnamtk82Hj8+5iAewfOjSp4nNjxMT3S1dNdCYMzC4QFthS6WVbVkBLuHSlMQuhBF
 0LDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy+/BMrkLlCh6Z/5xguohpeJF1YcskPNuU7dEmE/UopbjgMTo0G39RCTt0mOvQ3HtvKsoZfCub/Iq+HrsZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++m9drrI8cEN6Of8/Y2+FTHTwiqkC0WRnN7Dh0z9TB1aXbQirEge
 JfUYWH+1zOOU3bCRbVxsIXnZ2kCgF02UrhAMKqmiuR900b7fFcrLagEz9ZivZl518YXuglVrVj/
 RuhH6lLKjPbCtSG0iNm8c+jGohWJhK4ZFj23/57RFKSbTf/3899p73MUioHN8D5BPnHQ8TVZ9Fv
 gqc5Gw3cfN
X-Gm-Gg: AYBFou2KVTQEJo2qvk52N9AcP1P9h81/C5s0VjtXruXjAw5wQx0Dq50Rg6+9S2yUW8f
 zHJpNmYLmZC4uQ17ARHNp9FG04jf89EJ4LHNw0hQwir+N5ZinJ/StTPz/pw/MgDiSBAeDXo5Mhj
 AA+CqrKaZhEV1Qr4Y9azk4AKA69mojfnzK+hW3I0QHfiqSvjC9mBomEgeL4uFYDqNysLSkre0te
 BULpNhJVgC09xN5xqhNYSc/3btHOoHMYCKq/PBXPNpfyGY/2U5wiFMn6JFWjNbXUcK+ufNIBOzt
 ZQee3rUPgq0nP5pjdoxs5i5mjW+JN4hb0f1ahnjIL3r7nEYrS4LN9+8/jxdmgyJsmGs09+l/2JM
 f+aG3Q/l7rDKB8Ks35w73AOwMGTfGm/7Nps+p/ugBdFxzfDnRU/pOw7hUe1+FLVn7MUnKG6gX8d
 tCfuWmtEiDODh52zcNX1BxrhlsnKWrvUDBfe+5IvP3g+W5jPkXm6XlWPXuZ5LAqbq3Lx6pZhHcQ
 uFwWZ3d3/5qQSfY9znX1DTjWHA=
X-Received: by 2002:a05:600c:6748:b0:499:db6d:bc97 with SMTP id
 5b1f17b1804b1-49cf5b64358mr44873515e9.0.1788459987942; 
 Thu, 03 Sep 2026 11:26:27 -0700 (PDT)
Received: from smtpclient.apple ([45.89.91.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm405955f8f.8.2026.09.03.11.26.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 11:26:27 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Message-Id: <B827E164-CDC8-4B4D-8293-A8AE7BA8863A@openvpn.com>
Date: Thu, 3 Sep 2026 21:26:16 +0300
To: Openvpn-announce@lists.sourceforge.net,
 Openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Headers-End: 1x2CW2-0002fZ-VS
Subject: [Openvpn-devel] OpenVPN 2.7.7 released
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
From: Yuriy Darnobyt via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Yuriy Darnobyt <yuriy.darnobyt@openvpn.com>
Content-Type: multipart/mixed; boundary="===============6055247935520577157=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============6055247935520577157==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_8A8929A5-88E4-4DEB-AB05-E45672DFEF5B"


--Apple-Mail=_8A8929A5-88E4-4DEB-AB05-E45672DFEF5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The OpenVPN community project team is proud to release OpenVPN 2.7.7. =
This is a
bugfix release fixing several security issues.

Security fixes:

* reliability layer: avoid unbounded reliable TLS timeout, and ignore =
acks for
 packets that cannot be outstanding (CVE-2026-84732)
 Both reliability layer bugs found by Mark Bregman (Fox-IT)
* windows: fix CreateProcess() command line quoting for characters that =
are special
 to cmd.exe, where a combination of validation script plus rogue CA =
could lead to
 misbehavior (CVE-2026-84256)
 Bug found by Clouditera Security
* windows: fix tapctl to always call netsh.exe with full path (as we do =
elsewhere)
 (CVE-2026-84226)
 Bug found by BreachX Zero Day Labs (using Typhon AI Mil v2)
* windows: don't use NULL DACL with system objects, namely the --service =
exit event
 and the netsh.exe guard semaphore.
 The old approach was prone to a local DoS where one user could =
interfere with
 other users' openvpn processes by blocking the netsh semaphore or =
sending events.
 This only affects setups not using the iservice, or using the automatic =
service to
 start/stop openvpn (CVE-2026-82312)
 Bug found by DEBRAJ BASAK
* openvpnserv (windows): pass correct NRPT domains size - when IDN =
domains with UTF8
 encoding were involved, a buffer overread could be achieved =
(CVE-2026-78221)
 Bug found by BreachX Zero Day Labs (using Typhon AI Mil v2)
* openvpnserv (windows): don't allow '/' in config paths.
 The APIs windows uses for path validation do not handle '/' as path =
separator,
 while the file open APIs do, so this could be used to circumvent our =
config path
 validation, leading to openvpn.exe starting a user-controlled config =
file even if
 administratively not allowed (CVE-2026-78043)
 Bug found by BreachX Zero Day Labs (using Typhon AI Mil v2)
* dhcp (windows): fix off-by-one in write_dhcp_search_str() temp buffer =
guard -
 suitable DHCP options could lead to a single-byte overflow of a temp =
buffer
 (CVE-2026-81738)
 Bug found by Andre Kropp (Nexory) and ChinhNguyen
* linux netlink: validate netlink replies against the request
 Suggested by Joshua Rogers as a security improvement
* openvpnserv (windows): fix off-by-one on input validation (discovered =
while fixing
 CVE-2026-78221)
* openvpnserv (windows): harden CheckConfigPath() a bit more (another =
improvement
 while working on CVE-2026-78043)

User-visible Changes:

* when using EPOCH data channel format, reduce the number of future keys =
from 16 to
 4 - the previous calculation was wrong, and 4 spare keys are sufficient =
for 100+
 Gbit/s links. This means less log spam in userland and fewer resources =
used in
 in-kernel implementations.

Bugfixes:

* work around a pubkey-handling bug in mbedTLS 4.1.0 and 4.2.0 =
(supposedly fixed in
 4.3.0)
* multi: don't let stale-routes-check delete permanent routes - =
--stale-routes-check
 did not only delete dynamic cached routes, but also routes installed by =
--iroute
 and --ifconfig-push. Fixed by introducing route flags and restraining =
the check on
 them (Github: OpenVPN/openvpn#1063)
* ssl: do not queue control ciphertext while a packet is still queued =
(fixes problems
 in TCP p2p handshake when both sides try to handshake at the same time) =
(Github:
 OpenVPN/openvpn#1089)
* reenable xmit_hold when using p2p tcp-server and tls-server - in TCP =
server mode
 the server is not expected to initiate the TLS handshake. This was =
introduced by
 the multisocket code checking the wrong variable for socket protocol =
(Github:
 OpenVPN/openvpn#1089)
* clinat: do not adjust UDP checksum if zero (as per RFC768) (Github:
 OpenVPN/openvpn#1037)
* openssl: avoid resetting the HMAC key on every packet (Github:
 OpenVPN/openvpn#1088)
* openvpnserv (windows): fix log lines format string - interface names =
with
 international characters printed in some error messages need to be =
converted from
 UTF8 to UCS16 first.
* fix format string specifier for size_t (%zu)
* fix test_misc compile issues with -Werror

Windows MSI changes since 2.7.6-I001:

* Update included dco-win driver to v2.8.7
  * peer: fix use-after-free in multipeer peer table handling (Github: =
OpenVPN/ovpn-dco-win#140)
  * inf: set the device security descriptor in the hardware key (Github: =
OpenVPN/ovpn-dco-win#139)

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.7/Changes.rst =
<https://github.com/OpenVPN/openvpn/blob/v2.7./Changes.rst>>

Source code and Windows installers can be downloaded from our download =
page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in =
the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_8A8929A5-88E4-4DEB-AB05-E45672DFEF5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>The OpenVPN community project team =
is proud to release OpenVPN 2.7.7. This is a</div><div>bugfix release =
fixing several security issues.</div><div><br></div><div>Security =
fixes:</div><div><br></div><div>* reliability layer: avoid unbounded =
reliable TLS timeout, and ignore acks for</div><div>&nbsp;packets that =
cannot be outstanding (CVE-2026-84732)</div><div>&nbsp;Both reliability =
layer bugs found by Mark Bregman (Fox-IT)</div><div>* windows: fix =
CreateProcess() command line quoting for characters that are =
special</div><div>&nbsp;to cmd.exe, where a combination of validation =
script plus rogue CA could lead to</div><div>&nbsp;misbehavior =
(CVE-2026-84256)</div><div>&nbsp;Bug found by Clouditera =
Security</div><div>* windows: fix tapctl to always call netsh.exe with =
full path (as we do =
elsewhere)</div><div>&nbsp;(CVE-2026-84226)</div><div>&nbsp;Bug found by =
BreachX Zero Day Labs (using Typhon AI Mil v2)</div><div>* windows: =
don't use NULL DACL with system objects, namely the --service exit =
event</div><div>&nbsp;and the netsh.exe guard =
semaphore.</div><div>&nbsp;The old approach was prone to a local DoS =
where one user could interfere with</div><div>&nbsp;other users' openvpn =
processes by blocking the netsh semaphore or sending =
events.</div><div>&nbsp;This only affects setups not using the iservice, =
or using the automatic service to</div><div>&nbsp;start/stop openvpn =
(CVE-2026-82312)</div><div>&nbsp;Bug found by DEBRAJ BASAK</div><div>* =
openvpnserv (windows): pass correct NRPT domains size - when IDN domains =
with UTF8</div><div>&nbsp;encoding were involved, a buffer overread =
could be achieved (CVE-2026-78221)</div><div>&nbsp;Bug found by BreachX =
Zero Day Labs (using Typhon AI Mil v2)</div><div>* openvpnserv =
(windows): don't allow '/' in config paths.</div><div>&nbsp;The APIs =
windows uses for path validation do not handle '/' as path =
separator,</div><div>&nbsp;while the file open APIs do, so this could be =
used to circumvent our config path</div><div>&nbsp;validation, leading =
to openvpn.exe starting a user-controlled config file even =
if</div><div>&nbsp;administratively not allowed =
(CVE-2026-78043)</div><div>&nbsp;Bug found by BreachX Zero Day Labs =
(using Typhon AI Mil v2)</div><div>* dhcp (windows): fix off-by-one in =
write_dhcp_search_str() temp buffer guard -</div><div>&nbsp;suitable =
DHCP options could lead to a single-byte overflow of a temp =
buffer</div><div>&nbsp;(CVE-2026-81738)</div><div>&nbsp;Bug found by =
Andre Kropp (Nexory) and ChinhNguyen</div><div>* linux netlink: validate =
netlink replies against the request</div><div>&nbsp;Suggested by Joshua =
Rogers as a security improvement</div><div>* openvpnserv (windows): fix =
off-by-one on input validation (discovered while =
fixing</div><div>&nbsp;CVE-2026-78221)</div><div>* openvpnserv =
(windows): harden CheckConfigPath() a bit more (another =
improvement</div><div>&nbsp;while working on =
CVE-2026-78043)</div><div><br></div><div>User-visible =
Changes:</div><div><br></div><div>* when using EPOCH data channel =
format, reduce the number of future keys from 16 to</div><div>&nbsp;4 - =
the previous calculation was wrong, and 4 spare keys are sufficient for =
100+</div><div>&nbsp;Gbit/s links. This means less log spam in userland =
and fewer resources used in</div><div>&nbsp;in-kernel =
implementations.</div><div><br></div><div>Bugfixes:</div><div><br></div><d=
iv>* work around a pubkey-handling bug in mbedTLS 4.1.0 and 4.2.0 =
(supposedly fixed in</div><div>&nbsp;4.3.0)</div><div>* multi: don't let =
stale-routes-check delete permanent routes - =
--stale-routes-check</div><div>&nbsp;did not only delete dynamic cached =
routes, but also routes installed by --iroute</div><div>&nbsp;and =
--ifconfig-push. Fixed by introducing route flags and restraining the =
check on</div><div>&nbsp;them (Github: OpenVPN/openvpn#1063)</div><div>* =
ssl: do not queue control ciphertext while a packet is still queued =
(fixes problems</div><div>&nbsp;in TCP p2p handshake when both sides try =
to handshake at the same time) =
(Github:</div><div>&nbsp;OpenVPN/openvpn#1089)</div><div>* reenable =
xmit_hold when using p2p tcp-server and tls-server - in TCP server =
mode</div><div>&nbsp;the server is not expected to initiate the TLS =
handshake. This was introduced by</div><div>&nbsp;the multisocket code =
checking the wrong variable for socket protocol =
(Github:</div><div>&nbsp;OpenVPN/openvpn#1089)</div><div>* clinat: do =
not adjust UDP checksum if zero (as per RFC768) =
(Github:</div><div>&nbsp;OpenVPN/openvpn#1037)</div><div>* openssl: =
avoid resetting the HMAC key on every packet =
(Github:</div><div>&nbsp;OpenVPN/openvpn#1088)</div><div>* openvpnserv =
(windows): fix log lines format string - interface names =
with</div><div>&nbsp;international characters printed in some error =
messages need to be converted from</div><div>&nbsp;UTF8 to UCS16 =
first.</div><div>* fix format string specifier for size_t =
(%zu)</div><div>* fix test_misc compile issues with =
-Werror</div><div><br></div><div><div>Windows MSI changes since =
2.7.6-I001:</div><div><br></div><div>* Update included dco-win driver to =
v2.8.7</div><div>&nbsp; * peer: fix use-after-free in multipeer peer =
table handling (Github: OpenVPN/ovpn-dco-win#140)</div><div>&nbsp; * =
inf: set the device security descriptor in the hardware key (Github: =
OpenVPN/ovpn-dco-win#139)</div></div><div><br></div><div><p =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255);"><span style=3D"font-kerning: none">More details can be found in =
the Changes document:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(53, 134, 255); -webkit-text-stroke-width: 0px; =
-webkit-text-stroke-color: rgb(53, 134, 255);"><span =
style=3D"font-kerning: none; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(255, 255, 255);">&lt;<a =
href=3D"https://github.com/OpenVPN/openvpn/blob/v2.7./Changes.rst"><span =
style=3D"font-kerning: none; -webkit-text-stroke-color: rgb(53, 134, =
255);">https://github.com/OpenVPN/openvpn/blob/v2.7.7/Changes.rst</span></=
a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255);"><span style=3D"font-kerning: none">Source code and Windows =
installers can be downloaded from our download page:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(53, 134, 255); -webkit-text-stroke-width: 0px; =
-webkit-text-stroke-color: rgb(53, 134, 255);"><span =
style=3D"font-kerning: none; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(255, 255, 255);">&lt;<a =
href=3D"https://openvpn.net/community/"><span style=3D"font-kerning: =
none; -webkit-text-stroke-color: rgb(53, 134, =
255);">https://openvpn.net/community/</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255);"><span style=3D"font-kerning: none">Packages for Debian, Ubuntu, =
Fedora, RHEL, and openSUSE are available in the various</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255);"><span style=3D"font-kerning: none">official Community =
repositories:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(53, 134, 255); -webkit-text-stroke-width: 0px; =
-webkit-text-stroke-color: rgb(53, 134, 255);"><span =
style=3D"font-kerning: none; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(255, 255, 255);">&lt;<a =
href=3D"https://community.openvpn.net/Pages/OpenVPN%20software%20repos"><s=
pan style=3D"font-kerning: none; -webkit-text-stroke-color: rgb(53, 134, =
255);">https://community.openvpn.net/Pages/OpenVPN%20software%20repos</spa=
n></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, =
255); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: =
rgb(0, 0, 0);"><span style=3D"font-kerning: none">Kind =
regards,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: =
rgb(0, 0, 0);"><span style=3D"font-kerning: none">Yuriy =
Darnobyt</span></p></div></body></html>=

--Apple-Mail=_8A8929A5-88E4-4DEB-AB05-E45672DFEF5B--


--===============6055247935520577157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6055247935520577157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6055247935520577157==--

