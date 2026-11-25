Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BA606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OXAfZrSQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DJXDm+9A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DukiTNU8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FiEqYqU+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=l9Ds6sGniDfo0UGp+UrLJy0OGn+7jH1j6V6zhbUg/R4=; b=OXAfZrSQ+lqOnAEY/1tvke5jhP
	9AlFUFPRs/TfVX4u4Vwb2JvTZUlvoxbTHq3MpcgLM98A10R1cqVqQxmgOYYE7nakWywxpw4DMWZ1u
	IxkFe3AkSMGSyi0nZeJbcJ2mJR6brtHZQPhhVJ8Fp02E+oXJRPA/KI3xgq2nNklNCEUM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWAyS-000000008Qm-2Nhm;
	Wed, 25 Nov 2026 11:15:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWAyQ-000000008QT-1D3D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P5KPeiEHEjhHMAMQkC++FIsXWDT067OkYmHsEEnClTA=; b=DJXDm+9AuTRm+z+iFSMH5zT16Q
 RWzybro8HRK8UkHWh5jMOS+UBw7x2tYYvfLoyj/T5aO2Urg8PducOOvbrk1Pas9PYBp2oUs9xIyMK
 R5ZjJE7v+V6P08VG6f4pV8Rnd4qB8pJXQ+hYhUYWiqsnCCCe4Tyk0E9VHu3x5OhkzQwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P5KPeiEHEjhHMAMQkC++FIsXWDT067OkYmHsEEnClTA=; b=DukiTNU8ZUf8BUU9blMfKIKhmw
 boNhYN6IEbdaGxtOSKzOYfjMI8pQBfTG8lcTu3sfYAjDlFCZ28z9lJuo5+5iN2ZfzdKxfdqFZ5+40
 nfl9j4hanqJ+rZ2IxpvvtxfADTJmbliTKTh1qIrEycGb+E9AvDm7CBG3vp1gACzbCxfo=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWAyN-000000008H3-084d for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:15:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so3862049f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795605328; x=1796210128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P5KPeiEHEjhHMAMQkC++FIsXWDT067OkYmHsEEnClTA=;
 b=FiEqYqU+uSmgv6pA+fqeI6aqkXP1Bzi8wVY2aIVjRaWAIN9bCWMDetLD/nJbtRlOoR
 QGvFVc99G4xTioDUq48itGhk5KkjQQBTK9vYCOrQaqzWuELJGXqSaBYJuWRCo5TzoHb1
 aHlZig+maqgdLhAH2Tyay1/+3GOqIE/PmP3q+NDsvTi/S0OwjuAPzRihmQezgO1d9tlv
 k0Hx4x41qFVuOM4CV40H4HZNJKeK8keTLQsL0oB0qL8agUVj36FhHnSdW//Sey5fU8VT
 uD5R7N3C66CO/YsAGvxyoLHMwApOASNYWPQveOZPbb3X7h0y17u0ZzNMcoExDfW4PsHW
 /VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605328; x=1796210128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P5KPeiEHEjhHMAMQkC++FIsXWDT067OkYmHsEEnClTA=;
 b=o1AnU9il3aRNxqM8zRt8NPfzodNJUmOQNc3lkadpECzJWhpCcR99HU27IPNryA2xtQ
 eIapdNIVGn8geCoPGPALAAQGbkObkiT/W1rHRM1cbu/FEOkoYXXxaiBpzJxb9R2nMYYp
 3DiAv2cMx3s/xWEHsd0QOUy03+6IKqOGZ/OpcFkM18jItuV8/1409DDlTnlwhU2zHVKH
 6V8HFu3cvMEwVlcdetvl9F0OLjsuMe8fxQ7NXyOGXHkV+ZFfp2lpQODVEkDpdnQpMC4q
 1K/zs08tGAMPhfZhAqBQarzmCNtEVosPPKvHtFLHN5dWPHnuJFP8a+cxoyziKe3de6wr
 VGyg==
X-Gm-Message-State: APuU4Z9CqkYpo5nvbIotrJKzhqgUrQTxbScJUtTmKb4uRbEuTFamUYHl
 TMt8iebL3K73hBYYOlF4B9Gl5bubu4fYz3Y0IvYIuh3UWo+1DTjUJcXHFRcSwXw5kxc0DbY2Mh2
 0Y4X6EerHVUc9XGCDp9E9ruCW+Wg0Ytf2GWanviFE2+2jWXhffVMYJ8gSogrcnlwTrlSH
X-Gm-Gg: AZFdTZcOmXOhh2Zf3URBZBDMAGYxiy7NupELt0J/CZODIv+/jDj/Gcsbex8csO2w3L2
 AuHmHPgf8p5yXhnpj2wutz3YaSC/+CcuxKKBG1IcvM3QvEB88M2iPpFBQBGyt3KoLMzeXqIUnqc
 qYQSg0duQ8bLsT/v13Vnvlh8AI842zN+1IaHroqTyyGiJAID2asLgDno2vUV/2r+aen1JTQLhBy
 D1E1PvfnJMwCdjZl2ZR6f/zNKdOnUQ/o/ZzmAGPpTi0IuICeg0n1fL4xOyze+K2DSiFQcRSzxLO
 H6dLGvyO1k+3tkmY7w61Dp6F1lsJTpF4sg2OmxIPVJ6mvRz7f4uIgTKv/FkgI3uTubQrStYOsI5
 M9e3m5VJFJdEFjubYR9O22MT1gUVInzvo/bq7RVAdiKsP4s5hlpLQlXPWdn8mLyHk4mv4ZY/xbW
 HSrimZ7hDpPr2morISmlrQGGR8j2s2tRqzXYEPRkFmZZY6sbcj2VoMlsPUJw9SonQHtX9SsnOfP
 KwxSjty64xdn+ERnKbCPSX9ofptDAfazJbJ8c7tVqmmdkf9GvGrvcY0b9dMoonLiUVGLK5XjDls
 8My2VEUyqCUh/4H2Y8CVJf0I8eWdCNOfsiUdJDFCpZLVPhq/MHd9L9n1y6peFoSQUeFbxRWcWYb
 JDZ5buGj5mRDw/zusOHjXOgRUYtXAO88ySTzEwY0iZRV0BIjst9h2uTWJ9l88pzy4dJVBIyXwbE
 xu+8wSpDat3gzqOuQ=
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb88807d7cmr334685605e9.9.1795605328074; 
 Wed, 25 Nov 2026 03:15:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm571037215e9.10.2026.11.25.03.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:15:27 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 11:15:26 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <49718230e0ab82dd11ce79e82ee4b3d5e22de9fb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWAyN-000000008H3-084d
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
Content-Type: multipart/mixed; boundary="===============3207231344618027061=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3207231344618027061==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ii7LEXNbfj8="; charset=UTF-8

--ii7LEXNbfj8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to=
 reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2341?usp=3Demail

to look at the new patch set (#3)=2E

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
 Those sed calls now
use \%regex% addresses, and the reader rejects a dev v=
alue containing
'%' or '\', so dev cannot end the address and is only ever =
matched as a
regular expression=2E The reader also rejects a dev starting w=
ith '-'
(it is passed as an argument to resolvconf and resolvectl) or conta=
ining
"=2E=2E" (resolvconf names a file after it)=2E Any other interface na=
me is
accepted, including '/' (Haiku names its devices tun/N)=2E

If the fi=
le cannot be read, the reader now prints an error and exits
instead of lett=
ing the script carry on with nothing set=2E With "=2E file"
the /bin/sh scr=
ipts stopped there as well=2E

This addresses (b) only as far as the script=
s are concerned: root no
longer executes the file, and dev can no longer in=
ject sed commands=2E It
does not make the file trusted input=2E The C side =
still trusts the path
it receives from the unprivileged process, and the va=
lues are still
handed to resolv=2Econf, resolvectl, resolvconf and scutil a=
s DNS
configuration, as before=2E

Valid values give the same result as bef=
ore, except for the "search"
line that the resolvconf_file, haikuos_file an=
d systemd scripts write to
resolv=2Econf: the domains are now separated by =
single blanks with no
trailing blank (the old loop left one or two), and th=
e list stops at the
first empty dns_search_domain_N=2E openvpn numbers the =
search domains
without gaps, so the latter only matters for hand-written fi=
les=2E The
rest of resolv=2Econf and the resolvectl and resolvconf argument=
s were
compared before and after the change and are identical=2E

Change-Id=
: Id05f3e4e32aeb806d762858e754adc82f42d4371
Signed-off-by: Deri Haerudi <Ab=
cderyscreenprinting@gmail=2Ecom>
---
M distro/dns-scripts/haikuos_file-dns-=
updown=2Esh
M distro/dns-scripts/macos-dns-updown=2Esh
M distro/dns-scripts=
/openresolv-dns-updown=2Esh
M distro/dns-scripts/resolvconf_file-dns-updown=
=2Esh
M distro/dns-scripts/systemd-dns-updown=2Esh
5 files changed, 207 ins=
ertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/41/2341/3

diff --git a/distro/dns-scripts/haikuos_fi=
le-dns-updown=2Esh b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
index =
e19b2b7=2E=2E7ca270b 100644
--- a/distro/dns-scripts/haikuos_file-dns-updow=
n=2Esh
+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
@@ -43,7 +43,4=
5 @@
 
 conf=3D/boot/system/settings/network/resolv=2Econf
 test -e "$conf"=
 || exit 1
-test -z "${dns_vars_file}" || =2E "${dns_vars_file}"
+# Read th=
e variables that openvpn wrote to $dns_vars_file as data=2E
+# The file is =
deliberately NOT sourced: values may originate from options
+# pushed by th=
e server, and the file is written by the unprivileged
+# openvpn process, s=
o sourcing it would execute shell syntax contained
+# in a value (command s=
ubstitution, quotes, redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+    =
[ -r "$_f" ] || {
+        echo "cannot read dns vars file ${_f}"
+        =
exit 1
+    }
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+     =
   case $_line in
+            *=3D*) ;;
+            *) continue ;;
+     =
   esac
+        _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+  =
      case $_name in
+            dns_server_* | dns_search_domain_* | scri=
pt_type) ;;
+            dev)
+                # Reject what could end a \%=
re% sed address (% and \),
+                # pass as a command option (lea=
ding -) or walk up a path (=2E=2E)
+                case $_value in
+      =
              -* | *%* | *\\* | *=2E=2E*)
+                        echo "in=
valid dev name in ${_f}"
+                        exit 1
+                 =
       ;;
+                esac
+                ;;
+            *) continu=
e ;;
+        esac
+        case $_name in
+            *[!A-Za-z0-9_]*) co=
ntinue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+    done < "=
$_f"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${dns_vars_file}"
 ca=
se "${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +113,9 @@
 
     test -=
z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-           =
 eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+           =
 eval d=3D\"\$dns_search_domain_${i}\"
+            [ -n "$d" ] || break
+ =
           domains=3D"${domains:+$domains }$d"
         done
         text=
=3D"${text}search $domains\n"
     }
@@ -85,6 +125,6 @@
     echo "${text}"=
 > "${conf}"
     ;;
 dns-down)
-    sed -i'' -e "/### openvpn ${dev} begin=
 ###/,/### openvpn ${dev} end ###/d" "$conf"
+    sed -i'' -e "\%### openvp=
n ${dev} begin ###%,\%### openvpn ${dev} end ###%d" "$conf"
     ;;
 esac
d=
iff --git a/distro/dns-scripts/macos-dns-updown=2Esh b/distro/dns-scripts/m=
acos-dns-updown=2Esh
index fccc6b5=2E=2E38f91d2 100644
--- a/distro/dns-scr=
ipts/macos-dns-updown=2Esh
+++ b/distro/dns-scripts/macos-dns-updown=2Esh
@=
@ -43,7 +43,45 @@
 done
 trap "/bin/rm -f ${lockfile}" EXIT
 
-[ -z "${dns_=
vars_file}" ] || =2E "${dns_vars_file}"
+# Read the variables that openvpn =
wrote to $dns_vars_file as data=2E
+# The file is deliberately NOT sourced:=
 values may originate from options
+# pushed by the server, and the file is=
 written by the unprivileged
+# openvpn process, so sourcing it would execu=
te shell syntax contained
+# in a value (command substitution, quotes, redi=
rections)=2E
+dns_vars_load() {
+    _f=3D$1
+    [ -r "$_f" ] || {
+      =
  echo "cannot read dns vars file ${_f}"
+        exit 1
+    }
+    while =
IFS=3D read -r _line || [ -n "$_line" ]; do
+        case $_line in
+      =
      *=3D*) ;;
+            *) continue ;;
+        esac
+        _name=3D=
${_line%%=3D*}
+        _value=3D${_line#*=3D}
+        case $_name in
+   =
         dns_server_* | dns_search_domain_* | script_type) ;;
+            =
dev)
+                # Reject what could end a \%re% sed address (% and \)=
,
+                # pass as a command option (leading -) or walk up a path=
 (=2E=2E)
+                case $_value in
+                    -* | *%* | =
*\\* | *=2E=2E*)
+                        echo "invalid dev name in ${_f}"
=
+                        exit 1
+                        ;;
+              =
  esac
+                ;;
+            *) continue ;;
+        esac
+     =
   case $_name in
+            *[!A-Za-z0-9_]*) continue ;;
+        esac
+=
        eval "$_name=3D\"\$_value\""
+    done < "$_f"
+}
+[ -z "${dns_vars=
_file}" ] || dns_vars_load "${dns_vars_file}"
 
 itf_dns_key=3D"State:/Netw=
ork/Service/openvpn-${dev}/DNS"
 
diff --git a/distro/dns-scripts/openresol=
v-dns-updown=2Esh b/distro/dns-scripts/openresolv-dns-updown=2Esh
index 4ac=
a99f=2E=2Eee26480 100644
--- a/distro/dns-scripts/openresolv-dns-updown=2Es=
h
+++ b/distro/dns-scripts/openresolv-dns-updown=2Esh
@@ -42,7 +42,45 @@
  =
   done
 }
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
+# Read t=
he variables that openvpn wrote to $dns_vars_file as data=2E
+# The file is=
 deliberately NOT sourced: values may originate from options
+# pushed by t=
he server, and the file is written by the unprivileged
+# openvpn process, =
so sourcing it would execute shell syntax contained
+# in a value (command =
substitution, quotes, redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+   =
 [ -r "$_f" ] || {
+        echo "cannot read dns vars file ${_f}"
+       =
 exit 1
+    }
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+    =
    case $_line in
+            *=3D*) ;;
+            *) continue ;;
+    =
    esac
+        _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+ =
       case $_name in
+            dns_server_* | dns_search_domain_* | scr=
ipt_type) ;;
+            dev)
+                # Reject what could end a \=
%re% sed address (% and \),
+                # pass as a command option (le=
ading -) or walk up a path (=2E=2E)
+                case $_value in
+     =
               -* | *%* | *\\* | *=2E=2E*)
+                        echo "i=
nvalid dev name in ${_f}"
+                        exit 1
+                =
        ;;
+                esac
+                ;;
+            *) contin=
ue ;;
+        esac
+        case $_name in
+            *[!A-Za-z0-9_]*) c=
ontinue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+    done < =
"$_f"
+}
+[ -z "${dns_vars_file}" ] || dns_vars_load "${dns_vars_file}"
 : =
${script_type:=3Ddns-down}
 case "${script_type}" in
 dns-up)
diff --git a/=
distro/dns-scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/res=
olvconf_file-dns-updown=2Esh
index 8d23ed6=2E=2E2686b79 100644
--- a/distro=
/dns-scripts/resolvconf_file-dns-updown=2Esh
+++ b/distro/dns-scripts/resol=
vconf_file-dns-updown=2Esh
@@ -43,7 +43,45 @@
 
 conf=3D/etc/resolv=2Econf
=
 test -e "$conf" || exit 1
-test -z "${dns_vars_file}" || =2E "${dns_vars_f=
ile}"
+# Read the variables that openvpn wrote to $dns_vars_file as data=2E=

+# The file is deliberately NOT sourced: values may originate from options=

+# pushed by the server, and the file is written by the unprivileged
+# op=
envpn process, so sourcing it would execute shell syntax contained
+# in a =
value (command substitution, quotes, redirections)=2E
+dns_vars_load() {
+ =
   _f=3D$1
+    [ -r "$_f" ] || {
+        echo "cannot read dns vars file =
${_f}"
+        exit 1
+    }
+    while IFS=3D read -r _line || [ -n "$_li=
ne" ]; do
+        case $_line in
+            *=3D*) ;;
+            *) co=
ntinue ;;
+        esac
+        _name=3D${_line%%=3D*}
+        _value=3D$=
{_line#*=3D}
+        case $_name in
+            dns_server_* | dns_search=
_domain_* | script_type) ;;
+            dev)
+                # Reject wha=
t could end a \%re% sed address (% and \),
+                # pass as a com=
mand option (leading -) or walk up a path (=2E=2E)
+                case $_=
value in
+                    -* | *%* | *\\* | *=2E=2E*)
+                =
        echo "invalid dev name in ${_f}"
+                        exit 1
+ =
                       ;;
+                esac
+                ;;
+      =
      *) continue ;;
+        esac
+        case $_name in
+            *[!=
A-Za-z0-9_]*) continue ;;
+        esac
+        eval "$_name=3D\"\$_value\=
""
+    done < "$_f"
+}
+test -z "${dns_vars_file}" || dns_vars_load "${dns=
_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
@@ -75,7 +113,9 =
@@
 
     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6);=
 do
-            eval domains=3D\"$domains\$dns_search_domain_${i} \" || br=
eak
+            eval d=3D\"\$dns_search_domain_${i}\"
+            [ -n "$=
d" ] || break
+            domains=3D"${domains:+$domains }$d"
         don=
e
         text=3D"${text}search $domains\n"
     }
@@ -85,6 +125,6 @@
    =
 echo "${text}" > "${conf}"
     ;;
 dns-down)
-    sed -i'' -e "/### openv=
pn ${dev} begin ###/,/### openvpn ${dev} end ###/d" "$conf"
+    sed -i'' -=
e "\%### openvpn ${dev} begin ###%,\%### openvpn ${dev} end ###%d" "$conf"
=
     ;;
 esac
diff --git a/distro/dns-scripts/systemd-dns-updown=2Esh b/dis=
tro/dns-scripts/systemd-dns-updown=2Esh
index 553056b=2E=2Ebfc1a1e 100644
-=
-- a/distro/dns-scripts/systemd-dns-updown=2Esh
+++ b/distro/dns-scripts/sy=
stemd-dns-updown=2Esh
@@ -34,7 +34,45 @@
 #   dns_server_1_sni dns=2Emycorp=
=2Ein
 #
 
-[ -z "${dns_vars_file}" ] || =2E "${dns_vars_file}"
+# Read the=
 variables that openvpn wrote to $dns_vars_file as data=2E
+# The file is d=
eliberately NOT sourced: values may originate from options
+# pushed by the=
 server, and the file is written by the unprivileged
+# openvpn process, so=
 sourcing it would execute shell syntax contained
+# in a value (command su=
bstitution, quotes, redirections)=2E
+dns_vars_load() {
+    _f=3D$1
+    [=
 -r "$_f" ] || {
+        echo "cannot read dns vars file ${_f}"
+        e=
xit 1
+    }
+    while IFS=3D read -r _line || [ -n "$_line" ]; do
+      =
  case $_line in
+            *=3D*) ;;
+            *) continue ;;
+      =
  esac
+        _name=3D${_line%%=3D*}
+        _value=3D${_line#*=3D}
+   =
     case $_name in
+            dns_server_* | dns_search_domain_* | scrip=
t_type) ;;
+            dev)
+                # Reject what could end a \%r=
e% sed address (% and \),
+                # pass as a command option (lead=
ing -) or walk up a path (=2E=2E)
+                case $_value in
+       =
             -* | *%* | *\\* | *=2E=2E*)
+                        echo "inv=
alid dev name in ${_f}"
+                        exit 1
+                  =
      ;;
+                esac
+                ;;
+            *) continue=
 ;;
+        esac
+        case $_name in
+            *[!A-Za-z0-9_]*) con=
tinue ;;
+        esac
+        eval "$_name=3D\"\$_value\""
+    done < "$=
_f"
+}
+[ -z "${dns_vars_file}" ] || dns_vars_load "${dns_vars_file}"
 
 fu=
nction do_resolved_servers {
     local sni=3D""
@@ -227,7 +265,9 @@
 
    =
     test -z "$dns_search_domain_1" || {
             for i in $(seq 1 6); =
do
-                eval domains=3D\"$domains\$dns_search_domain_${i} \" ||=
 break
+                eval d=3D\"\$dns_search_domain_${i}\"
+            =
    [ -n "$d" ] || break
+                domains=3D"${domains:+$domains }$=
d"
             done
             text=3D"${text}search $domains\n"
       =
  }
@@ -236,7 +276,7 @@
         sed -i "1i${text}" "$conf"
     else
     =
    echo "unsetting DNS using resolv=2Econf file"
-        sed -i "/### ope=
nvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" "$conf"
+        sed =
-i "\%### openvpn ${dev} begin ###%,\%### openvpn ${dev} end ###%d" "$conf"=

     fi
 
     return 0

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2341?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
Gerrit-Change-Number: 2=
341
Gerrit-PatchSet: 3
Gerrit-Owner: Deri Haerudi <abcderyscreenprinting@gm=
ail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Deri Hae=
rudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>

--ii7LEXNbfj8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Deri Haerudi <strong>uploaded patch set #3</strong> to this change=
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
wn code of the<br>resolvconf_file, haikuos_file and systemd scripts=2E Thos=
e sed calls now<br>use \%regex% addresses, and the reader rejects a dev val=
ue containing<br>&#39;%&#39; or &#39;\&#39;, so dev cannot end the address =
and is only ever matched as a<br>regular expression=2E The reader also reje=
cts a dev starting with &#39;-&#39;<br>(it is passed as an argument to reso=
lvconf and resolvectl) or containing<br>&quot;=2E=2E&quot; (resolvconf name=
s a file after it)=2E Any other interface name is<br>accepted, including &#=
39;/&#39; (Haiku names its devices tun/N)=2E<br><br>If the file cannot be r=
ead, the reader now prints an error and exits<br>instead of letting the scr=
ipt carry on with nothing set=2E With &quot;=2E file&quot;<br>the /bin/sh s=
cripts stopped there as well=2E<br><br>This addresses (b) only as far as th=
e scripts are concerned: root no<br>longer executes the file, and dev can n=
o longer inject sed commands=2E It<br>does not make the file trusted input=
=2E The C side still trusts the path<br>it receives from the unprivileged p=
rocess, and the values are still<br>handed to resolv=2Econf, resolvectl, re=
solvconf and scutil as DNS<br>configuration, as before=2E<br><br>Valid valu=
es give the same result as before, except for the &quot;search&quot;<br>lin=
e that the resolvconf_file, haikuos_file and systemd scripts write to<br>re=
solv=2Econf: the domains are now separated by single blanks with no<br>trai=
ling blank (the old loop left one or two), and the list stops at the<br>fir=
st empty dns_search_domain_N=2E openvpn numbers the search domains<br>witho=
ut gaps, so the latter only matters for hand-written files=2E The<br>rest o=
f resolv=2Econf and the resolvectl and resolvconf arguments were<br>compare=
d before and after the change and are identical=2E<br><br>Change-Id: Id05f3=
e4e32aeb806d762858e754adc82f42d4371<br>Signed-off-by: Deri Haerudi &lt;Abcd=
eryscreenprinting@gmail=2Ecom&gt;<br>---<br>M distro/dns-scripts/haikuos_fi=
le-dns-updown=2Esh<br>M distro/dns-scripts/macos-dns-updown=2Esh<br>M distr=
o/dns-scripts/openresolv-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf=
_file-dns-updown=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>5 =
files changed, 207 insertions(+), 11 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/234=
1/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/=
distro/dns-scripts/haikuos_file-dns-updown=2Esh</span><br><span>index e19b2=
b7=2E=2E7ca270b 100644</span><br><span>--- a/distro/dns-scripts/haikuos_fil=
e-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns=
-updown=2Esh</span><br><span>@@ -43,7 +43,45 @@</span><br><span> </span><br=
><span> conf=3D/boot/system/settings/network/resolv=2Econf</span><br><span>=
 test -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-test -z &quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars=
_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Read =
the variables that openvpn wrote to $dns_vars_file as data=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# The file is deliberately NOT so=
urced: values may originate from options</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# pushed by the server, and the file is written by the=
 unprivileged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# open=
vpn process, so sourcing it would execute shell syntax contained</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# in a value (command substitu=
tion, quotes, redirections)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dns_vars_load() {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [ -r &quot;$_f&quot; ] || {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        echo &quot;cannot read dns vars file ${_f}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
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
             # Reject what could end a \%re% sed address (% and \),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                # pass as a=
 command option (leading -) or walk up a path (=2E=2E)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                case $_value in</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    -* | *%*=
 | *\\* | *=2E=2E*)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        echo &quot;invalid dev name in ${_f}&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        exit=
 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}&quot; ||=
 dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> case &quot;${s=
cript_type}&quot; in</span><br><span> dns-up)</span><br><span>     n=3D1</s=
pan><br><span>@@ -75,7 +113,9 @@</span><br><span> </span><br><span>     tes=
t -z &quot;$dns_search_domain_1&quot; || {</span><br><span>         for i i=
n $(seq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || br=
eak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval=
 d=3D\&quot;\$dns_search_domain_${i}\&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            [ -n &quot;$d&quot; ] || break</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            domains=3D&quot;=
${domains:+$domains }$d&quot;</span><br><span>         done</span><br><span=
>         text=3D&quot;${text}search $domains\n&quot;</span><br><span>     =
}</span><br><span>@@ -85,6 +125,6 @@</span><br><span>     echo &quot;${text=
}&quot; &gt; &quot;${conf}&quot;</span><br><span>     ;;</span><br><span> d=
ns-down)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sed -i&#3=
9;&#39; -e &quot;/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###=
/d&quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sed -i&#39;&#39; -e &quot;\%### openvpn ${dev} begin ###%,\%### =
openvpn ${dev} end ###%d&quot; &quot;$conf&quot;</span><br><span>     ;;</s=
pan><br><span> esac</span><br><span>diff --git a/distro/dns-scripts/macos-d=
ns-updown=2Esh b/distro/dns-scripts/macos-dns-updown=2Esh</span><br><span>i=
ndex fccc6b5=2E=2E38f91d2 100644</span><br><span>--- a/distro/dns-scripts/m=
acos-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/macos-dns-upd=
own=2Esh</span><br><span>@@ -43,7 +43,45 @@</span><br><span> done</span><br=
><span> trap &quot;/bin/rm -f ${lockfile}&quot; EXIT</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file=
}&quot; ] || =2E &quot;${dns_vars_file}&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# Read the variables that openvpn wrote to $dns_v=
ars_file as data=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# The file is deliberately NOT sourced: values may originate from options</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# pushed by the serve=
r, and the file is written by the unprivileged</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# openvpn process, so sourcing it would execute =
shell syntax contained</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# in a value (command substitution, quotes, redirections)=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dns_vars_load() {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    _f=3D$1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot;$_f&quot; ] || {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;cannot rea=
d dns vars file ${_f}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while I=
FS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case $_line in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            *) continue ;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        esac</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_line%%=3D*}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        _value=3D${_line#=
*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $=
_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 dns_server_* | dns_search_domain_* | script_type) ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dev)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                # Reject what could end a \%=
re% sed address (% and \),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                # pass as a command option (leading -) or walk up a =
path (=2E=2E)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          case $_value in</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    -* | *%* | *\\* | *=2E=2E*)</span><br><span style=
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
solv-dns-updown=2Esh</span><br><span>index 4aca99f=2E=2Eee26480 100644</spa=
n><br><span>--- a/distro/dns-scripts/openresolv-dns-updown=2Esh</span><br><=
span>+++ b/distro/dns-scripts/openresolv-dns-updown=2Esh</span><br><span>@@=
 -42,7 +42,45 @@</span><br><span>     done</span><br><span> }</span><br><sp=
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
pan style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot;$_f&quot; ] || {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;c=
annot read dns vars file ${_f}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case $_line in</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            *) continue ;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_line%%=3D=
*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _value=3D=
${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         dns_server_* | dns_search_domain_* | script_type) ;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            dev)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                # Reject what could =
end a \%re% sed address (% and \),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                # pass as a command option (leading -) or wa=
lk up a path (=2E=2E)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                case $_value in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    -* | *%* | *\\* | *=2E=2E*)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        echo &quo=
t;invalid dev name in ${_f}&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        exit 1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        ;;</span><br><span style=
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
file}&quot;</span><br><span> : ${script_type:=3Ddns-down}</span><br><span> =
case &quot;${script_type}&quot; in</span><br><span> dns-up)</span><br><span=
>diff --git a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh b/distro/d=
ns-scripts/resolvconf_file-dns-updown=2Esh</span><br><span>index 8d23ed6=2E=
=2E2686b79 100644</span><br><span>--- a/distro/dns-scripts/resolvconf_file-=
dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/resolvconf_file-dn=
s-updown=2Esh</span><br><span>@@ -43,7 +43,45 @@</span><br><span> </span><b=
r><span> conf=3D/etc/resolv=2Econf</span><br><span> test -e &quot;$conf&quo=
t; || exit 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test -z &=
quot;${dns_vars_file}&quot; || =2E &quot;${dns_vars_file}&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# Read the variables that openv=
pn wrote to $dns_vars_file as data=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# The file is deliberately NOT sourced: values may origin=
ate from options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# p=
ushed by the server, and the file is written by the unprivileged</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# openvpn process, so sourcing=
 it would execute shell syntax contained</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# in a value (command substitution, quotes, redirectio=
ns)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_vars_load=
() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _f=3D$1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -r &quot;$_f&quot=
; ] || {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ech=
o &quot;cannot read dns vars file ${_f}&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while IFS=3D read -r _line || [ -n &quot;$_line&quot; ]; do</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case $_line in</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=3D*) ;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) cont=
inue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        esac=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _name=3D${_=
line%%=3D*}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
_value=3D${_line#*=3D}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            dns_server_* | dns_search_domain_* | script_type) ;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            dev)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                # Reject wh=
at could end a \%re% sed address (% and \),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                # pass as a command option (leading=
 -) or walk up a path (=2E=2E)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                case $_value in</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    -* | *%* | *\\* | *=2E=2E*)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
echo &quot;invalid dev name in ${_f}&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        exit 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                esac</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            *) continue ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        esac</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        case $_name in</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            *[!A-Za-z0-9_]*) co=
ntinue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        es=
ac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval &quo=
t;$_name=3D\&quot;\$_value\&quot;&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    done &lt; &quot;$_f&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test -z &quot;${dns_vars_file}&quot; || dns_vars_load &quot;${d=
ns_vars_file}&quot;</span><br><span> case &quot;${script_type}&quot; in</sp=
an><br><span> dns-up)</span><br><span>     n=3D1</span><br><span>@@ -75,7 +=
113,9 @@</span><br><span> </span><br><span>     test -z &quot;$dns_search_d=
omain_1&quot; || {</span><br><span>         for i in $(seq 1 6); do</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            eval domains=3D\&=
quot;$domains\$dns_search_domain_${i} \&quot; || break</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            eval d=3D\&quot;\$dns_search=
_domain_${i}\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            [ -n &quot;$d&quot; ] || break</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            domains=3D&quot;${domains:+$domains }$d&=
quot;</span><br><span>         done</span><br><span>         text=3D&quot;$=
{text}search $domains\n&quot;</span><br><span>     }</span><br><span>@@ -85=
,6 +125,6 @@</span><br><span>     echo &quot;${text}&quot; &gt; &quot;${con=
f}&quot;</span><br><span>     ;;</span><br><span> dns-down)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    sed -i&#39;&#39; -e &quot;/### op=
envpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; &quot;$conf&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i&#39;&#=
39; -e &quot;\%### openvpn ${dev} begin ###%,\%### openvpn ${dev} end ###%d=
&quot; &quot;$conf&quot;</span><br><span>     ;;</span><br><span> esac</spa=
n><br><span>diff --git a/distro/dns-scripts/systemd-dns-updown=2Esh b/distr=
o/dns-scripts/systemd-dns-updown=2Esh</span><br><span>index 553056b=2E=2Ebf=
c1a1e 100644</span><br><span>--- a/distro/dns-scripts/systemd-dns-updown=2E=
sh</span><br><span>+++ b/distro/dns-scripts/systemd-dns-updown=2Esh</span><=
br><span>@@ -34,7 +34,45 @@</span><br><span> #   dns_server_1_sni dns=2Emyc=
orp=2Ein</span><br><span> #</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-[ -z &quot;${dns_vars_file}&quot; ] || =2E &quot;${=
dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Read the variables that openvpn wrote to $dns_vars_file as data=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# The file is deliberatel=
y NOT sourced: values may originate from options</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# pushed by the server, and the file is writte=
n by the unprivileged</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# openvpn process, so sourcing it would execute shell syntax contained</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# in a value (command =
substitution, quotes, redirections)=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dns_vars_load() {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    _f=3D$1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    [ -r &quot;$_f&quot; ] || {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        echo &quot;cannot read dns vars file ${_f}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit 1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while IFS=3D read -r _line || [ =
-n &quot;$_line&quot; ]; do</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        case $_line in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            *=3D*) ;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            *) continue ;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        _name=3D${_line%%=3D*}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        _value=3D${_line#*=3D}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case $_name in</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            dns_server_* | dns_search=
_domain_* | script_type) ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            dev)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                # Reject what could end a \%re% sed address (% and \),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                # p=
ass as a command option (leading -) or walk up a path (=2E=2E)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                case $_value in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
-* | *%* | *\\* | *=2E=2E*)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        echo &quot;invalid dev name in ${_f}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          *) continue ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case $_name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            *[!A-Za-z0-9_]*) continue ;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        esac</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        eval &quot;$_name=3D\&quot;\$_value\&quot;&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    done &lt; &quot;$_f=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quo=
t; ] || dns_vars_load &quot;${dns_vars_file}&quot;</span><br><span> </span>=
<br><span> function do_resolved_servers {</span><br><span>     local sni=3D=
&quot;&quot;</span><br><span>@@ -227,7 +265,9 @@</span><br><span> </span><b=
r><span>         test -z &quot;$dns_search_domain_1&quot; || {</span><br><s=
pan>             for i in $(seq 1 6); do</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                eval domains=3D\&quot;$domains\$dns_sear=
ch_domain_${i} \&quot; || break</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                eval d=3D\&quot;\$dns_search_domain_${i}\&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                [ -=
n &quot;$d&quot; ] || break</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                domains=3D&quot;${domains:+$domains }$d&quot;</span=
><br><span>             done</span><br><span>             text=3D&quot;${te=
xt}search $domains\n&quot;</span><br><span>         }</span><br><span>@@ -2=
36,7 +276,7 @@</span><br><span>         sed -i &quot;1i${text}&quot; &quot;=
$conf&quot;</span><br><span>     else</span><br><span>         echo &quot;u=
nsetting DNS using resolv=2Econf file&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        sed -i &quot;/### openvpn ${dev} begin ###/,/=
### openvpn ${dev} end ###/d&quot; &quot;$conf&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sed -i &quot;\%### openvpn ${dev}=
 begin ###%,\%### openvpn ${dev} end ###%d&quot; &quot;$conf&quot;</span><b=
r><span>     fi</span><br><span> </span><br><span>     return 0</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Deri Hae=
rudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ii7LEXNbfj8=--


--===============3207231344618027061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3207231344618027061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3207231344618027061==--

