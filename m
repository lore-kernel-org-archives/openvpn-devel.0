Date: Thu, 04 Jun 2009 22:59:53 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <16130.65.118.50.246.1232730850.squirrel@...1166...>
	<24624.65.118.50.246.1244149998.squirrel@...1166...>
In-Reply-To: <24624.65.118.50.246.1244149998.squirrel@...1166...> (from
	Progman2000@...1085... on Thu Jun  4 16:13:18 2009)
Message-Id: <1244174393l.6685l.3l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Loss of routes causes routing loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Daniel Johnson <Progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net


On 06/04/2009 04:13:18 PM, Daniel Johnson wrote:

> On a related note, I'm looking at adding a second interface on the two
> main (and now only) VPN servers, so that they'll be 'local' on the
> guest/wireless network.  Does OpenVPN do anything special with DNS
> results to prefer local addresses?  If not, can that be added easily?

Openvpn does not do DNS at all.  You can use it to push DNS related
DHCP options to the "clients" so that they are directed to a DNS
server that does the right thing.  (There may be a way to
do something similar in a "client-side" config, I don't recall.)
That's about it.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

