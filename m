Subject: Re: [Openvpn-devel] [PATCH - 3 of 4]  separate "net-type" from
	"interface-type"
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <16645.48660.718636.245182@...253...>
References: <16645.48660.718636.245182@...253...>
Message-Id: <1090910369.3382.14.camel@...257...>
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
Date: Mon Jul 26 23:38:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Di, den 27.07.2004 schrieb Neil Brown um 4:29:

> I want to use tun devices (as I am only interested in IP traffic, and
> I want some checking of source IP address to be done) but I want to
> treat the collection of openvpn instances (the server and several
> clients) as a single subnet.
> A particular advantage of this is that ifconfig-pool can hand out
> individual IP addresses to clients instead of 2-bit subnets.

This is exactly what I needed for a special use-case, where I hand out
IP addresses, which are not private ones, but real internet IPs and
where I can afford to assign more than one IP to one client and not a
subnet (see my mail from 10th of June). I also have to be sure that none
of the clients is changing its source address.

Interesting would be whether it would be possible to allocate a new tun
device to every new client. This would have some impact on how to handle
queing disciplines on single openvpn connections. One could then handle
this like PPTP connections, where a separate ppp device is allocated for
each client.

Personally I currently don't have time to dive into the code. Can
somebody give a rough estimate on how much work that would be?

-- 
Torge Szczepanek <openvpn-devel@...239...>


