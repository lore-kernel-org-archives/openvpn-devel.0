Message-ID: <54833CC6.8010507@...1490...>
Date: Sun, 7 Dec 2014 06:28:38 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
Subject: [Openvpn-devel] feature request: get openvpn to use closest server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there

If you have a global network with several openvpn servers, you have a
problem with getting clients to connect to the "best" server(*).
Typically you'd either rely on users manually choosing the best server
(which they can't do well as they don't know the full story), or do
something easy like have one DNS name with multiple A records - but the
latter would mean users were using the *wrong* server the majority of
the time

Some can manage tricks using geoip DNS - but even that doesn't work
reliably (eg if a lot of users hardwire Google/OpenDNS DNS servers in
their client). Really speaking AnyCast is the only "proper" way of doing
it - but that's a "big boy" solution

So I propose openvpn itself could solve this problem - if it had some
application layer way of "pinging" all available openvpn servers and
choosing the one that responds "best". I'd suggest it only be supported
for sites using "tls-auth" but that it doesn't need the full cert check
- that way it's one packet from the client and one return packet from
the server. I'd also suggest the server can respond with a "don't use
me" message: maybe a new config option "pause-logins /path/filename" so
that sysadmins can write their own load tests and create/delete that
file when needed. The client could send "openvpn-pings" to each server
(when the DNS server name resolves to >1 IP) and try up to 3 times
before making a decision. ie packet loss means there needs to be a retry
aspect, 3 failures means the server is down/firewalled, but if the
server responds with "don't use me" then it's treated as "down" too.
Then the client can simply figure out which positive return had the
smallest latency and then use that to influence the order in which it
tries to log into the servers. ie it doesn't replace the current server
connection logic, it just re-sorts it before carrying on as usual

I also think it should be done with some "openvpn-ping" instead of icmp
ping because it confirms the server is available on the protocol/port
combination, whereas icmp doesn't

Is this something others would find useful? Cisco Anyconnect has this
feature, so it's not an original idea.

Thanks for listening

Jason


Note (*): we've run cisco vpnclient for over a decade and what we've
discovered is "best" matters. Users who vpn into the closest vpn server
get off the unpredictable Internet and onto a more
predictable/consistent WAN link - and get the benefits that implies. eg
we run VoIP internally and such a realtime application is very latency
dependent. People who vpn across continents back to their "home" vpn
router complain that VoIP is awful, whereas those that vpn'ed into the
corporate site down the road from their hotel, they get much better
realtime performance. And if they don't - the company can do something
to fix that - whereas we have no ability to improve the performance of
random hotels/countries/etc.

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


