From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16647.429.453589.272763@...253...>
Subject: Re: [Openvpn-devel] Re: [PATCH - 4 of 4]  support new option "net-type"
In-Reply-To: message from James Yonan on Tuesday July 27
References: <16645.49196.829476.656946@...253...>
	<twig.1090918723.37830@...41...>
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
Date: Tue Jul 27 18:31:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday July 27, jim@...41... wrote:
> Neil,
> 
> Comments Inline below...
> 
> Neil Brown <neilb@...253...> said:
> 
> > 
> > 
> > As was hinted at with the previous patch, this patch introduces a new
> > config option "net-type".  It can be either "ptp" or "subnet".
> > 
> > If net-type is not explicitly given then:
> >   if "dev" is "tun", "net-type" will be "ptp"
> >   if "dev" is "tap", "net-type" will be "subnet"
> > 
> > If it is given, then it overrides that default.
> > 
> > Probably the most useful usage is to set "net-type subnet" when
> > using  "dev tap".
> 
> I'm not sure I understand this.  Doesn't current OpenVPN usage associate dev
> tap interfaces with subnet-based networks?

Uhmm.. yes.  I keep confusing "tap" and "tun".
I should have said:

   Probably the most useful usage is to set "net-type subnet" when
   using  "dev tun".


> 
> > This allows you to have a simple subnet of all openvpn clients talking
> > to a given server, and provides some guarantees that only the client
> > allocated a particular IP address will be able to use it.
> 
> Can you post any config file examples showing how you would use this?
> 

On the server I have:
    mode server
    dev tun
    net-type subnet
    ifconfig 129.94.33.129 255.255.255.128
    ifconfig-pool 129.94.33.132 129.94.33.254
    push "route-gateway 129.94.33.129"

(I'm using a 7bit subnet for this vpn)
On the client I have

    dev tun
    net-type subnet
    pull
    

> > I'm am not sure how this will work with OPENBSD, NETBSD, or DARWIN as
> > tun.c doesn't seem to be able to ifconfig these with subnets.  It
> > definitely works for Linux and should work for WIN32 and FREEBSD.
> 
> For portability with tun interfaces across various OSes, OpenVPN tries to
> treat them all as being point-to-point interfaces, rather than allowing (as
> some OSes do) a subnet mask to be assigned to a tun endpoint.

I've thought a bit about this...
I think that a subnet interface can be emulated use a strictly
point-to-point interface by simply adding a route to the subnet
through the interface.
i.e.
   ifconfig tun0 10.0.0.1 pointopoint 10.0.0.2 netmask 255.255.255.0
is equivalent to
   ifconfig tun0 10.0.0.1 pointopoint 10.0.0.2
   route add net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.2
which should work on any OS.

This should allow you to configure a tun interface with an effective
subnet mask anywhere.


thanks,

NeilBrown

