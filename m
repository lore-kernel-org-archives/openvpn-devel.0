From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] GUI for MacOS X
In-Reply-To: <loom.20041210T063317-259@...171...>
Message-ID: <Pine.LNX.4.58.0412092259480.3257@...41...>
References: <loom.20041210T063317-259@...171...>
MIME-Version: 1.0
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
Date: Thu Dec  9 22:23:06 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Steve Palm <n9yty@...325...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 10 Dec 2004, Steve Palm wrote:

> Greetings!
> 
> For the past week or so I've been working on a GUI client for MacOS X. 
> I just happened to check the website today and saw the new release with
> the management interface. VERY COOL, and this will make my life MUCH
> easier.  I had saved the process of looking at all the return strings
> for last to parse them from the running process, now I have a much
> smaller set of things to worry about. ;-)
> 
> One question, though...  Is there a way to have all of the information
> in a config file yet when you start the openvpn program it won't build
> the tunnel until it gets a "go" from the management interface?  The
> trouble I'm trying to avoid is that there is an indeterminate amount of
> time between telling the openvpn client instance to launch and being
> able to connect to the management interface port.  I don't want to loose
> the messages I might need during that interval.

That sort of already happens now if you use --management-query-passwords 
-- though I agree it would be useful to have a more generic mechanism for 
starting OpenVPN in a hibernated state until it receives a "start" message 
from the mangagement interface.

> I suppose I could do "state all on" and parse the two 
forms (immediate
> feedback and real-time notifications), but it would be much simpler to
> fire the openvpn process, wait a second or two for it to stabilize, then
> try to connect at which point I just do a "state on" and "start tunnel"
> or something.
>
> Also, which of the multitude of configuration options would be most
> useful to put into a GUI?  Right now I have an embedded template config
> file (which can be edited) that has placeholders for values the  GUI
> will fill in.  I'm using:  host, port, protocol, http-proxy-host,
> http-proxy-port, and a management routine that stores certificates,
> allows you pick which certs go with which configs, etc...  I've modelled
> the thing almost entirely visually after the program IPSecuritas (a free
> IPSec client for MacOS X) because we're migrating from IPSec to OpenVPN
> and I wanted it to be as transparent to our users as possible.
> 
> Anyway, awesome work, and I look forward to feedback on making the MacOS
> X GUI as good as I'm able to. :-)

Cool, are you going to focus on the client side only, or make the GUI 
capable of driving an OpenVPN server daemon as well?  (The management 
interface supports both).

James

