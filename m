Date: Tue, 28 Jun 2022 17:07:14 +0200 (CEST)
Message-Id: <202206281507.25SF7EVp045610@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220624083809.23487-2-a@...2181...>
References: <20220624083809.23487-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: introduce low-level code
 for handling ovpn-dco in the Linux kernel
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have stared at this code before, and it "seems to be reasonable".

What I *can* attest is that it does not break existing "master" functionality
on client or server, Linux or FreeBSD or "make distcheck" (autoconf changes, 
new modules, ...).  I did not expect anything, but this was sort of the
risk at this point.

Calling configure with --enable-dco does compile the new stuff, so it
is at least "compile safe" (and no warnings).

Some review comments that could be fixed in a followup patch:

 - some of the functions (like "ovpn_dco_nlmsg_create()", "dco_new_peer()")
   could definitely use a bit of commenting so non-netlink-experts would 
   understand what these functions do, and why...  (and I'm sure I mentioned
   that before).

 - dco_new_peer() treats "localaddr" and "remoteaddr" differently 
   when packing, which looks weird -> I think a comment that this is
   to reduce kernel code ("we need full sockaddr for the remote, and
   only the local IP address for local") would avoid confusion.

 - openvpn_dco_init_netlink() carries this TODO

+    /* TODO: Why are we setting this buffer size? */

   ... so, someone should know, and add an appropriate comment :-)

 - a few words of explanation on "... multicast message sent by the
   ovpn-dco kernel module" might be good - I see you subscribe to it,
   and explain mcast_family_handler(), but I can not find any indication
   of "what sort of messages would we expect to see here?".

 - ovpn_dco_nlmsg_create() has

+    if (!nl_msg)
+    {
+        msg(M_ERR, "cannot allocate netlink message");
+        return NULL;
+    }

   ... which never returns, as M_ERR is fatal.  OTOH, *some* callers do

+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_REGISTER_PACKET);
+    if (!nl_msg)
+    {
+        msg(M_ERR, "%s: cannot allocate message to register for control packets",

   ... but not *all* of them (dco_new_peer() does not check nl_msg at all).

   So this should be made consistent - like, either ovpn_dco_nlmsg_create()
   will M_ERR on allocation failure, or return NULL (and never M_ERR).  If 
   it does M_ERR itself, no need to check that in the callers...


 - open_tun_dco() reports an *error* top create DCO interface with D_DCO_DEBUG

+        msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);

   ... and two lines down, an error on if_nametoindex() leads to a FATAL

+        msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);

   ... so what?  Is this function allowed to fail, and return "ret < 0",
   or should it M_ERR/M_FATAL on errors?  There is no pre-function comment
   that could clarify the intent...

 - dco_new_key() has code to support "none"

+    if (dco_cipher != OVPN_CIPHER_ALG_NONE)
+    {

   ... but dco_cipher can never be OVPN_CIPHER_ALG_NONE anymore... and if
   that indent is removed, the NLA_PUT calls for _iv do not need to wrap :-)

 - dco_set_peer() does not pass on the mss yet

 - in ovpn_handle_msg(), can this be called uninitialized?

+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_SKIP;
+    }

   (not sure if nla_parse() will ensure that there is enough attributes,
   or just "well-formed" - and whether *attrs actually gets zeroed 
   by nla_parse(), as openvpn_handle_msg() has no CLEAR() )

 - same function - under which conditions can this fire?  Kernel getting
   confused?

+    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO, "ovpn-dco: received message type %d with mismatched ifindex %d\n",


Uncrustify has complained at me when I merged the patch (because in that
moment, ovpn_dco_linux.h was "newly modified" and the exclusion rule
does not match on the pre-commit-hook) - but as discussed, this is a bit
complicated due to "kernel style" vs "openvpn style", so I've left it
alone for the moment.

Your patch has been applied to the master branch.

commit e34437c26b764851555e4acbe2ccca6bec235c7e
Author: Antonio Quartulli
Date:   Fri Jun 24 10:37:45 2022 +0200

     dco: introduce low-level code for handling ovpn-dco in the Linux kernel

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220624083809.23487-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24512.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


