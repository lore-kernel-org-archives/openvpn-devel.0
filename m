Message-Id: <200208271919.g7RJJHG08520@...41...>
Subject: Re: Fwd: [Openvpn-devel] Fwd: Bug#158404: openvpn: Improper error handling
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.44.0208271338280.3300-100000@...42...>
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
Date: Tue Aug 27 12:20:10 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Richard A Nelson <cowboy@...39...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Richard A Nelson <cowboy@...39...> said:

> On Tue, 27 Aug 2002, James Yonan wrote:
> 
> > Hello Richard,
> 
> Hi, thanks for the quick feedback
> 
> > Normally we shouldn't get EAGAIN in the UDP read loop because we block on select and don't call recvfrom until there is a datagram waiting for us.  So the fact that you are getting a lot of EAGAIN messages is interesting and probably indicative of some kind of problem.  Is there any correlation between the EAGAIN floods and some sort of real world factor such as a bad or congested network condition?
> 
> Its hard to reproduce, but congestion is definitely a possiblity
> 
> > If EAGAIN is received from recvfrom (or any other error for that matter), it is syslogged and the select event loop continues.  So your potential solutions 1 and 2 below are already being done.  Solution 3 doesn't work because OpenVPN is too asynchronous to be able to block on a single i/o call.  That's why we use select instead.
> 
> I thought that #3 might be out of the question, and I'm glad to know
> that the IO is indeed retried
> 
> > Also, floods of non-fatal error returns from recvfrom are generally logged for informational purposes, but can be controlled by the --mute option so as not to clog up the log files.
> 
> I'll keep that in mind, but for now I think I'll keep the verbosity to
> help in tracking
> 
> > You also mention that sometimes the session drops.  What do you mean?  Does OpenVPN crash or exit?  Does it try to renegotiate?  Does the tunnel die for a while and then come back?  What kind of encryption mode are you running in (Static Key, TLS, or cleartext)?
> 
> The tunnel seems to survive, but any open telnet/ssh/etc. session over
> it timeout and die.

Unfortunately, OpenVPN doesn't have control over the timeouts of application protocols that run over the tunnel.

So if there's a network outage, though OpenVPN will almost certainly recover when the network comes up, applications with connections on the tunnel may time out.

> 
> For now, I'm using a static key, but would like to move to certificates.
> 
> > Since I don't know how to reproduce this, I'll need more details.
> 
> It happens here every other day or so, I'll be glad to provide any
> information I can.
> 
> -- 
> Rick Nelson
> I can saw a woman in two, but you won't want to look in the box when I do
> 'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
> 

James


