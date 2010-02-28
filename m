Date: Sun, 28 Feb 2010 15:59:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228145915.GN9556@...1296...>
References: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Allow 'lport 0' setup for random port
	binding
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Enrico Scholz <enrico.scholz@...1291...>, David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 02:44:14PM +0100, David Sommerseth wrote:
> I am running a multihomed host where 'local <extip>' must be specified
> for proper operation.  Unfortunately, this implies 'lport 1194' or
> another static port.
> 
> This causes problems with stateful firewalls which register the host/port
> pairs in the internal connection tracking table. On ungraceful reconnects,
> the new TCP connection will have same the host/port pairs but unexpected
> sequence numbers. The new connection will be assumed as invalid hence and
> be dropped.
> 
> It would be nice when local port can be configured to be bound to a
> random port number.  After reading code,

I have not found a reference anywhere that documents that bind() can
be used with port=0 to tell the system "bind to the IP address, but 
still use a random port".  It seems to work though, and the code elsewhere
does not seem to make any assumptions about "port != 0" (it is effectively
just passed to bind(), and if bind() doesn't like it, an error exit occurs).

Since it fixes a real-world problem, there is obvious need for it.

-> ACK.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

