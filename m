Subject: Re: [Openvpn-devel] OpenVPN multi instancing
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078553650.41564@...41...>
In-Reply-To: <20040302100927.GC7417@...33...>
References: <200402291538.45014.cd@...154...>, <200402291538.45014.cd@...154...>
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
Date: Fri Mar  5 22:22:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Sun, 29 Feb 2004, Christian Daniel wrote:
> 
> > Hello everybody!
> > 
> > For a student research project I'm trying to add multi instance capability to 
> > OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all 
> > variables in a struct and then have only one select()-call for all open 
> > tunnels at once.
> 
> Oh. You're in for plentiful fun with the various select()
> "features"^Wbugs across the various operating system kernels.
> 
> Better check out poll() and epoll() where available. These happen to
> (usually) be more scalable as the number of fds increases.

Luckily, UDP scales up fairly well without hitting up against the limitations
of select() since a single UDP socket can be used to communicate with an
unlimited number of clients.  TCP will be harder to scale with select()
because every incoming client will need its own socket.

I don't see how poll() is that much of an improvement over select() because it
still requires that you scan all the FDs to see which ones require service.

epoll() looks like a real improvement, and has obviously been designed with
scalability in mind.

It's too bad that poll and epoll move the timeout from microsecond to
millisecond resolution, as that makes things like traffic shaping harder to
implement.

James


