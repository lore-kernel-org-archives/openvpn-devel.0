Date: Thu, 3 Jun 2010 17:46:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100603154619.GD26982@...1296...>
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
	<1275576515.23148.829.camel@...1259...>
Mime-Version: 1.0
In-Reply-To: <1275576515.23148.829.camel@...1259...>
Subject: Re: [Openvpn-devel] [PATCH] Re: Handling of subnets grammar in
	Packet filter file
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
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Jun 03, 2010 at 04:48:35PM +0200, chantra wrote:
> Please find below a patch to correct the behaviour.
> 
> I have also opened a trac ticket :
> https://community.openvpn.net/openvpn/ticket/14

The patch itself looks good.

It's a bit of a philosophical issue what to do with network specifications
given like this - one approach would be to *reject* as a config error
("a /28 network cannot start at .8"), the other approach is what you have
done, to silently mask out the host bits, changing the .8/28 to .0/28.

Both have merits, your fix is somewhat less code then adding an extra input
validation check 

  if ((network.s_addr & netmask) != network.s_addr )  
    { complain; }

- so: ACK from me.

(Since OpenVPN likes to print warnings, we *could* add code to print a 
warning in this case - "warning: subnet address changed to match /%d,
new value is %s/%d").

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

