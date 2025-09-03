Date: Wed, 3 Sep 2025 22:26:37 +0200 (CEST)
Message-Id: <202509032026.583KQbVh020340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250903164826.13284-1-gert@...1296...>
References: <20250903164826.13284-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE message sender:
 enabling the server to send PUSH_UPDATE control messages
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Took us long enough... but after enough iterations, we're at a point
now where this works well enough to include in 2.7_beta1 (and I can
build an automated test rig on top of it).

I've stared long and hard at the code, we've discussed this a lot,
and I've tested this with the client and server test beds (it somewhat
affects the normal PUSH paths), and I purposely tested the new
functionality, trying to push garbage to clients, "normal" options,
and "new ifconfig IPs".

Pushing new IPv4 and IPv6 addresses works nicely now (in this case,
only one client was connected, otherwise "push-update-broad" with
the same IP address to all clients is a bit... silly)

Sep  3 18:35:22 gentoo tun-udp-p2mp[28688]: MANAGEMENT: CMD 'push-update-broad "ifconfig 10.204.2.166 10.204.2.5"'
Sep  3 18:35:22 gentoo tun-udp-p2mp[28688]: SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_UPDATE,ifconfig 10.204.2.166 10.204.2.5' (status=1)
Sep  3 18:35:22 gentoo tun-udp-p2mp[28688]: MULTI: Learn: 10.204.2.166 -> cron2-freebsd-tc-amd64/udp6:194.97.140.21:16758

As the code says in a big fat TODO, it's not unlearning the previous IP
yet - so "status 2" has both old and new...

ROUTING_TABLE,10.204.2.6,cron2-freebsd-tc-amd64,udp6:194.97.140.21:16758,2025-09-03 18:35:22,1756917322
ROUTING_TABLE,10.204.2.166,cron2-freebsd-tc-amd64,udp6:194.97.140.21:16758,2025-09-03 18:36:08,1756917368


IPv6 works too:

Sep  3 18:41:26 gentoo tun-udp-p2mp[28688]: MANAGEMENT: CMD 'status 2'
Sep  3 18:42:23 gentoo tun-udp-p2mp[28688]: MANAGEMENT: CMD 'push-update-broad "ifconfig-ipv6 fd00:abcd:204:2::99aa/64 fd00:abcd:204:2::1"'
Sep  3 18:42:23 gentoo tun-udp-p2mp[28688]: SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_UPDATE,ifconfig-ipv6 fd00:abcd:204:2::99aa/64 fd00:abcd:204:2::1' (status=1)
Sep  3 18:42:23 gentoo tun-udp-p2mp[28688]: MULTI: Learn: fd00:abcd:204:2::99aa -> cron2-freebsd-tc-amd64/udp6:194.97.140.21:24508


When I try to push garbage ("blurb", aka "new options in testing"), it will
do what we agreed to do (namely, push to the client, even if the server
doesn't understand the options).

The logging could be improved...  "is not updatable, ignoring" *after*
it was already pushed?  And after that(!), an "Options error"... mmh.

Sep  3 18:39:18 gentoo tun-udp-p2mp[28688]: MANAGEMENT: CMD 'push-update-cid 41 ?blurb'
Sep  3 18:39:18 gentoo tun-udp-p2mp[28688]: SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_UPDATE,?blurb' (status=1)
Sep  3 18:39:18 gentoo tun-udp-p2mp[28688]: Pushed dispensable option is not updatable: '?blurb'. Ignoring.
Sep  3 18:39:18 gentoo tun-udp-p2mp[28688]: Options error: Unrecognized option or missing or extra parameter(s) in [PUSH-OPTIONS]:1: blurb (2.7_alpha3)

Sep  3 18:40:15 gentoo tun-udp-p2mp[28688]: MANAGEMENT: CMD 'push-update-cid 41 blurb'
Sep  3 18:40:15 gentoo tun-udp-p2mp[28688]: SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_UPDATE,blurb' (status=1)
Sep  3 18:40:15 gentoo tun-udp-p2mp[28688]: Pushed option is not updatable: 'blurb'.
Sep  3 18:40:15 gentoo tun-udp-p2mp[28688]: Failed to process push update message sent to client ID: 1

.. for the non-optional option (no "?"), it pushes just fine, no
"Options error", but then a "Failed to process".

This is okayish to have the functionality in 2.7_beta1 so it can be tested
more, but this needs more work.  As does the fat TODO for unlearning IPs.



With all the changes to manage.c in the last days, the patch needed
a bit of massaging to go in (multi.h was added -> conflict, things
like that).  I also fixed/ignored a few stray newline changes, and
reformatted the big comment blob with too-long lines in push_util.c

Your patch has been applied to the master branch.

commit c598efc405b7a47ae66f7f78e455e2902b76ce88
Author: Marco Baffo
Date:   Wed Sep 3 18:48:20 2025 +0200

     PUSH_UPDATE message sender: enabling the server to send PUSH_UPDATE control messages

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250903164826.13284-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32807.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


