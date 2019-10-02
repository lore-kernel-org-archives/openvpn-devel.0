From: Paolo Cerrito <wardragon78@...277...>
Date: Wed,  2 Oct 2019 11:03:36 +0200
Message-Id: <20191002090337.22783-1-wardragon78@...277...>
In-Reply-To: <Re: [Openvpn-devel] [PATCH] Insert client connection data into
 PAM environment>
References: <Re: [Openvpn-devel] [PATCH] Insert client connection data into
 PAM environment>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/1] *** Insert client connection data into
 pam environment V2***
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
Cc: a@...2181..., selva.nair@...277..., Paolo Cerrito <wardragon78@...277...>

*** This patch make openvpn insert network client data connection into
pam environment, so make pam modules to process them correctly.
This improvement can make, for example, dynaminc firewalling more
simple and can be done into pam.

This patch is used from as into vpn environment by University of Rome
"Tor Vergata", where we uses into pam the module pam_recent, as this:

Firtof all, we configured iptables to for AUTHFAILS xt_recent tables:
-A INPUT -m recent --rcheck --seconds 21600 --hitcount 10 --name AUTHFAILS --rsource -m limit --limit 20/min -j LOG --log-prefix "AUTHFAILS-DROP " 
-A INPUT -m recent --rcheck --seconds 21600 --hitcount 10 --name AUTHFAILS --rsource -j DROP 
-A INPUT -m recent --rcheck --seconds 21600 --hitcount 6 --name AUTHFAILS --rsource -m limit --limit 10/min -j LOG --log-prefix "AUTHFAILS " 
-A INPUT -m recent --rcheck --seconds 21600 --hitcount 6 --name AUTHFAILS --rsource -j REJECT --reject-with icmp-host-prohibited 

next, make pam insert ip of client into AUTHFAILS whit pam recent before
authentication, if authentication if done and ok, then pam_recent remove
from the AUTHFAILS, else update the hitcount, so iptables can handle the
correctly as you can se from the rules.

pam configuration:

common-account:

#
# /etc/pam.d/common-account - authorization settings common to all services
#
# This file is included from other service-specific PAM config files,
# and should contain a list of the authorization modules that define
# the central access policy for use on the system.  The default is to
# only deny service to users whose accounts are expired in /etc/shadow.
#
# As of pam 1.0.1-6, this file is managed by pam-auth-update by default.
# To take advantage of this, it is recommended that you configure any
# local modules either before or after the default block, and use
# pam-auth-update to manage selection of other modules.  See
# pam-auth-update(8) for details.
#

account optional        pam_recent.so - AUTHFAILS
#account optional        pam_recent.so - AUTHNETFAILS

# here are the per-package modules (the "Primary" block)
account [success=2 new_authtok_reqd=done default=ignore]        pam_unix.so 
account [success=1 default=ignore]      pam_ldap.so 
# here's the fallback if no module succeeds
account requisite                       pam_deny.so
# prime the stack with a positive return value if there isn't one already;
# this avoids us returning an error just because nothing sets a success code
# since the modules above will each just jump around
account required                        pam_permit.so
# and here are more per-package modules (the "Additional" block)
# end of pam-auth-update config
#
# send a notice after login success
# account    required                        pam_warn.so


common-auth:

#
# /etc/pam.d/common-auth - authentication settings common to all services
#
# This file is included from other service-specific PAM config files,
# and should contain a list of the authentication modules that define
# the central authentication scheme for use on the system
# (e.g., /etc/shadow, LDAP, Kerberos, etc.).  The default is to use the
# traditional Unix authentication mechanisms.
#
# As of pam 1.0.1-6, this file is managed by pam-auth-update by default.
# To take advantage of this, it is recommended that you configure any
# local modules either before or after the default block, and use
# pam-auth-update to manage selection of other modules.  See
# pam-auth-update(8) for details.

auth    optional        pam_recent.so + AUTHFAILS
#auth    optional        pam_recent.so + AUTHNETFAILS

# here are the per-package modules (the "Primary" block)
auth    [success=2 default=ignore]      pam_unix.so nullok_secure
auth    [success=1 default=ignore]      pam_ldap.so use_first_pass
# here's the fallback if no module succeeds
auth    requisite                       pam_deny.so
# prime the stack with a positive return value if there isn't one already;
# this avoids us returning an error just because nothing sets a success code
# since the modules above will each just jump around
auth    required                        pam_permit.so
# and here are more per-package modules (the "Additional" block)
# end of pam-auth-update config

***



paolo (1):
  Insert client connection data into PAM environment

 src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.23.0


