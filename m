Date: Fri, 17 Oct 2025 22:29:32 +0200 (CEST)
Message-Id: <202510172029.59HKTWqI093676@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251017201916.21697-1-gert@...1296...>
References: <20251017201916.21697-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: remove old
 IP(s) from vhash after sending a message containing ifconfig(-ipv6)
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

So - threw this into the server/client test, which absolutely does not
excercise the code paths changed here (but it ensure that nothing else
gets broken).  Then, used one of the server instances to PUSH_UPDATE
ifconfig/ifconfig-ipv6 changes (A->B->C and A->B->C->nothing->B and
"IPv6 to nothing, IPv4 to B" in the same message) and it was all very
well behaved, and the logging is nicely symmetric as well

     MULTI: Unlearn: fd00:abcd:204:2::100a -> freebsd-14-amd64/udp6:...
     MULTI: Learn: fd00:abcd:204:2::9999 -> freebsd-14-amd64/udp6:...
     MULTI: Unlearn: fd00:abcd:204:2::9999 -> freebsd-14-amd64/udp6:...
     MULTI: Unlearn: 10.204.2.99 -> freebsd-14-amd64/udp6:...
     MULTI: Learn: 10.204.2.146 -> freebsd-14-amd64/udp6:...

(we tried to make this use the mi prefix, but as "Learn" is not using
it, it looked silly - this way in v5+ is nice).

Oh, yes, and I stared long and hard at the code and asked for lots of
changes :-) so this has been scrutiniced quite a bit.

I did not test --learn-address, tbh.  But the code looks like all the
other invocations, so I assume it will work.

Nice side bonus - the mail-archive list is actually talking to me again,
for a change, so I can proper reference the patch.

Your patch has been applied to the master branch.

commit 5e4c9a69eaf9d32e85613bd71ed219fdbb062d34
Author: Marco Baffo
Date:   Fri Oct 17 22:19:12 2025 +0200

     PUSH_UPDATE server: remove old IP(s) from vhash after sending a message containing ifconfig(-ipv6)

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1253
     Message-Id: <20251017201916.21697-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33412.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


