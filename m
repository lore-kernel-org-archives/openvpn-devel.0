Message-ID: <9e0cf0bf0801261358q2f401a99qb7eb6a34f8bf548e@...278...>
Date: Sat, 26 Jan 2008 23:58:21 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <9e0cf0bf0801251544s6a13dbfdx1148dd15d74e282a@...278...>
MIME-Version: 1.0
References: <4797B53E.4020007@...41...>
	<20080125170022.GA23938@...611...>
	<9e0cf0bf0801251057o42f15467g422a97500d349e95@...278...>
	<9e0cf0bf0801251544s6a13dbfdx1148dd15d74e282a@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Steven Pritchard <steve@...609...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

iproute2 was fixed at latest git... No infinite loop anymore...
But it will take much time until it pushed into users...

On 1/26/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Well...
> From: http://bugs.gentoo.org/show_bug.cgi?id=207320, found out that:
> When executing:
> ip addr flush dev XXXX
> On unprivileged user, you get infinite loop of iproute2... Reported
> this to upstream.
> So I had to workaround this using explicit del.
>
> -r 2677:2682 https://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-userpriv-fixups
>
> On 1/25/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> > Thanks!
> > I was not aware of the null tun.
> > The following should fix the problem.
> >
> > -r 2677:2679 https://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-userpriv-fixups
> >
> > Alon.
> >
> > On 1/25/08, Steven Pritchard <steve@...609...> wrote:
> > > Trying to build the Fedora package for rc6, I'm getting an error from
> > > %check, which basically does this:
> > >
> > >   ./openvpn --config sample-config-files/loopback-client &
> > >   ./openvpn --config sample-config-files/loopback-server
> > >   wait
> > >
> > > I'm getting the following error:
> > >
> > >   Thu Jan 24 14:15:33 2008 /sbin/ip addr flush dev null
> > >   Device "null" does not exist.
> > >   Thu Jan 24 14:15:33 2008 Linux ip flush failed: shell command exited with error status: 255
> > >
> > > Full build log here:
> > >
> > >   http://koji.fedoraproject.org/koji/getfile?taskID=370966&name=build.log
> > >
> > > Steve
> > > --
> > > Steven Pritchard - K&S Pritchard Enterprises, Inc.
> > > Email: steve@...610...             http://www.kspei.com/
> > > Phone: (618)624-4440               Mobile: (618)567-7320
> > >
> > > -------------------------------------------------------------------------
> > > This SF.net email is sponsored by: Microsoft
> > > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > > _______________________________________________
> > > Openvpn-devel mailing list
> > > Openvpn-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >
> >
> >
>
>

