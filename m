From: Davide Brini <dave_br@...1278...>
Date: Thu, 11 Mar 2010 21:41:00 +0000
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
	<201003101634.58839.dave_br@...1278...>
	<4B98179E.9020904@...1114...>
In-Reply-To: <4B98179E.9020904@...1114...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tNWmLnNtWWoU8KK"
Message-Id: <201003112141.01092.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_tNWmLnNtWWoU8KK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 10 March 2010, David Sommerseth wrote:

> > Well, I was actually going to write a patch, but shortly after starting I
> > found out that it would end up being essentially the same as Gentoo's
> > scripts. Would it be worth separately maintaining something that has
> > already been written somewhere else?
> 
> I would say that if there are things which are distro related, they
> should either be found only in that distribution or we can consider (if
> it is considered important by more people) to put distro specific stuff
> into a separate folder in the OpenVPN source tree.
> 
> If it is possible to get some up/down scripts which are generic for the
> vast majority of POSIX sh based distributions, that would be the
> preferred approach.  If not, then we are back to where we started :)

Ok, here it goes (it's against 2.1.1). As said, it's basically a complete 
rewrite that draws many ideas from the Gentoo scripts. These are the main 
differences from the "old" client.{up,down} scripts:

- No more bashisms (AFAICT). Should work with any POSIX-compatible shell 
(which means "almost all reasonably recent shells"), though I've only tested 
with bash and dash.

- Unnecessary calls to external tools (sed) removed 

- Manages multiple DNS and DOMAIN options. Each DNS option becomes a 
"nameserver" line in the new resolv.conf (up to a maximum of 3). If there's a 
single DOMAIN option, it becomes a "domain" line in resolv.conf; otherwise, 
all the domains are listed in a "search" line in resolv.conf (eg "search 
foo.com example.net").

- Client.up renames the existing resolv.conf and creates a brand new one; 
client.down restores it from the saved copy when the VPN terminates (the usual 
rules about running as root apply). This is how Gentoo does that; the old 
scripts instead added/removed some lines at the beginning of the file, which 
looks a less clean approach to me. The rename approach also dramatically 
simplifies and shortens client.down, as you'll see.

- Uses resolvconf if it's available (detected by the presence of 
/sbin/resolvconf) rather than writing to resolv.conf directly. Not sure 
whether this is a Linux-only thing or other systems use it though.

A doubt I have is: should the script output its errors as it does now? If yes, 
is it possible to somehow send them to the main OpenVPN log so they appear 
among the other normal messages?

Let me know what you think.

In case lines wrap, which is likely, I'm also attaching the file.

diff -burp openvpn-2.1.1/contrib/pull-resolv-conf/client.up openvpn-2.1.1-
a/contrib/pull-resolv-conf/client.up > clientup.patch
--- openvpn-2.1.1/contrib/pull-resolv-conf/client.up    2009-10-01 
19:02:17.000000000 +0100
+++ openvpn-2.1.1-a/contrib/pull-resolv-conf/client.up  2010-03-11 
21:32:03.000000000 +0000
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
+# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or 
resolvconf

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
-   opt[i-1]=${!fopt}
-   case ${opt[i-1]} in
-       *DOMAIN* ) domain=`echo ${opt[i-1]} | \
-               sed -e 's/dhcp-option DOMAIN //g'` ;;
-       *DNS*    ) dns[j-1]=`echo ${opt[i-1]} | \
-               sed -e 's/dhcp-option DNS //g'`
-                  let j++ ;;
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
+       dhcp-option\ DOMAIN\ *)
+           ndoms=$((ndoms + 1))
+           domains="${domains} ${fopt#dhcp-option DOMAIN }"
+           ;;
+       dhcp-option\ DNS\ *)
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
-   let i++
-}
+  i=$((i + 1))
 done

-# Now, do the work
-
-if [ -n "${dns[*]}" ]; then
-   for i in "${dns[@]}"; do
-       sed -i -e "1,1 i nameserver ${i}" /etc/resolv.conf || die
-   done
+ds=domain
+if [ $ndoms -gt 1 ]; then
+  ds=search
 fi

-if [ -n "${domain}" ]; then
-   sed -i -e "$j,1 i search ${domain}" /etc/resolv.conf || die
+# This is the complete file - "$domains" has a leading space already
+out="# resolv.conf autogenerated by ${0} 
(${1})${nl}${dns}${nl}${ds}${domains}"
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
diff -burp openvpn-2.1.1/contrib/pull-resolv-conf/client.down openvpn-2.1.1-
a/contrib/pull-resolv-conf/client.down >> clientup.patch
--- openvpn-2.1.1/contrib/pull-resolv-conf/client.down  2009-10-01 
19:02:17.000000000 +0100
+++ openvpn-2.1.1-a/contrib/pull-resolv-conf/client.down    2010-03-11 
21:32:09.000000000 +0000
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
+# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or 
resolvconf

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
-   opt[i-1]=${!fopt}
-   case ${opt[i-1]} in
-       *DOMAIN* ) domain=`echo ${opt[i-1]} | \
-               sed -e 's/dhcp-option DOMAIN //g'` ;;
-       *DNS*    ) dns[j-1]=`echo ${opt[i-1]} | \
-               sed -e 's/dhcp-option DNS //g'`
-                  let j++ ;;
-   esac
-   let i++
-}
-done
-
-# Now, do the work
-
-if [ -n "${dns[*]}" ]; then
-   for i in "${dns[@]}"; do
-       sed -i -e "/nameserver ${i}/D" /etc/resolv.conf || die
-   done
-fi
-
-if [ -n "${domain}" ]; then
-   sed -i -e "/search ${domain}/D" /etc/resolv.conf || die
+if [ -x /sbin/resolvconf ] ; then
+  /sbin/resolvconf -d "${1}"
+elif [ -e /etc/resolv.conf.ovpnsave ] ; then
+  # cp + rm rather than mv in case it's a symlink
+  cp /etc/resolv.conf.ovpnsave /etc/resolv.conf
+  rm -f /etc/resolv.conf.ovpnsave
 fi

-# all done...
 exit 0

-- 
D.

--Boundary-00=_tNWmLnNtWWoU8KK
Content-Type: text/x-patch;
  charset="UTF-8";
  name="up_down_scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="up_down_scripts.patch"

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

--Boundary-00=_tNWmLnNtWWoU8KK--

