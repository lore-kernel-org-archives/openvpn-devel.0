From: Gert Doering <gert@...1296...>
Date: Wed, 28 May 2025 21:11:20 +0200
Message-ID: <20250528191126.25707-1-gert@...1296...>
In-Reply-To: <gerrit.1748444191000.Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5@...2715...>
References: <gerrit.1748444191000.Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove contrib/pull-resolv-conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

We have an official solution for this now.

Change-Id: Ic30f8514b50f561e7ea8f1ce12d740ac53f202e5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1034
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/contrib/pull-resolv-conf/client.down b/contrib/pull-resolv-conf/client.down
deleted file mode 100644
index 0cbb476..0000000
--- a/contrib/pull-resolv-conf/client.down
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2005-2018 OpenVPN Inc
-# Licensed under the GPL version 2
-
-# First version by Jesse Adelman
-# someone at boldandbusted dink com
-# http://www.boldandbusted.com/
-
-# PURPOSE: This script automatically removes the /etc/resolv.conf entries previously
-# set by the companion script "client.up".
-
-# INSTALL NOTES:
-# Place this in /etc/openvpn/client.down
-# Then, add the following to your /etc/openvpn/<clientconfig>.conf:
-#   client
-#   up /etc/openvpn/client.up
-#   down /etc/openvpn/client.down
-# Next, "chmod a+x /etc/openvpn/client.down"
-
-# USAGE NOTES:
-# Note that this script is best served with the companion "client.up"
-# script.
-
-# Tested under Debian lenny with OpenVPN 2.1_rc11
-# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolvconf
-
-# This runs with the context of the OpenVPN UID/GID 
-# at the time of execution. This generally means that
-# the client "up" script will run fine, but the "down" script
-# will require the use of the OpenVPN "down-root" plugin
-# which is in the plugins/ directory of the OpenVPN source tree
-# The config example above would have to be changed to:
-#   client
-#   up /etc/openvpn/client.up
-#   plugin openvpn-plugin-down-root.so "/etc/openvpn/client.down"
-
-# A horrid work around, from a security perspective,
-# is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
-# been WARNED.
-PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
-
-if type resolvconf >/dev/null 2>&1; then
-  resolvconf -d "${dev}" -f
-elif [ -e /etc/resolv.conf.ovpnsave ] ; then
-  # cp + rm rather than mv in case it's a symlink
-  cp /etc/resolv.conf.ovpnsave /etc/resolv.conf
-  rm -f /etc/resolv.conf.ovpnsave
-fi
-
-exit 0
diff --git a/contrib/pull-resolv-conf/client.up b/contrib/pull-resolv-conf/client.up
deleted file mode 100644
index 220aeb7..0000000
--- a/contrib/pull-resolv-conf/client.up
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2005-2018 OpenVPN Inc
-# Licensed under the GPL version 2
-
-# First version by Jesse Adelman
-# someone at boldandbusted dink com
-# http://www.boldandbusted.com/
-
-# PURPOSE: This script automatically sets the proper /etc/resolv.conf entries
-# as pulled down from an OpenVPN server.
-
-# INSTALL NOTES:
-# Place this in /etc/openvpn/client.up
-# Then, add the following to your /etc/openvpn/<clientconfig>.conf:
-#   client
-#   up /etc/openvpn/client.up
-# Next, "chmod a+x /etc/openvpn/client.up"
-
-# USAGE NOTES:
-# Note that this script is best served with the companion "client.down"
-# script.
-
-# Tested under Debian lenny with OpenVPN 2.1_rc11
-# It should work with any UNIX with a POSIX sh, /etc/resolv.conf or resolvconf
-
-# This runs with the context of the OpenVPN UID/GID 
-# at the time of execution. This generally means that
-# the client "up" script will run fine, but the "down" script
-# will require the use of the OpenVPN "down-root" plugin
-# which is in the plugins/ directory of the OpenVPN source tree
-
-# A horrid work around, from a security perspective,
-# is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
-# been WARNED.
-PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
-
-# init variables
-
-i=1
-domains=
-fopt=
-ndoms=0
-nns=0
-nl='
-'
-
-# $foreign_option_<n> is something like
-# "dhcp-option DOMAIN example.com" (multiple allowed)
-# or
-# "dhcp-option DNS 10.10.10.10" (multiple allowed)
-
-# each DNS option becomes a "nameserver" option in resolv.conf
-# if we get one DOMAIN, that becomes "domain" in resolv.conf
-# if we get multiple DOMAINS, those become "search" lines in resolv.conf
-# if we get no DOMAINS, then don't use either domain or search.
-
-while true; do
-  eval fopt=\$foreign_option_${i}
-  [ -z "${fopt}" ] && break
-
-  case ${fopt} in
-		dhcp-option\ DOMAIN\ *)
-           ndoms=$((ndoms + 1))
-           domains="${domains} ${fopt#dhcp-option DOMAIN }"
-           ;;
-		dhcp-option\ DNS\ *)
-           nns=$((nns + 1))
-           if [ $nns -le 3 ]; then
-             dns="${dns}${dns:+$nl}nameserver ${fopt#dhcp-option DNS }"
-           else
-             printf "%s\n" "Too many nameservers - ignoring after third" >&2
-           fi
-           ;;
-        *)
-           printf "%s\n" "Unknown option \"${fopt}\" - ignored" >&2
-           ;;
-	esac
-  i=$((i + 1))
-done
-
-ds=""
-if [ $ndoms -eq 1 ]; then
-  ds="${nl}domain"
-elif [ $ndoms -gt 1 ]; then
-  ds="${nl}search"
-fi
-
-# This is the complete file - "$domains" has a leading space already
-out="# resolv.conf autogenerated by ${0} (${dev})${nl}${dns}${ds}${domains}"
-
-# use resolvconf if it's available
-if type resolvconf >/dev/null 2>&1; then
-  printf "%s\n" "${out}" | resolvconf -a "${dev}"
-else
-  # Preserve the existing resolv.conf
-  if [ -e /etc/resolv.conf ] ; then
-    cp /etc/resolv.conf /etc/resolv.conf.ovpnsave
-  fi
-  printf "%s\n" "${out}" > /etc/resolv.conf
-  chmod 644 /etc/resolv.conf
-fi
-
-exit 0

