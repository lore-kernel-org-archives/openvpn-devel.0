Subject: Re: [Openvpn-devel] OpenVPN multi instancing
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078170122.8125@...41...>
In-Reply-To: <200402291538.45014.cd@...154...>
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
Date: Mon Mar  1 11:47:07 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christian Daniel <cd@...154...>, openvpn-devel@lists.sourceforge.net

Christian Daniel <cd@...154...> said:

> Hello everybody!
> 
> For a student research project I'm trying to add multi instance capability to 
> OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all 
> variables in a struct and then have only one select()-call for all open 
> tunnels at once.

It's already been done :)

See the BETA20 branch in the CVS.

Having said that, I think it's great that you want to contribute to the code,
and there's still a lot of work yet to be done.

> Then there should be one unix-socket which can be connected by some 
> to-be-written control-application, which manages the tunnels. In detail it 
> should be possible to add and remove tunnels on demand just by sending the 
> appropriate config down that unix-socket.
> 
> Each tunnel should have it's own tun/tap-device open - the linux kernel has no 
> problem to cope with so many interfaces... I don't think, that it's a good 
> idea, to create only one tun-device and then have some kind of internal 
> routing-engine...

The current plan for 2.0 is to also handle the case of multiple tunnels
through a single tun/tap interface.  This will scale better overall, and will
be necessary on some platforms such as Windows which cannot efficiently handle
a large number of tun/tap interfaces.

> My main problems so far are:
> - which code-base should I use? Should I start with 1.5 oder should I take 
> code from CVS? CVS means shooting on a moving target...
> - how to handle the garbage collection? Is it really necessary or is the code 
> leak-free?

The ./configure script has some options for leak checking -- right now the
code doesn't have any known leaks.

The gc_* functions provide a simple GC infrastructure where the code defines a
series of hierarchical scopes, and GC allocated storage only stays alive
within it's own scope or scopes below it (think of it as a kind of cross
between a stack and a heap).  The main issue to keep in mind is that each
thread needs its own gc_thread struct.  

> Is there any interest here to support that project? We will do it because it 
> is out assignment - and we will finish it :)

Certainly, though I think if you want to contribute to the code, we should try
to minimize overlap.

One area that currently needs some work is getting IPv6 working everywhere in
the code.  Right now OpenVPN supports IPv6 over IPv4 tunnels, but it would be
nice if the tunnel itself could run over IPv6.  This would involve modifying
socket.[ch] to be comfortable with IPv6.

Also keep in mind that the 1.5 and 1.6 branches are relatively stable at this
point and won't be accepting new patches except bug fixes and very simple,
localized patches.  All the big stuff is going into 2.0 which will be a fast
moving target for the next few months.

James


