Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E2606A332
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ih26FmII;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EFtKPDwI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K8+qZ5Vq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QG2CHDcM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IFeRHK7NKnkfX8Z+cX7FgloyOYFLRO/fSmpzgzT85YM=; b=ih26FmIIc5q+6xnCpa6xElzSmo
	FDdf9uBiEH1qHGBKWjzV0tt5P+BUEHRNkj2XxX8J4cdSyS6iBeEQLe/uAM7lPxFEuOEVXZTmos8P4
	w+7qpnxd7S57Tuc0GtSbhydNB914tGo/fpu8A66PXXrtFDdmwSd6ovNI06k4wunn0juc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW9PC-000000002ua-3TK8;
	Wed, 25 Nov 2026 09:35:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW9PA-000000002uS-3Edg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AYiBLR9bYkRUrOIf1TgZ5M8Fu7WqHx8TZSgGsFkuvzY=; b=EFtKPDwIz3R/iPzew8ptPngBXX
 5hXmIgSStTYBI2rJeomqdtzD7kRyp/jMPAmih7OFjcTAgcnzsxGu1iIgpqxaSiBvN+DaGnLphq6oQ
 cvyzWuj7iJ3gtN3Y110HZrE8NybEtMQTMJOSYRDrBk2Vm4jovRQhrgA3vsfZk0faS2vU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AYiBLR9bYkRUrOIf1TgZ5M8Fu7WqHx8TZSgGsFkuvzY=; b=K8+qZ5VqE0TmSVueWmIltcqWJb
 yaB2ElU40UW7bQcAQScEirsv6VHjLD6/abLB7OhxU7EPRUOyirUMj4fB9ZpLkpp7wUccXUAaCjl90
 dYlir46Y1KmcFgJ28SM9WBSkybT/lzG1lpdIIh70yL1RTR9C+IdA6WZ4baex1XHi8YZM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW9P4-000000003N4-48Ak for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:35:08 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so53388715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 01:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795599296; x=1796204096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AYiBLR9bYkRUrOIf1TgZ5M8Fu7WqHx8TZSgGsFkuvzY=;
 b=QG2CHDcM4iObeqy6VmQ/MCWluZJUFQECXJUk46VhFqFnJsOiNFt9LOLnYF7ej2Axvh
 Qj/KllmPIGZktJTkXwq814dHKREt54vQ/lyJUo6hFIQ509/Fc5i5VbNBq0oJrbbuwkOG
 9pVFrZHs7bNkKibdacTccYsEZ+CNsjUqqJA0yCs1rpwuOp/qC7kLcIK/uAPherw0v2gn
 NW3DyK7d9lMn7GbZ1Ab8N90vjjKwu+ewghGSgxqjcgw7Y4vrvJgdoIOLpe3TQFS1a8HR
 cN1Pm771r4T+vvYvq+OJrkh2EtTvezXkFzVMNc2RWZtIF9yYd2/U5LFf8D8rjAzvYrwH
 DyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599296; x=1796204096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AYiBLR9bYkRUrOIf1TgZ5M8Fu7WqHx8TZSgGsFkuvzY=;
 b=BXUjkhJO5OplSf2UNXDdQHbhpC7mJM0hFrqyqx0LsGgpTLmHxWQmqP7Or63lLLirOa
 kde7aWhqbeEiGnb0lTlIDx4QVk3uNKGW0j6xhzmyOT2P4YZlNtYjeqgjeuI1qg36Okze
 aX78KVxwCCYOhfLRPhbmf4mwAxNOR2KgtkldjePjN8GR2VkM9RqCfwlXbmv6E31Ot0z3
 i+/7Rs1R4FzCU5Q5SCqVgg70zRqeJGG9xzYvTcaMpNEJvc+VSd8/l/0Cm21BPMjRhYI2
 8j5bRZecY1zsE2agb4wz7+yfWlqSnz3qo+wtodK9oYPUFhRVAW/Runclp5j3g4NOuB0W
 qnnA==
X-Gm-Message-State: APuU4Z8nhf0mXe93HXI5unPPHysuJ5XUw0xxaH82divEpV7Rwd7aYZ5F
 iegbHZFyR3EDy9SIlAGGzS22css3IBBjANd7pv06ydxVVtfLQaKH55CPR1yv47EGFGxCAaqS6Cl
 iB2FeMuo0ZWEJz6GZ0Srju9tLMpFDBQ5h9MLls4515p5wnz8zxCpHFmJYN9j7fgo908ux
X-Gm-Gg: AZFdTZebwcjXhvptmTr/jwbwr+b99C0Zfbb0eAGaazZX6v8Vevg8ZKzDR1MkUnkxCbs
 Ac5TP9xFkpDT7kVyi3KVeV0j3Mco8sAhO44EW0Zvo9bOdKl4TOi9c2ARdHnEsiIVRPqnC2Evdk/
 NZILBeAmJqEKSFRujf2I/w0TvRe5r1Fiv3PwUNLyjAX99jn12n2lzPbdKv9PU8D0oEWqhMT27aE
 guhQSls4gRToBX1V1neyj+xzQYF6Zj2+ni+n5lFW3+EXXXQeOcuNIUJ08fDnZygY0qspPTJIuXr
 qgy/NfyW162RdHTnN3vDYA57xA07a9mZv9ahTvbB8zf1UrhI0BGMBOYst76af6lc/tCI4RKKB1e
 wSorVJWZjMAxLUP9GkwyPETzi6Pz+7W1uirGCnUSQHGRpITjU4FtpeYxiyChL9ZP+jn34+7c6Qv
 5KNKIqhkHOzP/p6UUKSwYUMbRExxRb/eCJI5v1+F0UxPrAQiT+ER2tG8sjvWSL3p6ZXAQToUJK3
 0gzweQMuyQqDRzVsoRVzh/zXiEaPJZRXy+oGzLTw4Vx1VEs5n91TKHS6MFJ9yIZ/8lozooR7X3G
 1aSSdl4oDVPMLVcvdQBXSKtBOAIfHPBW7TSc2Jedrbn85XC0qMK1P7V8yCU3y/SmKPw8RgP0mpa
 33b0VpDbJiPO+zm4WuD9Z5sqDK73x7KUEpXX5S/0OYrnWxxKuXUODXvCJij1pNFLq6dJoG145hc
 XMqFZ0LoC5X9Cefh8=
X-Received: by 2002:a05:600c:6708:b0:4ba:7e6:53d6 with SMTP id
 5b1f17b1804b1-4bb88940848mr305466065e9.33.1795599296062; 
 Wed, 25 Nov 2026 01:34:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f148aasm199223495e9.0.2026.11.25.01.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:34:55 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 09:34:53 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 53542aefa682e59d804ae353be9731bf15ed9dfd
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19c093d186e7b22297592108990c5d35e534d115-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xW9P4-000000003N4-48Ak
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2345480319380237318=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2345480319380237318==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7HAmGtA4vzE="; charset=UTF-8

--7HAmGtA4vzE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to=
 reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2341?usp=3Demail

to look at the new patch set (#2)=2E

The follow=
ing approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan C=
ojocaru


Change subject: dns-scripts: parse dns_vars_file as data instead =
of sourcing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dns-scripts: parse dns_vars_file as data instead of sourcing it

When --u=
ser is used, openvpn forks a privileged runner that executes the
dns-updown=
 script as root=2E The unprivileged process writes the DNS
variables to a t=
emporary file (env_set_write_file(), raw NAME=3Dvalue lines)
and passes its=
 path to the runner, and all in-tree dns-updown scripts then
load that file=
 with "=2E $dns_vars_file", i=2Ee=2E they execute it as shell code=2E

Toda=
y the values are restricted by validate_domain() and friends, so this
is no=
t exploitable from the network=2E But the design means (a) the safety
of ro=
ot code execution rests entirely on that validation, and (b) the
privilege =
separation the runner exists for does not hold: whoever controls
the unpriv=
ileged process controls a file root will execute=2E

Replace the sourcing w=
ith a small reader that only accepts the variable
names openvpn writes (dns=
_server_*, dns_search_domain_*, dev, script_type),
validates the name and a=
ssigns the value without evaluating it=2E Also stop
re-evaluating already-c=
ollected search domains in the "domains" loop of
the resolvconf_file, haiku=
os_file and systemd scripts=2E

dev is also pasted into a sed program by th=
e dns-down code of the
resolvconf_file, haikuos_file and systemd scripts=2E=
 The reader therefore
only accepts a dev value that starts with a letter or=
 digit, consists of
letters, digits, '_', '=2E', '-' and '/' ('/' because H=
aiku names its
devices tun/N) and does not contain "=2E=2E"=2E Those sed ca=
lls now use
\%regex% addresses, so a '/' in dev cannot end the address eith=
er=2E

If the file cannot be read, the reader now exits with an error inste=
ad
of letting the script carry on with nothing set=2E With "=2E file" the
/=
bin/sh scripts stopped there as well=2E

This addresses (b) only as far as =
the scripts are concerned: root no
longer executes the file, and dev can no=
 longer inject sed commands=2E It
does not make the file trusted input=2E T=
he C side still trusts the path
it receives from the unprivileged process, =
and the values are still
handed to resolv=2Econf, resolvectl, resolvconf an=
d scutil as DNS
configuration, as before=2E

No functional change intended =
for valid values=2E For the resolvconf_file
and systemd scripts, the result=
ing resolv=2Econf and resolvectl arguments
were compared before and after t=
he change=2E They are identical except
for the number of trailing blanks on=
 the "search" line when fewer than
six search domains are pushed, which the=
 old loop collapsed through word
splitting=2E

Change-Id: Id05f3e4e32aeb806=
d762858e754adc82f42d4371
Signed-off-by: Deri Haerudi <Abcderyscreenprinting=
@gmail=2Ecom>
---
M distro/dns-scripts/haikuos_file-dns-updown=2Esh
M distr=
o/dns-scripts/macos-dns-updown=2Esh
M distro/dns-scripts/openresolv-dns-upd=
own=2Esh
M distro/dns-scripts/resolvconf_file-dns-updown=2Esh
M distro/dns-=
scripts/systemd-dns-updown=2Esh
5 files changed, 189 insertions(+), 11 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/41/2341/2

diff --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh =
b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
index e19b2b7=2E=2E5f94d9=
3 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown=2Esh
+++ b/distro=
/dns-scripts/haikuos_file-dns-updown=2Esh
@@ -43,7 +43,42 @@
 
 conf=3D/boo=
t/system/settings/network/resolv=2Econf
 test -e "$conf" || exit 1
-test -z=
 "${dns_vars_file}" || =2E "${dns_vars_file}"
+# Read the variables that op=
envpn wrote to $dns_vars_file as data=2E
+# The file is deliberately NOT so=
urced: values may originate from options
+# pushed by the server, and the f=
ile is written by the unprivileged
+# openvpn process, so sourcing it would=
 execute shell syntax contained
+# in a value (command substitution, quotes=
, redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || exi=
t 1
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_=
line in
+            *=3D*) ;;
+            *) continue ;;
+        esac
+ =
       _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case=
 $_name in
+            dns_server_* | dns_search_domain_* | script_type) ;=
;
+            dev)
+                # dev is used in sed expressions and a=
s a command argument:
+                # only accept interface name charact=
ers ("/" for Haiku tun/N)
+                case $_value in
+               =
     [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)
+                    =
    echo "invalid dev name in ${_f}"
+                        exit 1
+     =
                   ;;
+                esac
+                ;;
+          =
  *) continue ;;
+        esac
+        case $_name in
+            *[!A-Za=
-z0-9_]*) continue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+=
    done < "$_f"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${dns_var=
s_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +110,8 @@
 =

     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
=
-            eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
=
+            eval d=3D\"\$dns_search_domain_${i}\" || break
+            do=
mains=3D"$domains$d "
         done
         text=3D"${text}search $domains=
\n"
     }
@@ -85,6 +121,6 @@
     echo "${text}" > "${conf}"
     ;;
 dns-=
down)
-    sed -i'' -e "/### openvpn ${dev} begin ###/,/### openvpn ${dev} =
end ###/d" "$conf"
+    sed -i'' -e "\%### openvpn ${dev} begin ###%,\%### =
openvpn ${dev} end ###%d" "$conf"
     ;;
 esac
diff --git a/distro/dns-scr=
ipts/macos-dns-updown=2Esh b/distro/dns-scripts/macos-dns-updown=2Esh
index=
 fccc6b5=2E=2E713ac1b 100644
--- a/distro/dns-scripts/macos-dns-updown=2Esh=

+++ b/distro/dns-scripts/macos-dns-updown=2Esh
@@ -43,7 +43,42 @@
 done
 t=
rap "/bin/rm -f ${lockfile}" EXIT
 
-[ -z "${dns_vars_file}" ] || =2E "${dn=
s_vars_file}"
+# Read the variables that openvpn wrote to $dns_vars_file as=
 data=2E
+# The file is deliberately NOT sourced: values may originate from=
 options
+# pushed by the server, and the file is written by the unprivileg=
ed
+# openvpn process, so sourcing it would execute shell syntax contained
=
+# in a value (command substitution, quotes, redirections)=2E
+dns_vars_loa=
d() {
+    _f=3D$1
+    [ -r "$_f" ] || exit 1
+    while IFS=3D read -r _l=
ine || [ -n "$_line" ]; do
+        case $_line in
+            *=3D*) ;;
+=
            *) continue ;;
+        esac
+        _name=3D${_line%%=3D*}
+ =
       _value=3D${_line#*=3D}
+        case $_name in
+            dns_serv=
er_* | dns_search_domain_* | script_type) ;;
+            dev)
+           =
     # dev is used in sed expressions and as a command argument:
+         =
       # only accept interface name characters ("/" for Haiku tun/N)
+     =
           case $_value in
+                    [!A-Za-z0-9]* | *[!A-Za-z0-=
9_=2E/-]* | *=2E=2E*)
+                        echo "invalid dev name in ${=
_f}"
+                        exit 1
+                        ;;
+         =
       esac
+                ;;
+            *) continue ;;
+        esac
+=
        case $_name in
+            *[!A-Za-z0-9_]*) continue ;;
+        e=
sac
+        eval "$_name=3D\"\$_value\""
+    done < "$_f"
+}
+[ -z "${dns=
_vars_file}" ] || dns_vars_load "${dns_vars_file}"
 
 itf_dns_key=3D"State:=
/Network/Service/openvpn-${dev}/DNS"
 
diff --git a/distro/dns-scripts/open=
resolv-dns-updown=2Esh b/distro/dns-scripts/openresolv-dns-updown=2Esh
inde=
x 4aca99f=2E=2E299440b 100644
--- a/distro/dns-scripts/openresolv-dns-updow=
n=2Esh
+++ b/distro/dns-scripts/openresolv-dns-updown=2Esh
@@ -42,7 +42,42 =
@@
     done
 }
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
+# R=
ead the variables that openvpn wrote to $dns_vars_file as data=2E
+# The fi=
le is deliberately NOT sourced: values may originate from options
+# pushed=
 by the server, and the file is written by the unprivileged
+# openvpn proc=
ess, so sourcing it would execute shell syntax contained
+# in a value (com=
mand substitution, quotes, redirections)=2E
+dns_vars_load() {
+    _f=3D$1=

+    [ -r "$_f" ] || exit 1
+    while IFS=3D read -r _line || [ -n "$_lin=
e" ]; do
+        case $_line in
+            *=3D*) ;;
+            *) con=
tinue ;;
+        esac
+        _name=3D${_line%%=3D*}
+        _value=3D${=
_line#*=3D}
+        case $_name in
+            dns_server_* | dns_search_=
domain_* | script_type) ;;
+            dev)
+                # dev is used=
 in sed expressions and as a command argument:
+                # only acce=
pt interface name characters ("/" for Haiku tun/N)
+                case $_=
value in
+                    [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=
=2E*)
+                        echo "invalid dev name in ${_f}"
+          =
              exit 1
+                        ;;
+                esac
+   =
             ;;
+            *) continue ;;
+        esac
+        case $_n=
ame in
+            *[!A-Za-z0-9_]*) continue ;;
+        esac
+        eva=
l "$_name=3D\"\$_value\""
+    done < "$_f"
+}
+[ -z "${dns_vars_file}" ] |=
| dns_vars_load "${dns_vars_file}"
 : ${script_type:=3Ddns-down}
 case "${s=
cript_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dn=
s-updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
index 8d=
23ed6=2E=2Ef41fe27 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updo=
wn=2Esh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
@@ -43,7 +=
43,42 @@
 
 conf=3D/etc/resolv=2Econf
 test -e "$conf" || exit 1
-test -z "=
${dns_vars_file}" || =2E "${dns_vars_file}"
+# Read the variables that open=
vpn wrote to $dns_vars_file as data=2E
+# The file is deliberately NOT sour=
ced: values may originate from options
+# pushed by the server, and the fil=
e is written by the unprivileged
+# openvpn process, so sourcing it would e=
xecute shell syntax contained
+# in a value (command substitution, quotes, =
redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || exit =
1
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_li=
ne in
+            *=3D*) ;;
+            *) continue ;;
+        esac
+   =
     _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case $=
_name in
+            dns_server_* | dns_search_domain_* | script_type) ;;
=
+            dev)
+                # dev is used in sed expressions and as =
a command argument:
+                # only accept interface name character=
s ("/" for Haiku tun/N)
+                case $_value in
+                 =
   [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)
+                      =
  echo "invalid dev name in ${_f}"
+                        exit 1
+       =
                 ;;
+                esac
+                ;;
+            =
*) continue ;;
+        esac
+        case $_name in
+            *[!A-Za-z=
0-9_]*) continue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+  =
  done < "$_f"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${dns_vars_=
file}"
 case "${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +110,8 @@
 
 =
    test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
- =
           eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+ =
           eval d=3D\"\$dns_search_domain_${i}\" || break
+            doma=
ins=3D"$domains$d "
         done
         text=3D"${text}search $domains\n=
"
     }
@@ -85,6 +121,6 @@
     echo "${text}" > "${conf}"
     ;;
 dns-do=
wn)
-    sed -i'' -e "/### openvpn ${dev} begin ###/,/### openvpn ${dev} en=
d ###/d" "$conf"
+    sed -i'' -e "\%### openvpn ${dev} begin ###%,\%### op=
envpn ${dev} end ###%d" "$conf"
     ;;
 esac
diff --git a/distro/dns-scrip=
ts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh
ind=
ex 553056b=2E=2Ecb02b89 100644
--- a/distro/dns-scripts/systemd-dns-updown=
=2Esh
+++ b/distro/dns-scripts/systemd-dns-updown=2Esh
@@ -34,7 +34,42 @@
 =
#   dns_server_1_sni dns=2Emycorp=2Ein
 #
 
-[ -z "${dns_vars_file}" ] || =
=2E "${dns_vars_file}"
+# Read the variables that openvpn wrote to $dns_var=
s_file as data=2E
+# The file is deliberately NOT sourced: values may origi=
nate from options
+# pushed by the server, and the file is written by the u=
nprivileged
+# openvpn process, so sourcing it would execute shell syntax c=
ontained
+# in a value (command substitution, quotes, redirections)=2E
+dns=
_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || exit 1
+    while IFS=3D r=
ead -r _line || [ -n "$_line" ]; do
+        case $_line in
+            *=
=3D*) ;;
+            *) continue ;;
+        esac
+        _name=3D${_line=
%%=3D*}
+        _value=3D${_line#*=3D}
+        case $_name in
+          =
  dns_server_* | dns_search_domain_* | script_type) ;;
+            dev)
+ =
               # dev is used in sed expressions and as a command argument:
=
+                # only accept interface name characters ("/" for Haiku tun=
/N)
+                case $_value in
+                    [!A-Za-z0-9]* | *=
[!A-Za-z0-9_=2E/-]* | *=2E=2E*)
+                        echo "invalid dev =
name in ${_f}"
+                        exit 1
+                        ;;
=
+                esac
+                ;;
+            *) continue ;;
+    =
    esac
+        case $_name in
+            *[!A-Za-z0-9_]*) continue ;;
=
+        esac
+        eval "$_name=3D\"\$_value\""
+    done < "$_f"
+}
+[=
 -z "${dns_vars_file}" ] || dns_vars_load "${dns_vars_file}"
 
 function do=
_resolved_servers {
     local sni=3D""
@@ -227,7 +262,8 @@
 
         test=
 -z "$dns_search_domain_1" || {
             for i in $(seq 1 6); do
-     =
           eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+ =
               eval d=3D\"\$dns_search_domain_${i}\" || break
+            =
    domains=3D"$domains$d "
             done
             text=3D"${text}s=
earch $domains\n"
         }
@@ -236,7 +272,7 @@
         sed -i "1i${text}=
" "$conf"
     else
         echo "unsetting DNS using resolv=2Econf file"
=
-        sed -i "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###=
/d" "$conf"
+        sed -i "\%### openvpn ${dev} begin ###%,\%### openvpn =
${dev} end ###%d" "$conf"
     fi
 
     return 0

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d437=
1
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 2
Gerrit-Owner: Deri Haerudi =
<abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--7HAmGtA4vzE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Deri Haerudi <strong>uploaded patch set #2</strong> to this change=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">dns-scripts=
: parse dns_vars_file as data instead of sourcing it<br><br>When --user is =
used, openvpn forks a privileged runner that executes the<br>dns-updown scr=
ipt as root=2E The unprivileged process writes the DNS<br>variables to a te=
mporary file (env_set_write_file(), raw NAME=3Dvalue lines)<br>and passes i=
ts path to the runner, and all in-tree dns-updown scripts then<br>load that=
 file with &quot;=2E $dns_vars_file&quot;, i=2Ee=2E they execute it as shel=
l code=2E<br><br>Today the values are restricted by validate_domain() and f=
riends, so this<br>is not exploitable from the network=2E But the design me=
ans (a) the safety<br>of root code execution rests entirely on that validat=
ion, and (b) the<br>privilege separation the runner exists for does not hol=
d: whoever controls<br>the unprivileged process controls a file root will e=
xecute=2E<br><br>Replace the sourcing with a small reader that only accepts=
 the variable<br>names openvpn writes (dns_server_*, dns_search_domain_*, d=
ev, script_type),<br>validates the name and assigns the value without evalu=
ating it=2E Also stop<br>re-evaluating already-collected search domains in =
the &quot;domains&quot; loop of<br>the resolvconf_file, haikuos_file and sy=
stemd scripts=2E<br><br>dev is also pasted into a sed program by the dns-do=
wn code of the<br>resolvconf_file, haikuos_file and systemd scripts=2E The =
reader therefore<br>only accepts a dev value that starts with a letter or d=
igit, consists of<br>letters, digits, &#39;_&#39;, &#39;=2E&#39;, &#39;-&#3=
9; and &#39;/&#39; (&#39;/&#39; because Haiku names its<br>devices tun/N) a=
nd does not contain &quot;=2E=2E&quot;=2E Those sed calls now use<br>\%rege=
x% addresses, so a &#39;/&#39; in dev cannot end the address either=2E<br><=
br>If the file cannot be read, the reader now exits with an error instead<b=
r>of letting the script carry on with nothing set=2E With &quot;=2E file&qu=
ot; the<br>/bin/sh scripts stopped there as well=2E<br><br>This addresses (=
b) only as far as the scripts are concerned: root no<br>longer executes the=
 file, and dev can no longer inject sed commands=2E It<br>does not make the=
 file trusted input=2E The C side still trusts the path<br>it receives from=
 the unprivileged process, and the values are still<br>handed to resolv=2Ec=
onf, resolvectl, resolvconf and scutil as DNS<br>configuration, as before=
=2E<br><br>No functional change intended for valid values=2E For the resolv=
conf_file<br>and systemd scripts, the resulting resolv=2Econf and resolvect=
l arguments<br>were compared before and after the change=2E They are identi=
cal except<br>for the number of trailing blanks on the &quot;search&quot; l=
ine when fewer than<br>six search domains are pushed, which the old loop co=
llapsed through word<br>splitting=2E<br><br>Change-Id: Id05f3e4e32aeb806d76=
2858e754adc82f42d4371<br>Signed-off-by: Deri Haerudi &lt;Abcderyscreenprint=
ing@gmail=2Ecom&gt;<br>---<br>M distro/dns-scripts/haikuos_file-dns-updown=
=2Esh<br>M distro/dns-scripts/macos-dns-updown=2Esh<br>M distro/dns-scripts=
/openresolv-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf_file-dns-upd=
own=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>5 files changed=
, 189 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/2341/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scri=
pts/haikuos_file-dns-updown=2Esh</span><br><span>index e19b2b7=2E=2E5f94d93=
 100644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2E=
sh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</s=
pan><br><span>@@ -43,7 +43,42 @@</span><br><span> </span><br><span> conf=3D=
/boot/system/settings/network/resolv=2Econf</span><br><span> test -e &quot;=
$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_file}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read the variables t=
hat openvpn wrote to $dns_vars_file as data=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# The file is deliberately NOT sourced: values m=
ay originate from options</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# pushed by the server, and the file is written by the unprivileged</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# openvpn process, so=
 sourcing it would execute shell syntax contained</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# in a value (command substitution, quotes, r=
edirections)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_=
vars_load() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _f=
=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot=
;$_f&quot; ] || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case $_line in</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) continue=
 ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_line=
%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _val=
ue=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            dns_server_* | dns_search_domain_* | script_type) ;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            dev)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                # dev is used i=
n sed expressions and as a command argument:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                # only accept interface name chara=
cters (&quot;/&quot; for Haiku tun/N)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                case $_value in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    [!A-Za-z0-9]* | *[!A-Za-z=
0-9_=2E/-]* | *=2E=2E*)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        echo &quot;invalid dev name in ${_f}&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}&quot=
; || dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> case &quot=
;${script_type}&quot; in</span><br><span> dns-up)</span><br><span>     n=3D=
1</span><br><span>@@ -75,7 +110,8 @@</span><br><span> </span><br><span>    =
 test -z &quot;$dns_search_domain_1&quot; || {</span><br><span>         for=
 i in $(seq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; |=
| break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
eval d=3D\&quot;\$dns_search_domain_${i}\&quot; || break</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            domains=3D&quot;$domains$d=
 &quot;</span><br><span>         done</span><br><span>         text=3D&quot=
;${text}search $domains\n&quot;</span><br><span>     }</span><br><span>@@ -=
85,6 +121,6 @@</span><br><span>     echo &quot;${text}&quot; &gt; &quot;${c=
onf}&quot;</span><br><span>     ;;</span><br><span> dns-down)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    sed -i&#39;&#39; -e &quot;/### =
openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; &quot;$conf&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i&#39;=
&#39; -e &quot;\%### openvpn ${dev} begin ###%,\%### openvpn ${dev} end ###=
%d&quot; &quot;$conf&quot;</span><br><span>     ;;</span><br><span> esac</s=
pan><br><span>diff --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distr=
o/dns-scripts/macos-dns-updown=2Esh</span><br><span>index fccc6b5=2E=2E713a=
c1b 100644</span><br><span>--- a/distro/dns-scripts/macos-dns-updown=2Esh</=
span><br><span>+++ b/distro/dns-scripts/macos-dns-updown=2Esh</span><br><sp=
an>@@ -43,7 +43,42 @@</span><br><span> done</span><br><span> trap &quot;/bi=
n/rm -f ${lockfile}&quot; EXIT</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] || =2E &quot=
;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Read the variables that openvpn wrote to $dns_vars_file as data=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# The file is delibera=
tely NOT sourced: values may originate from options</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# pushed by the server, and the file is w=
ritten by the unprivileged</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# openvpn process, so sourcing it would execute shell syntax contain=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in a value (com=
mand substitution, quotes, redirections)=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dns_vars_load() {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    [ -r &quot;$_f&quot; ] || exit 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    while IFS=3D read -r _line || [ -n &quot=
;$_line&quot; ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case $_line in</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            *=3D*) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *) continue ;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        _name=3D${_line%%=3D*}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        _value=3D${_line#*=3D}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case $_name in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            dns_server_* | dns_search_domain_=
* | script_type) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             # dev is used in sed expressions and as a command argument:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                # only=
 accept interface name characters (&quot;/&quot; for Haiku tun/N)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                case $_value =
in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        echo &quot;invali=
d dev name in ${_f}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        exit 1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        ;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                esac</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            *) continue ;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        esac</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        case $_name in</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            *[!A-Za-z0-9_]*) continue ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        eval &quot;$_name=3D\&quot=
;\$_value\&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    done &lt; &quot;$_f&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+[ -z =
&quot;${dns_vars_file}&quot; ] || dns_vars_load &quot;${dns_vars_file}&quot=
;</span><br><span> </span><br><span> itf_dns_key=3D&quot;State:/Network/Ser=
vice/openvpn-${dev}/DNS&quot;</span><br><span> </span><br><span>diff --git =
a/distro/dns-scripts/openresolv-dns-updown=2Esh b/distro/dns-scripts/openre=
solv-dns-updown=2Esh</span><br><span>index 4aca99f=2E=2E299440b 100644</spa=
n><br><span>--- a/distro/dns-scripts/openresolv-dns-updown=2Esh</span><br><=
span>+++ b/distro/dns-scripts/openresolv-dns-updown=2Esh</span><br><span>@@=
 -42,7 +42,42 @@</span><br><span>     done</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_=
vars_file}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# Read the variables that openvpn wrote =
to $dns_vars_file as data=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# The file is deliberately NOT sourced: values may originate from =
options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# pushed by =
the server, and the file is written by the unprivileged</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# openvpn process, so sourcing it would=
 execute shell syntax contained</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# in a value (command substitution, quotes, redirections)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_vars_load() {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    _f=3D$1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot;$_f&quot; ] || ex=
it 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while IFS=
=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case $_line in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            *) continue ;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        esac</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_line%%=3D*}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        _value=3D${_line#*=
=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_=
name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
dns_server_* | dns_search_domain_* | script_type) ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dev)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                # dev is used in sed express=
ions and as a command argument:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                # only accept interface name characters (&quot;=
/&quot; for Haiku tun/N)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                case $_value in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* |=
 *=2E=2E*)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               echo &quot;invalid dev name in ${_f}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        exit 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        ;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                esa=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) cont=
inue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_name=
 in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *[!A=
-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] || dns_vars_=
load &quot;${dns_vars_file}&quot;</span><br><span> : ${script_type:=3Ddns-d=
own}</span><br><span> case &quot;${script_type}&quot; in</span><br><span> d=
ns-up)</span><br><span>diff --git a/distro/dns-scripts/resolvconf_file-dns-=
updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br>=
<span>index 8d23ed6=2E=2Ef41fe27 100644</span><br><span>--- a/distro/dns-sc=
ripts/resolvconf_file-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scri=
pts/resolvconf_file-dns-updown=2Esh</span><br><span>@@ -43,7 +43,42 @@</spa=
n><br><span> </span><br><span> conf=3D/etc/resolv=2Econf</span><br><span> t=
est -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_f=
ile}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read th=
e variables that openvpn wrote to $dns_vars_file as data=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# The file is deliberately NOT sour=
ced: values may originate from options</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# pushed by the server, and the file is written by the u=
nprivileged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# openvp=
n process, so sourcing it would execute shell syntax contained</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# in a value (command substituti=
on, quotes, redirections)=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dns_vars_load() {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   [ -r &quot;$_f&quot; ] || exit 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]=
; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_=
line in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
*=3D*) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _n=
ame=3D${_line%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        _value=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case $_name in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            dns_server_* | dns_search_domain_* | script_type=
) ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dev=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                # =
dev is used in sed expressions and as a command argument:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                # only accept interfa=
ce name characters (&quot;/&quot; for Haiku tun/N)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                case $_value in</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    [!A-Za-z0-9]=
* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        echo &quot;invalid dev name in ${_=
f}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        ;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                esac</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                ;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            *) continue ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case $_name in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        esac</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; =
&quot;$_f&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_va=
rs_file}&quot; || dns_vars_load &quot;${dns_vars_file}&quot;</span><br><spa=
n> case &quot;${script_type}&quot; in</span><br><span> dns-up)</span><br><s=
pan>     n=3D1</span><br><span>@@ -75,7 +110,8 @@</span><br><span> </span><=
br><span>     test -z &quot;$dns_search_domain_1&quot; || {</span><br><span=
>         for i in $(seq 1 6); do</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            eval domains=3D\&quot;$domains\$dns_search_domain_$=
{i} \&quot; || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            eval d=3D\&quot;\$dns_search_domain_${i}\&quot; || break</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            domains=3D&qu=
ot;$domains$d &quot;</span><br><span>         done</span><br><span>        =
 text=3D&quot;${text}search $domains\n&quot;</span><br><span>     }</span><=
br><span>@@ -85,6 +121,6 @@</span><br><span>     echo &quot;${text}&quot; &=
gt; &quot;${conf}&quot;</span><br><span>     ;;</span><br><span> dns-down)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sed -i&#39;&#39; -=
e &quot;/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; =
&quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sed -i&#39;&#39; -e &quot;\%### openvpn ${dev} begin ###%,\%### openvpn $=
{dev} end ###%d&quot; &quot;$conf&quot;</span><br><span>     ;;</span><br><=
span> esac</span><br><span>diff --git a/distro/dns-scripts/systemd-dns-updo=
wn=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh</span><br><span>index =
553056b=2E=2Ecb02b89 100644</span><br><span>--- a/distro/dns-scripts/system=
d-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/systemd-dns-updo=
wn=2Esh</span><br><span>@@ -34,7 +34,42 @@</span><br><span> #   dns_server_=
1_sni dns=2Emycorp=2Ein</span><br><span> #</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] =
|| =2E &quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Read the variables that openvpn wrote to $dns_vars_file a=
s data=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The file=
 is deliberately NOT sourced: values may originate from options</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# pushed by the server, and the=
 file is written by the unprivileged</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# openvpn process, so sourcing it would execute shell synt=
ax contained</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in a =
value (command substitution, quotes, redirections)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dns_vars_load() {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    _f=3D$1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    [ -r &quot;$_f&quot; ] || exit 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    while IFS=3D read -r _line |=
| [ -n &quot;$_line&quot; ]; do</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case $_line in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            *=3D*) ;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            *) continue ;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        _name=3D${_line%%=3D*}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        _value=3D${_line#*=3D}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case $_name in</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            dns_server_* | dns_se=
arch_domain_* | script_type) ;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            dev)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                # dev is used in sed expressions and as a command =
argument:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      # only accept interface name characters (&quot;/&quot; for Haiku tun/=
N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
ase $_value in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        echo &q=
uot;invalid dev name in ${_f}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        exit 1</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                esac</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *) continue ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        esac</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case $_name in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            *[!A-Za-z0-9_]*) continue =
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval &quot;$_nam=
e=3D\&quot;\$_value\&quot;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    done &lt; &quot;$_f&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+[ -z &quot;${dns_vars_file}&quot; ] || dns_vars_load &quot;${dns_vars_=
file}&quot;</span><br><span> </span><br><span> function do_resolved_servers=
 {</span><br><span>     local sni=3D&quot;&quot;</span><br><span>@@ -227,7 =
+262,8 @@</span><br><span> </span><br><span>         test -z &quot;$dns_sea=
rch_domain_1&quot; || {</span><br><span>             for i in $(seq 1 6); d=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                eval=
 domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                eval d=3D\&=
quot;\$dns_search_domain_${i}\&quot; || break</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                domains=3D&quot;$domains$d &quot;=
</span><br><span>             done</span><br><span>             text=3D&quo=
t;${text}search $domains\n&quot;</span><br><span>         }</span><br><span=
>@@ -236,7 +272,7 @@</span><br><span>         sed -i &quot;1i${text}&quot; =
&quot;$conf&quot;</span><br><span>     else</span><br><span>         echo &=
quot;unsetting DNS using resolv=2Econf file&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        sed -i &quot;/### openvpn ${dev} begin =
###/,/### openvpn ${dev} end ###/d&quot; &quot;$conf&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        sed -i &quot;\%### openvpn $=
{dev} begin ###%,\%### openvpn ${dev} end ###%d&quot; &quot;$conf&quot;</sp=
an><br><span>     fi</span><br><span> </span><br><span>     return 0</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f4=
2d4371 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2341 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: De=
ri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7HAmGtA4vzE=--


--===============2345480319380237318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2345480319380237318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2345480319380237318==--

