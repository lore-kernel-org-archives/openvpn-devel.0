Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
	startup on Linux
From: Paul Iadonisi <pri.openvpn@...317...>
In-Reply-To: <1100737211.8135.32.camel@...318...>
References: <1100737211.8135.32.camel@...318...>
Content-Type: multipart/mixed; boundary="=-tIcF920Jp1kNCnYx02sL"
Message-Id: <1100738804.8135.38.camel@...318...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov 17 16:47:18 2004
To: openvpn-devel@lists.sourceforge.net

--=-tIcF920Jp1kNCnYx02sL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

And here they are

-- 
-Paul Iadonisi
 Senior System Administrator
 Red Hat Certified Engineer / Local Linux Lobbyist
 Ever see a penguin fly?  --  Try Linux.
 GPL all the way: Sell services, don't lease secrets

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=ifup-openvpn
Content-Type: application/x-shellscript; name=ifup-openvpn
Content-Transfer-Encoding: 7bit

#!/bin/bash
#
# ifup-openvpn
#
# Shuts down openvpn interfaces
#
#  (See end of file for copyright notice)
#
# For use with OpenVPN 2.0_beta13 on Fedora Core 2 or 3
# Not tested with earlier releases of either
#
#   Configuration parameters:
#     See man page for openvpn(8)
#      replace dashes with underscores and uppercase the options to
#      obtain a list of variables you can set in an ifcfg-* file.
#
#    Exceptions:
#      - Make no sense in a cfg file
#         help, config, genkey, test-crypto, inetd, show-ciphers,
#         show-digests, show-engines, show-tls, gremlin
#         mktun, rmtun: invoked separately with ifup-openvpn and ifdown-openvpn
#      - Not allowed
#         log-append, log: don't allow overriding of syslogging
#      - Implied by other options
#         tls-client, tls-server, client, server, server-bridge
#         mode: set MODE ito client, server, server-bridge, in ifcfg file
#      - Used internally
#         dev: set to the value of ${DEVICE}
#         user, group: set to openvpn, openvpn
#         chroot: set to /var/lib/openvpn
#         persist-tun, ifconfig-pool-persist, persist-key, persist-local: set
#      - Not needed
#         dev-type, dev-node
#      - Changed usage
#         replay-persist:  always ${statedir}/${DEVICE}.state
#         status: always ${logdir}/${DEVICE}.log
#      - Win32 only
#         ip-win32, route-method, dhcp-option, tap-sleep, show-net-up,
#         dhcp-release, dhcp-renew, show-adapters, service,
#         show-valid-subnets, show-net
###

. /etc/init.d/functions
cd /etc/sysconfig/network-scripts
. network-functions

#Remove this
#cd

isyes() {
  [ "`echo $1 | tr A-Z a-z`" == "yes" ]
  return $?
}

# sdir and kdir are presumed subdirs of ${confdir}/${DEVICE}
confdir=/etc/sysconfig/openvpn
sdir=scripts
kdir=keys
piddir=/var/run
rundir=/var/run/openvpn
statedir=/var/lib/openvpn
logdir=/var/log/openvpn

CONFIG=$1
[ -f "${CONFIG}" ] || CONFIG=ifcfg-${1}
source_config

DEVICE="`echo ${DEVICE} | LANG=C egrep '^(tap|tun)[0-9][0-9]*$'`"
if [ -z "${DEVICE}" ]; then
#  echo "${DEVICE} is not a tap or tun device"
  exit 1
fi
OPTIONS="--daemon openvpn-${DEVICE} --dev ${DEVICE}"
OPTIONS="${OPTIONS} --persist-tun --persist-key --persist-local-ip"
OPTIONS="${OPTIONS} --user openvpn --group openvpn --chroot /var/lib/openvpn"

ddir=${confdir}/${DEVICE}
OPTIONS="${OPTIONS} --cd ${ddir}"

pidfile=${piddir}/openvpn-${DEVICE}.pid
OPTIONS="${OPTIONS} --writepid ${pidfile}"

statusfile=${logdir}/${DEVICE}.log
OPTIONS="${OPTIONS} --status ${statusfile} ${STATUS_INTERVAL}"

downvarfile=""
[ -n "${DOWN}" ] && downvarfile=${rundir}/${DEVICE}-downvars.sh

upwrapper=$(pwd)/upwrap-openvpn

if [ -z "${MODE}" ]; then
#   echo "No mode specified, default to p2p"
  :
else
  MODE=(${MODE})
  case "${MODE[0]}" in
    client)
            OPTIONS="${OPTIONS} --client"
            ;;
    server)
            if [ "${#MODE[@]}" -ne 3 ] || \
               ! ipcalc -s -m "${MODE[1]}" 1>/dev/null 2>&1 || \
               ! ipcalc -s -m "${MODE[2]}" 1>/dev/null 2>&1; then
#              echo "Usage for server: server network netmask"
              exit 1
            else
              OPTIONS="${OPTIONS} --server ${MODE[1]} ${MODE[2]}"
              OPTIONS="${OPTIONS} --ifconfig-pool-persist ${statedir}/ifpool-${DEVICE}.state"
            fi
            ;;
    server-bridge)
            if [ "${#MODE[@]}" -ne 5 ] || \
               ! ipcalc -s -m "${MODE[1]}" 1>/dev/null 2>&1 || \
               ! ipcalc -s -m "${MODE[2]}" 1>/dev/null 2>&1 || \
               ! ipcalc -s -m "${MODE[3]}" 1>/dev/null 2>&1 || \
               ! ipcalc -s -m "${MODE[4]}" 1>/dev/null 2>&1; then
#              echo "Usage for server-bridge: server-bridge gateway netmask pool-start-IP pool-end-IP"
              exit 1
            else
              OPTIONS="${OPTIONS} --${MODE[@]}"
              OPTIONS="${OPTIONS} --ifconfig-pool-persist ${statedir}/ifpool-${DEVICE}.state"
            fi
            ;;
  esac  # End case in ${MODE[0]}
fi


if [ ! \
  \( \
    \( -n "${SECRET}" -a -z "${CA}" -a -z "${CERT}" -a -z "${KEY}" \) -o \
    \( -z "${SECRET}" -a -n "${CA}" -a -n "${CERT}" -a -n "${KEY}" \) \
  \) \
  ]; then
#  echo "Mutually exclusive: SECRET vs. CA/CERT/KEY"
  exit 1
else
  if [ -n "${SECRET}" ]; then
    SECRET=(${SECRET})
    if [ "${#SECRET[@]}" -ne 1 -a "${#SECRET[@]}" -ne 2 ]; then
#      echo "Usage for secret: secret file [direction]"
      exit 1
    elif [ "${#SECRET[@]}" -eq 1 ]; then
      OPTIONS="${OPTIONS} --secret ${kdir}/${SECRET[0]}"
    else
      OPTIONS="${OPTIONS} --secret ${kdir}/${SECRET[0]} ${SECRET[1]}"
    fi
  else
    OPTIONS="${OPTIONS} --ca ${kdir}/${CA}"
    OPTIONS="${OPTIONS} --cert ${kdir}/${CERT}"
    OPTIONS="${OPTIONS} --key ${kdir}/${KEY}"
  fi
fi

[ -n "${CRL_VERIFY}" ] && \
  OPTIONS="${OPTIONS} --crl-verify ${kdir}/${CRL_VERIFY}"

if [ "${#TLS_AUTH[@]}" -ne 1 -a "${#TLS_AUTH[@]}" -ne 2 ]; then
#  echo "Usage for tls-auth: tls-auth file [direction]"
  exit 1
elif [ "${#TLS_AUTH[@]}" -eq 1 ]; then
  OPTIONS="${OPTIONS} --tls-auth ${kdir}/${TLS_AUTH[0]}"
else
  OPTIONS="${OPTIONS} --tls-auth ${kdir}/${TLS_AUTH[0]} ${TLS_AUTH[1]}"
fi

[ -n "${DH}" ] && OPTIONS="${OPTIONS} --dh ${kdir}/${DH}"
    
isyes "${REPLAY_PERSIST}" && \
  OPTIONS="${OPTIONS} --replay-persist ${statedir}/replay-${DEVICE}.state"

#[ -n "${UP}" ] && OPTIONS="${OPTIONS} --up ${sdir}/${UP}"
#[ -n "${DOWN}" ] && OPTIONS="${OPTIONS} --down ${sdir}/${DOWN}"
# Since we are always running openvpn as a non-root user and in
# chroot jail, don't give the down script (if provided) to openvpn
# to run.  We want to run this in the context of the root user, so
# instead we will run it from ifdown-openvpn.  But in order to do
# that we need to tell the up script to dump it's variables.  This,
# of course, implies that we can't have a down script without an up
# script.
if [ -n "${UP}" ]; then
  OPTIONS="${OPTIONS} --up \"${upwrapper} ${sdir}/${UP} d=${downvarfile}\""
elif [ -n "${DOWN}" ]; then
#  echo "Down script specified without an up script"
   exit 1
fi 
    

# This is bizarre stuff, but it works
#  PUSH options are specified as PUSH[n]="optionstring" where n
#   is an array index.
if [ "${#PUSH[@]}" -gt 0 ]; then
  PUSH=("${PUSH[@]/#/--push \"}")
  PUSH=("${PUSH[@]/%/\"}")
  OPTIONS="${OPTIONS} ${PUSH[@]}"
fi

#Treat PLUGIN similarly -- but without the quotes.
#Each --plugin option takes two args, but we let openvpn take care of
#that checking.
if [ "${#PLUGIN[@]}" -gt 0 ]; then
  PLUGIN=("${PLUGIN[@]/#/--plugin }")
  PLUGIN=("${PLUGIN[@]/%/}")
  OPTIONS="${OPTIONS} ${PLUGIN[@]}"
fi


# Zero args
for opt in CCD_EXCLUSIVE CLIENT_CERT_NOT_REQUIRED CLIENT_DISCONNECT \
           CLIENT_TO_CLIENT COMP_LZO COMP_NOADAPT DISABLE_OCC DOWN_PRE \
           DUPLICATE_CN FAST_IO FLOAT HTTP_PROXY_RETRY IFCONFIG_NOEXEC \
           IFCONFIG_NOWARN IFCONFIG_POOL_LINEAR SUPPRESS_TIMESTAMPS MLOCK \
           MTU_TEST MUTE_REPLAY_WARNINGS NO_IV NO_REPLAY NOBIND PASSTOS \
           PERSIST_REMOTE_IP \
           PING_TIMER_REM PULL PUSH_RESET REMOTE_RANDOM ROUTE_NOEXEC \
           SINGLE_SESSION SOCKS_PROXY_RETRY TLS_EXIT TUN_IPV6 UP_DELAY \
           UP_RESTART USERNAME_AS_COMMON_NAME TLS_EXIT
 do
  isyes "${!opt}" && OPTIONS="${OPTIONS} --`echo ${opt}|tr A-Z_ a-z-`"
 done

# One arg
for opt in AUTH_USER_PASS_VERIFY AUTH_USER_PASS AUTH BCAST_BUFFERS CHROOT \
           CIPHER CLIENT_CONFIG_DIR CLIENT_CONNECT CONNECT_RETRY \
           FRAGMENT GROUP HAND_WINDOW INACTIVE IPCHANGE KEY_METHOD KEYSIZE \
           LEARN_ADDRESS LINK_MTU LOCAL LPORT MAX_CLIENTS MSSFIX MTU_DISC \
           MUTE NICE PING_EXIT PING_RESTART PING PKCS12 PORT PROTO RCVBUF \
           RENEG_BYTES RENEG_PKTS RENEG_SEC RESOLV_RETRY ROUTE_GATEWAY \
           ROUTE_UP RPORT SHAPER SNDBUF TCP_QUEUE_LIMIT TLS_CIPHER TLS_REMOTE \
           TLS_TIMEOUT TLS_VERIFY TMP_DIR TRAN_WINDOW TUN_MTU_EXTRA TUN_MTU \
           TXQUEUELEN EUSER VERB
 do
  [ -n "${!opt}" ] && OPTIONS="${OPTIONS} --`echo ${opt}|tr A-Z_ a-z-` ${!opt}"
 done

#Multi args
for opt in CONNECT_FREQ HASH_SIZE HTTP_PROXY \
           IFCONFIG_POOL IFCONFIG_PUSH IFCONFIG IROUTE KEEPALIVE \
           REDIRECT_GATEWAY REMOTE
 do
  [ -n "${!opt}" ] && OPTIONS="${OPTIONS} --`echo ${opt}|tr A-Z_ a-z-` ${!opt}"
 done

#Var args
for opt in REPLAY_WINDOW ROUTE SETENV SOCKS_PROXY
 do
  [ -n "${!opt}" ] && OPTIONS="${OPTIONS} --`echo ${opt}|tr A-Z_ a-z-` ${!opt}"
 done

#Zero or more args -- we're gonna require the args for now
for opt in ROUTE_DELAY ENGINE ASKPASS
 do
  [ -n "${!opt}" ] && OPTIONS="${OPTIONS} --`echo ${opt}|tr A-Z_ a-z-` ${!opt}"
 done

if [ -s "${pidfile}" ]; then
  pid=`cat ${pidfile}`
  comm=`ps -p ${pid} -o comm=`
  if [ "${comm}" == "openvpn" ]; then
#    echo "OpenVPN already running on ${DEVICE}"
    exit 1
  fi
fi

openvpn --mktun --dev ${DEVICE} 1>/dev/null 2>&1

if [ "${MODE[0]}" == "server-bridge" -a -x /usr/sbin/brctl ]; then
  if [ -z "${BRIDGE}" ]; then
#    echo "Attempted to use server-bridge mode when BRIDGE is not set"
    openvpn --rmtun --dev ${DEVICE} 1>/dev/null 2>&1
    exit 1
  fi
  /sbin/ip addr flush dev ${DEVICE} 2>/dev/null
  /sbin/ip link set dev ${DEVICE} up
  /usr/sbin/brctl addif ${BRIDGE} ${DEVICE}
  # Upon adding a device to a bridge,
  # it's necessary to make radvd reload its config
  [ -r /var/run/radvd/radvd.pid ] && kill -HUP `cat /var/run/radvd/radvd.pid`
fi

rm -f ${pidfile}
echo openvpn ${OPTIONS} | sh

if [ $? -ne 0 ]; then
  openvpn --rmtun --dev ${DEVICE} 1>/dev/null 2>&1
  exit 1
fi

###
#
# Copyright (C) 2004 by Paul Iadonisi <pri.openvpn@...317...>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program (see the file COPYING included with this
#  distribution); if not, write to the Free Software Foundation, Inc.,
#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=ifdown-openvpn
Content-Type: application/x-shellscript; name=ifdown-openvpn
Content-Transfer-Encoding: 7bit

#!/bin/bash
#
# ifdown-openvpn
#
# Shuts down openvpn interfaces
#
#  (See end of file for copyright notice)
#
# For use with OpenVPN 2.0_beta13 on Fedora Core 2 or 3
# Not tested with earlier releases of either
#

. /etc/init.d/functions
cd /etc/sysconfig/network-scripts
. network-functions

#Remove this
#cd

isyes() {
  [ "`echo $1 | tr A-Z a-z`" == "yes" ]
  return $?
}

# sdir and kdir are presumed subdirs of ${confdir}/${DEVICE}
confdir=/etc/sysconfig/openvpn
sdir=scripts
kdir=keys
piddir=/var/run
rundir=/var/run/openvpn
statedir=/var/lib/openvpn
logdir=/var/log/openvpn

CONFIG=$1
[ -f "${CONFIG}" ] || CONFIG=ifcfg-${1}
source_config

DEVICE="`echo ${DEVICE} | LANG=C egrep '^(tap|tun)[0-9][0-9]*$'`"
if [ -z "${DEVICE}" ]; then
#  echo "${DEVICE} is not a tap or tun device"
  exit 1
fi
#  OPTIONS="${OPTIONS} --daemon openvpn-${DEVICE} --dev ${DEVICE}"

ddir=${confdir}/${DEVICE}

pidfile=${piddir}/openvpn-${DEVICE}.pid

downvarfile=""
[ -n "${DOWN}" ] && downvarfile=${rundir}/${DEVICE}-downvars.sh

downwrapper=$(pwd)/downwrap-openvpn

if [ -s "${pidfile}" ]; then
  pidtokill=`cat ${pidfile}`
  comm=`ps -p ${pidtokill} -o comm=`
# Precautionary measure
  if [ "${comm}" == "openvpn" ]; then
    kill ${pidtokill} 1>/dev/null 2>&1
    (
      cd ${confdir}/${DEVICE};
      [ -n "${DOWN}" -a -x "${sdir}/${DOWN}" ] && \
        ${downwrapper} ${sdir}/${DOWN} d=${downvarfile}
    )
    openvpn --rmtun --dev ${DEVICE} 1>/dev/null 2>&1
    rm -f ${pidfile} ${downvarfile}
  fi
fi

###
#
# Copyright (C) 2004 by Paul Iadonisi <pri.openvpn@...317...>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program (see the file COPYING included with this
#  distribution); if not, write to the Free Software Foundation, Inc.,
#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=upwrap-openvpn
Content-Type: application/x-shellscript; name=upwrap-openvpn
Content-Transfer-Encoding: 7bit

#!/bin/bash

dumpvars() {
#  if [ -f ${1} ]; then
##   echo ${1} already exists
#    return 1
#  fi

# ${!remote_*} ${!remote_port_*} \

  for var in common_name config dev ${!foreign_option_*} ifconfig_broadcast \
             ifconfig_local ifconfig_remote ifconfig_netmask \
             ifconfig_pool_local_ip ifconfig_pool_remote_ip link_mtu local \
             local_port password proto ${!remote_*} \
             route_net_gateway route_vpn_gateway ${!route_network_*} \
             ${!route_netmask_*} ${!route_gateway_*} ${!route_metric_*} \
             script_context script_type signal ${!tls_id_*} ${!tls_serial_*} \
             tun_mtu trusted_ip trusted_port untrusted_ip untrusted_port \
             username
   do
     [ -n "${!var}" ] && echo ${var}=\"${!var}\"
   done > ${1}
   chmod 700 ${1}
}

# main

# Script does not exist
[ ! -x "${1}" ] && exit 1

upscript="${1}"
vardumpfile="${2#d=}"
shift 2

[ -n "${vardumpfile}" ] && dumpvars ${vardumpfile}

. ${upscript} "$@"

###
#
# Copyright (C) 2004 by Paul Iadonisi <pri.openvpn@...317...>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program (see the file COPYING included with this
#  distribution); if not, write to the Free Software Foundation, Inc.,
#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=downwrap-openvpn
Content-Type: application/x-shellscript; name=downwrap-openvpn
Content-Transfer-Encoding: 7bit

#!/bin/bash

# Script does not exist
[ ! -x "${1}" ] && exit 1

downscript="${1}"
vardumpfile="${2#d=}"
shift 2

[ -n "${vardumpfile}" ] && . ${vardumpfile}

. ${downscript} "$@"

###
#
# Copyright (C) 2004 by Paul Iadonisi <pri.openvpn@...317...>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program (see the file COPYING included with this
#  distribution); if not, write to the Free Software Foundation, Inc.,
#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=ifcfg-tap0.client
Content-Type: text/plain; name=ifcfg-tap0.client; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

DEVICE=tap0
ONBOOT=no
USERCTL=yes
TYPE=OpenVPN
DEVICETYPE=openvpn
#
MODE=client
UP=client.up
DOWN=client.down
PROTO=udp
REMOTE="my-server-host 5000"
RESOLV_RETRY=infinite
NOBIND=yes
CA=sample-ca.crt
CERT=sample-cert.crt
KEY=sample-key.key
TLS_AUTH="ta.key 1"
COMP_LZO=yes
VERB=4

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=ifcfg-tap0.server-bridge
Content-Type: text/plain; name=ifcfg-tap0.server-bridge; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

DEVICE=tap0
BOOTPROTO=static
IPADDR=0.0.0.0
ONBOOT=yes
BRIDGE=brg0
TYPE=OpenVPN
DEVICETYPE=openvpn
#
LOCAL=172.16.20.2
PORT=5000
PROTO=udp
CA=sample-ca.crt
CERT=sample-cert.crt
KEY=sample-key.key
DH=dh1024.pem
CRL_VERIFY=crl.pem
MODE="server-bridge 10.8.0.1 255.255.255.0 10.8.0.112 10.8.0.127"
PUSH[0]="dhcp-option DNS 10.8.0.2"
PUSH[1]="dhcp-option DNS 10.8.0.4"
PUSH[2]="dhcp-option DOMAIN my.local.domain.com"
#CLIENT_TO_CLIENT=yes
KEEPALIVE="10 60"
TLS_AUTH="ta.key 0"
REPLAY_PERSIST=yes
COMP_LZO=yes
MAX_CLIENTS=16
VERB=4

--=-tIcF920Jp1kNCnYx02sL
Content-Disposition: attachment; filename=openvpn.spec
Content-Type: text/plain; name=openvpn.spec; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Summary:	A Secure TCP/UDP Tunneling Daemon
Name:           openvpn
Version:        2.0_beta17
Release:	15
URL:		http://sourceforge.net/projects/openvpn/
Source0:	http://prdownloads.sourceforge.net/openvpn/%{name}-%{version}.tar.gz
Source1:	ifup-openvpn
Source2:	ifdown-openvpn
Source3:	upwrap-openvpn
Source4:	downwrap-openvpn
Source5:	ifcfg-tap0.client
Source6:	ifcfg-tap0.server-bridge
License:	GPL
Group:		Networking/Tunnels
BuildRoot:	%{_tmppath}/%{name}-%(id -un)

%{!?_without_lzo:BuildRequires: lzo-devel}
%{!?_without_lzo:Requires:   	lzo}

%description
OpenVPN is a robust and highly flexible tunneling application that
uses all of the encryption, authentication, and certification features
of the OpenSSL library to securely tunnel IP networks over a single
UDP port. It can use the Marcus Franz Xaver Johannes Oberhumer's LZO
library for compression.

%define debug_package %{nil}

%prep
%setup -q

%build
%configure %{?_without_lzo:--disable-lzo}
%__make

%__cp -p ${RPM_SOURCE_DIR}/ifup-openvpn sample-scripts/
%__cp -p ${RPM_SOURCE_DIR}/ifdown-openvpn sample-scripts/
%__cp -p ${RPM_SOURCE_DIR}/upwrap-openvpn sample-scripts/
%__cp -p ${RPM_SOURCE_DIR}/downwrap-openvpn sample-scripts/
%__mkdir sample-ifcfg-files
%__cp -p ${RPM_SOURCE_DIR}/ifcfg-* sample-ifcfg-files/

%install
[ %{buildroot} != "/" ] && rm -rf %{buildroot}

%__install -c -d -m 755 %{buildroot}%{_mandir}/man8
%__install -c -m 755 %{name}.8 %{buildroot}%{_mandir}/man8
%__install -c -d -m 755 %{buildroot}%{_sbindir}
%__install -c -m 755 %{name} %{buildroot}%{_sbindir}
#%__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
#%__install -c -m 755 sample-scripts/%{name}.init %{buildroot}/etc/rc.d/init.d/%{name}
%__install -c -d -m 755 %{buildroot}/etc/sysconfig/network-scripts
%__install -c -m 755 sample-scripts/ifup-openvpn \
   %{buildroot}/etc/sysconfig/network-scripts
%__install -c -m 755 sample-scripts/ifdown-openvpn \
   %{buildroot}/etc/sysconfig/network-scripts
%__install -c -m 755 sample-scripts/upwrap-openvpn \
   %{buildroot}/etc/sysconfig/network-scripts
%__install -c -m 755 sample-scripts/downwrap-openvpn \
   %{buildroot}/etc/sysconfig/network-scripts
%__install -c -d -m 700 %{buildroot}/var/run/openvpn
%__install -c -d -m 700 %{buildroot}/var/lib/openvpn
%__install -c -d -m 700 %{buildroot}/var/log/openvpn
%__install -c -d -m 700 %{buildroot}/etc/sysconfig/openvpn

#%__install -c -d -m 755 %{buildroot}/etc/%{name}

%__mkdir_p %{buildroot}%{_datadir}/%{name}
%__cp -pr contrib easy-rsa sample-{config-file,key,script,ifcfg-file}s %{buildroot}%{_datadir}/%{name}

%clean
[ %{buildroot} != "/" ] && rm -rf %{buildroot}

%pre
/usr/sbin/useradd -c "OpenVPN" -u 150 \
	-s /sbin/nologin -r -d /var/lib/openvpn openvpn 2>/dev/null || :

%post
case "`uname -r`" in
2.4*)
	/bin/mkdir /dev/net >/dev/null 2>&1 || :
	/bin/mknod /dev/net/tun c 10 200 >/dev/null 2>&1 || :
	;;
esac
#/sbin/chkconfig --add %{name}
#/sbin/service %{name} condrestart

%preun
#if [ "$1" = 0 ]
#then
#	/sbin/service %{name} stop
#	/sbin/chkconfig --del %{name}
#fi

%files
%defattr(-,root,root)
%doc AUTHORS COPYING COPYRIGHT.GPL INSTALL NEWS PORTS README
%{_mandir}/man8/%{name}.8*
%{_sbindir}/%{name}
%{_datadir}/%{name}
#/etc/rc.d/init.d/*
#/etc/openvpn
/etc/sysconfig/network-scripts/ifup-openvpn
/etc/sysconfig/network-scripts/ifdown-openvpn
/etc/sysconfig/network-scripts/upwrap-openvpn
/etc/sysconfig/network-scripts/downwrap-openvpn
%dir %attr(0700,openvpn,openvpn) /var/run/openvpn
%dir %attr(0700,openvpn,openvpn) /var/lib/openvpn
%dir %attr(0700,openvpn,openvpn) /var/log/openvpn
%dir %attr(0700,root,root) /etc/sysconfig/openvpn

%changelog
* Sun Nov 17 2004 Paul Iadonisi <rpms@...319...> 2.0_beta15-15
- Added copyright notices to scripts in /etc/sysconfig/network-scripts

* Sun Nov 14 2004 Paul Iadonisi <rpms@...319...> 2.0_beta15-11
- Include wrapper scripts in src rpm.  feh

* Fri Nov 12 2004 Paul Iadonisi <rpms@...319...> 2.0_beta15-9
- Run --down script from ifdown-openvpn instead from within openvpn
-  so that it gets run as root, instead of the openvpn user.

* Fri Nov 05 2004 Paul Iadonisi <rpms@...319...> 2.0_beta15-8
- version 2.0_beta15

* Fri Nov 05 2004 Paul Iadonisi <rpms@...319...> 2.0_beta13-7
- Add utilize ifup/ifdown scripts instead of init script

* Fri Oct 22 2004 Paul Iadonisi <rpms@...319...> 2.0_beta13-1
- version 2.0_beta13

* Fri Oct 22 2004 Paul Iadonisi <rpms@...319...> 2.0_beta12-1
- version 2.0_beta12

* Sun Feb 23 2003 Matthias Andree <matthias.andree@...68...> 1.3.2.14-1.
- Have the version number filled in by autoconf.

* Wed Jul 10 2002 James Yonan <jim@...41...> 1.3.1-1
- Fixed %preun to only remove service on final uninstall

* Mon Jun 17 2002 bishop clark (LC957) <bishop@...7...> 1.2.2-1
- Added condrestart to openvpn.spec & openvpn.init.

* Wed May 22 2002 James Yonan <jim@...41...> 1.2.0-1
- Added mknod for Linux 2.4.

* Wed May 15 2002 Doug Keller <dsk@...19...> 1.1.1.16-2
- Added init scripts
- Added conf file support

* Mon May 13 2002 bishop clark (LC957) <bishop@...7...> 1.1.1.14-1
- Added new directories for config examples and such

* Sun May 12 2002 bishop clark (LC957) <bishop@...7...> 1.1.1.13-1
- Updated buildroot directive and cleanup command
- added easy-rsa utilities

* Mon Mar 25 2002 bishop clark (LC957) <bishop@...7...> 1.0-1
- Initial build.

--=-tIcF920Jp1kNCnYx02sL--


