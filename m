From: James Yonan <jim@...3...>
In-Reply-To: <20020708124042.GE12659@...33...>
Message-ID: <Pine.LNX.4.44.0207081155210.18949-100000@...21...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: OpenVPN and UDP fragmentation
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon Jul  8 11:00:04 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...32...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 8 Jul 2002, Matthias Andree wrote:

> On Tue, 02 Jul 2002, James Yonan wrote:
> 
> > At one point I considered using adaptive code to automatically set the
> > MTU, then I read a paper that described various DoS attacks against common
> > path MTU discovery algorithms, so I held off on that.
> 
> Is not the kernel itself also susceptible in that case unless PMTU
> discovery is disabled for that route?

Right, you would need to set the Don't Fragment bit in the socket to 
disable the kernel's PMTU then implement your own secure PMTU.

> 
> OTOH, I haven't read a single paper on PMTU discovery DoS attacks, so
> I cannot comment on the details.

http://www.off.net/~jme/ietf/draft-etienne-secure-pmtud-00.txt

> 
> > It would be great if there was an easy way of getting the dynamic path MTU 
> > from the OS, but I'm not aware of any portable method to do this.
> > 
> > While reducing the default to 1472 or lower might work, it would also
> > break compatibility...  right now we can brag that the protocol hasn't
> > changed since 1.1.0, and while this isn't really a protocol change, it
> > does introduce a slight incompatibility with prior versions.  I would
> > prefer to hold off on patches that break compatibility until 1.3.0.
> 
> Sure. Documenting that the admin who sets up OpenVPN should experiment
> with the UDP-MTU and lower it until no fragmentation occurs is fine with
> me.
> 
> > > If OpenVPN adapting the UDP MTU, I'd appreciate if the adaption progress
> > > would be logged akin to LZO adaption.
> > 
> > There is a common algorithm known as Path MTU Discovery where you set the 
> > Don't Fragment bit on the socket then figure out by heuristics the largest 
> > packet size that will get through.  But it would be better to let the OS 
> > figure this out and then tell us in a portable way, if this is possible.
> 
> Yes. I recently made some experiences with obtaining interface/netmask
> configuration. Don't try this for IPv6, it'll boggle your mind. Each
> system has its own approach. Netlink, a "long" SIOCGIFNETMASK variant,
> whatever.
> 
> > > Again, please apologize if I wrote nonsense, I'm not really aware of the
> > > packet encapsulation and framing process in OpenVPN.
> > 
> > No, your ideas are good.  In fact I would vote that we move these 
> > discussions to openvpn-devel so that more people can participate.
> 
> OK, I'll look at that list then. Feel free to bounce this mail and my
> last one there so people know what we're talking about.
> 
> Thanks,
> 
> 


