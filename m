Subject: Re: [Openvpn-devel] route option only adds route for first IP resolved for a hostname (with many)
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078954854.42834@...41...>
In-Reply-To: <200403101805.21043.jrh@...176...>
References: <20040310160714.GA1152@...30...>, <20040310160714.GA1152@...30...>
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
Date: Wed Mar 10 13:52:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Juan Rodriguez Hervella <jrh@...176...>, openvpn-devel@lists.sourceforge.net
Cc: Alberto Gonzalez Iniesta <agi@...5...>

Juan Rodriguez Hervella <jrh@...176...> said:

> On Wednesday 10 March 2004 17:07, Alberto Gonzalez Iniesta wrote:
> > Hi James et all,
> >
> > I have just got this bug report [1]. The problem is: When a hostname is
> > given to the 'route' option, only a route to the first IP address for that
> > hostname is added.
> >
> > route(8) works the same way, and I don't know if this is really a bug,
> > or The Way is Meant to Be (tm).... Any thoughts?
> >
> >
> >
> > [1] http://bugs.debian.org/237251
> 
> Hi Alberto!
> 
> After reading the bug track, it seems to me that he/she is right,
> and the --route command should add all the addresses returned by
> the query. It's not a hard thing to implement, imho.

Yes, this is a limitation in the current code -- all address resolution in
OpenVPN is handled in the getaddr function in socket.c which doesn't (yet)
deal with DNS names which resolve to multiple addresses.

James


