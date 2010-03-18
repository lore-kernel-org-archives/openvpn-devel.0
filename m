Date: Thu, 18 Mar 2010 14:17:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100318131716.GH25238@...1296...>
References: <20100317225325.GE25238@...1296...>
	<4BA2191E.1080601@...1147...>
Mime-Version: 1.0
In-Reply-To: <4BA2191E.1080601@...1147...>
Subject: Re: [Openvpn-devel] Windows, OpenVPN-GUI, disconnect
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Mar 18, 2010 at 01:14:22PM +0100, Jan Just Keijser wrote:
> took me a while to figure this one out:
> the openvpn gui codes sets an 'exit event' (using a win32 API call 
> CreateEvent) before starting the actual openvpn process; when the user 
> chooses 'disconnect' this 'exit event' is triggered, which causes the 
> process to be terminated (using the appropriate win32 signal).

Huh, scary stuff.

How would that win32 signal be delivered to the openvpn.exe process?  Will
it just receive a unix-like signal "SIGTERM"?  Or does it have to poll
some sort of Windows event queue?


BTW: I just discovered that this is not limited to the openvpn.exe I 
built *on* windows, but that my linux-mingw crosscompiled openvpn.exe
does this as well now, and so does the original OpenVPN-provided 2.1.1
binary(!).  "Something weird happened to this machine", and I don't 
understand what it is.


> The question now becomes: what does openvpn do when it receives a 
> terminate signal? actually, is there a signal being sent to the server 
> to say "client X is disconnecting" ?

Nothing whatsoever visible in the logs.  The last entry in the log (verb 5)
is after successful startup:

"Initialization Sequence Complete"

... and then when pressing <disconnect>, nothing whatsoever happens.

The OpenVPN connection stays alive and healthy(!), packets continue to
get forwarded, just the signal delivery fails.

(If I increase the log verbosity to "verb 9", lots of stuff is going 
on, but nothing in there that gives any indication of signals being 
received)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

