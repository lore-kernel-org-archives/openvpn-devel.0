From: Jon Nelson <jnelson-openvpn@...135...>
Subject: Re: [Openvpn-devel] OpenVPN multi instancing
In-Reply-To: <twig.1078170122.8125@...41...>
Message-ID: <Pine.LNX.4.58.0403011637070.30913@...136...>
References: <twig.1078170122.8125@...41...>
Mime-Version: 1.0
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
Date: Mon Mar  1 14:43:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Christian Daniel <cd@...154...>, openvpn-devel@lists.sourceforge.net

On Mon, 1 Mar 2004, James Yonan wrote:

> Christian Daniel <cd@...154...> said:
>
> > Hello everybody!
> >
> > For a student research project I'm trying to add multi instance capability to
> > OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all
> > variables in a struct and then have only one select()-call for all open
> > tunnels at once.
>
> It's already been done :)
>
> See the BETA20 branch in the CVS.
>
> Having said that, I think it's great that you want to contribute to the code,
> and there's still a lot of work yet to be done.
>
> > Then there should be one unix-socket which can be connected by some
> > to-be-written control-application, which manages the tunnels. In detail it
> > should be possible to add and remove tunnels on demand just by sending the
> > appropriate config down that unix-socket.
> >
> > Each tunnel should have it's own tun/tap-device open - the linux kernel has no
> > problem to cope with so many interfaces... I don't think, that it's a good
> > idea, to create only one tun-device and then have some kind of internal
> > routing-engine...
>
> The current plan for 2.0 is to also handle the case of multiple tunnels
> through a single tun/tap interface.  This will scale better overall, and will
> be necessary on some platforms such as Windows which cannot efficiently handle
> a large number of tun/tap interfaces.
