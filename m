From: James Yonan <jim@...3...>
Subject: Re: [Openvpn-devel] Default MTU
In-Reply-To: <1026111778.1445.4.camel@...2...>
Message-ID: <Pine.LNX.4.44.0207091351170.26064-100000@...21...>
MIME-Version: 1.0
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
Date: Tue Jul  9 13:01:02 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

On 8 Jul 2002, Jan Johansson wrote:

> On Sun, 2002-07-07 at 22:19, James Yonan wrote:
> > What should the default MTU be?
> > 
> > Right now the default UDP MTU is 1500 if you use --ifconfig, which is
> > probably too high, because as Matthias Andree pointed out, 1500 + IP header
> > size is greater than 1500 and will cause fragmentation on ethernet networks
> > where the MTU is 1500.
> > 
> > 1450 might make more sense because that leaves ample space for the IP
> > header, forming a total packet size of less than 1500.
> 
> > So at this point a static default is certainly the simpler way to go, but
> > any changes to the static default should be carefully considered since they
> > would introduce backward incompatibility issues.
> 
> I'd go for 1300 or so. Even if 1450 works now, you could still encounter
> more issues later that require another change. I don't think the
> performance loss will be that great, since all that run TLS now with
> 1500-ish packetsizes probably already split lots of packets into one
> large and one tiny packet as it is.

I'm inclined to agree that the default MTU should be set conservatively 
low so it has a high probability of working, even if it is slightly less 
efficient.

Once somebody has a setup working, they will be in a better position to 
optimize the MTU to their liking.
 
> If you are to go for new major version that breaks compat, go for lower
> defaults on MTU too. You might aswell backport some sort of small logic
> for the older OpenVPN-track that tries the lower MTU in case it seems
> like it doesn't work, or a "--compat-v2" setting.

I plan to increment the version number to 1.3.0 due to the default MTU
change, though there won't be any other breaks in compatibility, and of 
course 1.3.0 will be able to talk to previous versions simply by defining 
MTU size explicitly in the config.

James



