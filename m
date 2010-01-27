Date: Wed, 27 Jan 2010 09:17:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100127081723.GJ857@...1296...>
References: <4B5E2895.4030906@...1299...> <1264523745.26411.1@...1207...>
	<4B5F33E4.5080508@...1299...> <4B5FB064.3070308@...1299...>
Mime-Version: 1.0
In-Reply-To: <4B5FB064.3070308@...1299...>
Subject: Re: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
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
To: Jason Haar <Jason.Haar@...1299...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, Jan 27, 2010 at 04:17:56PM +1300, Jason Haar wrote:
> Confirmed. I have a server running on 1194 tcp and udp and 

Is this a single server listening on both ports, or is this two independent
servers?

(For a customer installation, I need a single server to listen on UDP/1194 
and TCP/443, and as far as I understood so far, this was not possible)

If this is indeed not possible yet, is anybody working on this?  I might
be tempted to tackle it, but would prefer to avoid duplicate work.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

