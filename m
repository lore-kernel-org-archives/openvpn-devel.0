Date: Thu, 3 Jun 2010 20:14:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100603181401.GG26982@...1296...>
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
	<1275576515.23148.829.camel@...1259...>
	<20100603154619.GD26982@...1296...>
	<loom.20100603T180754-260@...171...>
	<173DB246-2AFC-45C6-A61B-DC970220BB2D@...1286...>
Mime-Version: 1.0
In-Reply-To: <173DB246-2AFC-45C6-A61B-DC970220BB2D@...1286...>
Subject: Re: [Openvpn-devel] [PATCH] Re: Handling of subnets grammar
	in	Packet filter file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Eric F Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net, chantra <chantra@...1258...>

Hi,

On Thu, Jun 03, 2010 at 12:47:47PM -0500, Eric F Crist wrote:
> > I upated the patch and it will now display something like:
> > WARNING: PF: /dev/shm/openvpn_pf_ff18e7030fd03ce91bd0432563e4eb1a.tmp/5: 
> > incorrect subnet 192.168.100.8/28 changed to 192.168.100.0/28
> 
> This seems rather pedantic to me...

Well, it is, but it's in line with the rest of OpenVPN - there are many
places where a (percieved) user error results in a warning, explaining
the situation...

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

