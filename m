Date: Wed, 27 Jan 2010 10:49:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100127094923.GK857@...1296...>
References: <4B5E2895.4030906@...1299...> <1264523745.26411.1@...1207...>
	<4B5F33E4.5080508@...1299...> <4B5FB064.3070308@...1299...>
	<20100127081723.GJ857@...1296...>
	<4B5FFA05.70504@...1299...>
Mime-Version: 1.0
In-Reply-To: <4B5FFA05.70504@...1299...>
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

On Wed, Jan 27, 2010 at 09:32:05PM +1300, Jason Haar wrote:
> On 01/27/2010 09:17 PM, Gert Doering wrote:
> > Is this a single server listening on both ports, or is this two independent
> > servers?
> 
> server running openvpn on tcp:1195 and udp:1195

So it's two independent processes.

> > (For a customer installation, I need a single server to listen on UDP/1194 
> > and TCP/443, and as far as I understood so far, this was not possible)
> 
> Yeah - can't be done. However, my problem is a client problem - you
> sound like having a server problem. "nobind" only works in client mode

Yes, sorry for hijacking your thread.  Your remark about the server setup
made me curious, so I jumped in.

Can't help you with the client problem, though.

> If you're using tun interfaces,  you'll need to split your pool range
> between the two instances.

Or extend the code to make "listen on multiple ports" possible.

From a cursory glance, it won't be easy, as the code is full of special
cases (blocking/non-blocking, udp/tcp, client/server side, all somewhat
intermixed) and it will certainly require changes to data structures
and to the MULTI code as well.  Oh well.  Let's see what time brings.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

