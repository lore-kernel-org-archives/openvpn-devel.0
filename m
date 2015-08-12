References: <55CA09E0.3020503@...2052...>
	<20150811191949.GJ382@...1296...>
From: Gergely Czuczy <gergely.czuczy@...2052...>
Message-ID: <55CB0817.4010503@...2052...>
Date: Wed, 12 Aug 2015 10:47:19 +0200
MIME-Version: 1.0
In-Reply-To: <20150811191949.GJ382@...1296...>
Subject: Re: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 2015-08-11 21:19, Gert Doering wrote:
> Hi,
>
> On Tue, Aug 11, 2015 at 04:42:40PM +0200, Gergely Czuczy wrote:
>> I would like to ask some help, I'm looking at the OpenVPN source tree
>> from GitHub as I would like to see how much effort would it be me to add
>> SRV record support, as it has increasing demand these days (and really
>> makes sense, especially for enterprises).
> Can you elaborate a bit more on why SRV makes sense?  To my naive thinking,
> the amount of stuff you have to put into the client profile anyway is
> so large (like CA cert etc) that the remaining gain is fairly small...
Sure thing. With a buzzwordish approach, I would say it enables more 
enterprise-level configurations,
regarding redundancy, connection optimization and such things.
Technically speaking, with SRV records you are able to centrally manage 
a set of servers where your clients
will be connecting to, including the order in which the clients should 
try them. Including, but not limited to,
this opens the door for the following things:
  - Connection preferences are centrally set, without having to have 
access to client configuration files. So changes can
be made centrally, and in case of high number of clients (like 100+ or 
so) you can just adjust your DNS records, and
everyone's connection configuration will be adjusted to the changes. 
Good for managing a huge number of road warriors.
  - It enables you to define the redundancy of the OpenVPN endpoints 
centrally, change the number of your servers in your
OpenVPN clusters, without having to touch the client configuration 
files. Therefore you can centrally define the load balancing
of your OpenVPN servers (weight field), and in case of that site being 
down, clients will be able to automatically fall back to
your backup location (priority field).

Let me give a real world example, that's actually what I would like to 
implement by this. Imagine having a not so big firm, but
with a global presence, meaning datacenters on many continents connected 
to each other, like North America, Europe, and Asia regions, and also
having offices at these locations. Add GeoDNS to the mix.

By OpenSRV records, and GeoDNS support, the following can be achieved:
  - Every user on each continent is getting a geographically optimized 
set of SRV records, for example:
In NA, the order of DCs (per continent) is: NA, EU, APAC (Asia and Pacifics)
In EU: EU, NA, APAC
In APAC: APAC, NA, EU
  - Each SRV priority level weights the  OpenVPN endpoints by their 
capacity.
  - By these things, every user is connecting to the nearest openvpn 
server to his or her location, therefore
reducing the network latency added by longer distance VPN connections.
  - Client configurations require no local modification for adjustments, 
since it's done centrally on the DNS server by
changing the SRV records
  - If any of the servers are down, clients are redirected automatically 
to the next server in the region. If the region's VPN
servers are all experiencing issues, they are going for the second best 
region's server, and so on.

Therefore with this setup a truely redundant, reliable and robust setup 
is possible, along with minimizing the maintenance costs
by being able to adjust the client connection preferences centrally 
through DNS. The only time a client's config needs to be touched
is at certificate renewal time.

Regarding CAs and certs, personally I do not think that is an issue, 
since all the servers listed for an SRV record set belong to the same 
cluster,
therefore they share the same CA path.

I hope this explanation was clear, and the idea behind makes more sense 
now. Please let me know if I should elaborate on some parts.

Regards,
-czg


