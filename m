From: Gergely Czuczy <gergely.czuczy@...2052...>
Message-ID: <55CA09E0.3020503@...2052...>
Date: Tue, 11 Aug 2015 16:42:40 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I would like to ask some help, I'm looking at the OpenVPN source tree
from GitHub as I would like to see how much effort would it be me to add
SRV record support, as it has increasing demand these days (and really
makes sense, especially for enterprises).

So, the question is, what would be the best place to hook up the support
for SRV records?
SRV record mechanism/requirements are the following:
  - It's protocol-specific, so at lookup time it has to be known whether
it's for UDP or TCP
  - The SRV records supply the service port, so in this case it's not
taken from the configuration file.
  - Basically for a service it's one or more DNS records in the
following format:
   _service._proto.name. TTL class SRV priority weight port target.
   I guess _service should be _openvpn, _proto is either _tcp or _udp.
port is obvious, and target is the target host to connect to using the
previously specified port.
   If there are multiple records, then priority makes sense, first the
hosts with the lowest values have to be tried, then rest increasingly
   If there are multiple hosts with the same priority then weight kicks
in, a host to be chosen is determined by the weight factors. Attempts to
a different priority can be made after all hosts from this priority are
exhausted.

So, basically first there has to be a lookup against the server's SRV
record, once that lookup returned results, and the priority/weight
algorithm returns the first candidate, the existing connection mechanism
can be used to check it. If it succeeds, life goes on as it is
currently, if it fails, then the prio/weight algorithm's next target has
to be tried.

So, where should I be looking at the source that would probably be a
good place to hook this up?

Thanks in advance,
Gergely

PS: Please see the wikipedia article on SRV records:
https://en.wikipedia.org/wiki/SRV_record



