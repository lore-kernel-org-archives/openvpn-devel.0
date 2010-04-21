From: Davide Brini <dave_br@...1278...>
Date: Wed, 21 Apr 2010 16:51:41 +0100
References: <4BCF0259.8070902@...1347...>
In-Reply-To: <4BCF0259.8070902@...1347...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N8xzL2EtVcWquQO"
Message-Id: <201004211651.41873.dave_br@...1278...>
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
	script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_N8xzL2EtVcWquQO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wednesday 21 Apr 2010 14:49:13 Richard Monk wrote:

> I had an issue come up where the clients were getting DNS entries in the
> reverse order the server sends them when using the client.up contrib
> script.  Since the DNS servers on our system are in order from
> closest->farthest network wise from the VPN server, having them
> backwards caused some performance issues.
> 
> I've attached a patch that puts the DNS entries in the correct order
> that the server sends them.  Can this be updated in the next release?

Hi Richard,

as a matter of fact, there's a new version of that script (and client.down as 
well) in the git testing tree, which should fix your problem as it just uses 
the DNS servers in the order they're sent from the server. See here for more 
details:

http://article.gmane.org/gmane.network.openvpn.devel/3343

and try the attached patch (which is the same that has been merged).

-- 
D.

--Boundary-00=_N8xzL2EtVcWquQO
Content-Type: text/x-patch; charset="UTF-8";
	name="no_bashisms_for_client_up_down.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="no_bashisms_for_client_up_down.patch"

diff -burp openvpn-2.1.1/contrib/pull-resolv-conf/client.up openvpn-2.1.1-a/contrib/pull-resolv-conf/client.up
--- openvpn-2.1.1/contrib/pull-resolv-conf/client.up	2009-10-01 19:02:17.000000000 +0100
+++ openvpn-2.1.1-a/contrib/pull-resolv-conf/client.up	2010-03-11 21:32:03.000000000 +0000
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh

 # Copyright (c) 2005-2009 OpenVPN Technologies, Inc.
 # Licensed under the GPL version 2
@@ -14,7 +14,6 @@
 # Place this in /etc/openvpn/client.up
 # Then, add the following to your /etc/openvpn/<clientconfig>.conf:
 #   client
-#   pull dhcp-options
 #   up /etc/openvpn/client.up
 # Next, "chmod a+x /etc/openvpn/client.up"

@@ -22,8 +21,8 @@
 # Note that this script is best served with the companion "client.down"
 # script.

-# Only tested on Gentoo Linux 2005.0 with OpenVPN 2.0
-# It should work with any GNU/Linux with /etc/resolv.conf
+# Tested under Debian lenny with OpenVPN 2.1_rc11
+# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolvconf

 # This runs with the context of the OpenVPN UID/GID 
 # at the time of execution. This generally means that
@@ -38,38 +37,64 @@
 # init variables

 i=1
-j=1
-unset fopt
-unset dns
-unset opt
-
-# Convert ENVs to an array
-
-while fopt=foreign_option_$i; [ -n "${!fopt}" ]; do
-{
-	opt[i-1]=${!fopt}
-	case ${opt[i-1]} in
-		*DOMAIN* ) domain=`echo ${opt[i-1]} | \
-				sed -e 's/dhcp-option DOMAIN //g'` ;;
-		*DNS*    ) dns[j-1]=`echo ${opt[i-1]} | \
-				sed -e 's/dhcp-option DNS //g'`
-			       let j++ ;;
+domains=
+fopt=
+ndoms=0
+nns=0
+nl='
+'
+
+# $foreign_option_<n> is something like 
+# "dhcp-option DOMAIN example.com" (multiple allowed)
+# or
+# "dhcp-option DNS 10.10.10.10" (multiple allowed)
+
+# each DNS option becomes a "nameserver" option in resolv.con
+# if we get one DOMAIN, that becomes "domain" in resolv.conf
+# if we get multiple DOMAINS, those become "search" lines in resolv.conf
+
+while true; do
+  eval fopt=\$foreign_option_${i}
+  [ -z "${fopt}" ] && break
+  
+  case ${fopt} in
+		dhcp-option\ DOMAIN\ *)
+           ndoms=$((ndoms + 1))
+           domains="${domains} ${fopt#dhcp-option DOMAIN }"
+           ;;
+		dhcp-option\ DNS\ *)
+           nns=$((nns + 1))
+           if [ $nns -le 3 ]; then
+             dns="${dns}${dns:+$nl}nameserver ${fopt#dhcp-option DNS }"
+           else
+             printf "%s\n" "Too many nameservers - ignoring after third" >&2
+           fi
+           ;;
+        *)
+           printf "%s\n" "Unknown option \"${fopt}\" - ignored" >&2
+           ;; 
 	esac
-	let i++
-}
+  i=$((i + 1))
 done

-# Now, do the work
-
-if [ -n "${dns[*]}" ]; then
-	for i in "${dns[@]}"; do
-		sed -i -e "1,1 i nameserver ${i}" /etc/resolv.conf || die
-	done
+ds=domain
+if [ $ndoms -gt 1 ]; then
+  ds=search
 fi

-if [ -n "${domain}" ]; then
-	sed -i -e "$j,1 i search ${domain}" /etc/resolv.conf || die
+# This is the complete file - "$domains" has a leading space already
+out="# resolv.conf autogenerated by ${0} (${1})${nl}${dns}${nl}${ds}${domains}"
+
+# use resolvconf if it's available
+if [ -x /sbin/resolvconf ] ; then
+  printf "%s\n" "${out}" | /sbin/resolvconf -a "${1}"
+else
+  # Preserve the existing resolv.conf
+  if [ -e /etc/resolv.conf ] ; then
+    cp /etc/resolv.conf /etc/resolv.conf.ovpnsave
+  fi
+  printf "%s\n" "${out}" > /etc/resolv.conf
+  chmod 644 /etc/resolv.conf
 fi

-# all done...
 exit 0
diff -burp openvpn-2.1.1/contrib/pull-resolv-conf/client.down openvpn-2.1.1-a/contrib/pull-resolv-conf/client.down
--- openvpn-2.1.1/contrib/pull-resolv-conf/client.down	2009-10-01 19:02:17.000000000 +0100
+++ openvpn-2.1.1-a/contrib/pull-resolv-conf/client.down	2010-03-11 21:32:09.000000000 +0000
@@ -14,7 +14,6 @@
 # Place this in /etc/openvpn/client.down
 # Then, add the following to your /etc/openvpn/<clientconfig>.conf:
 #   client
-#   pull dhcp-options
 #   up /etc/openvpn/client.up
 #   down /etc/openvpn/client.down
 # Next, "chmod a+x /etc/openvpn/client.down"
@@ -23,8 +22,8 @@
 # Note that this script is best served with the companion "client.up"
 # script.

-# Only tested on Gentoo Linux 2005.0 with OpenVPN 2.0
-# It should work with any GNU/Linux with /etc/resolv.conf
+# Tested under Debian lenny with OpenVPN 2.1_rc11
+# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolvconf

 # This runs with the context of the OpenVPN UID/GID 
 # at the time of execution. This generally means that
@@ -36,41 +35,12 @@
 # is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
 # been WARNED.

-# init variables
-
-i=1
-j=1
-unset fopt
-unset dns
-unset opt
-
-# Convert ENVs to an array
-
-while fopt=foreign_option_$i; [ -n "${!fopt}" ]; do
-{
-	opt[i-1]=${!fopt}
-	case ${opt[i-1]} in
-		*DOMAIN* ) domain=`echo ${opt[i-1]} | \
-				sed -e 's/dhcp-option DOMAIN //g'` ;;
-		*DNS*    ) dns[j-1]=`echo ${opt[i-1]} | \
-				sed -e 's/dhcp-option DNS //g'`
-			       let j++ ;;
-	esac
-	let i++
-}
-done
-
-# Now, do the work
-
-if [ -n "${dns[*]}" ]; then
-	for i in "${dns[@]}"; do
-		sed -i -e "/nameserver ${i}/D" /etc/resolv.conf || die
-	done
-fi
-
-if [ -n "${domain}" ]; then
-	sed -i -e "/search ${domain}/D" /etc/resolv.conf || die
+if [ -x /sbin/resolvconf ] ; then
+  /sbin/resolvconf -d "${1}"
+elif [ -e /etc/resolv.conf.ovpnsave ] ; then
+  # cp + rm rather than mv in case it's a symlink
+  cp /etc/resolv.conf.ovpnsave /etc/resolv.conf
+  rm -f /etc/resolv.conf.ovpnsave
 fi

-# all done...
 exit 0

--Boundary-00=_N8xzL2EtVcWquQO--

