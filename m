Message-ID: <1e6368e805011504105c962d02@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Re: Openvpn future: probably certificate problems...
In-Reply-To: <Pine.LNX.4.58.0501141932270.2801@...41...>
Mime-Version: 1.0
References: <41E67DB4.6090504@...255...>
	 <Pine.LNX.4.58.0501141932270.2801@...41...>
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
Date: Sat Jan 15 04:11:06 2005
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Didier Conchaudron <didier@...255...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net, peter@...292...

On Fri, 14 Jan 2005 20:03:57 -0700 (MST), James Yonan <jim@...41...> wrote:
> On Thu, 13 Jan 2005, Didier Conchaudron wrote:
> 
> > Hi all,
> >
> > I'm still working on a renewed openvpn service wrapper( which's heading
> > to allow a non-admin user to start/stop pre-defined tunnels via a tcp
> > socket) and I see some big troubles in a near future.
> >
> > The *great* actual cryptoapi patch allow a user to access local machine
> > and local user certs. It's quite good right now because most of the
> > openvpn users are using it with admin rights or non-interactive
> > processing( like autostart at windows boot).
> >
> > I'm worrying about those features when our aim will be to do let
> > non-admin users start their tunnel and authenticate themselves on the
> > openvpn server with their own certificate. In the actual openvpn it's
> > not possible, because the SYSTEM account can only access to his own
> > certs and the local machine certs, but not "Foo Bar User" certs.
> >
> > We can ask ourselves few questions:
> >
> > - is it possible to make SYSTEM access user certs?
> > - if not, how can we make openvpn access to those users data?
> >
> > A friend of mine said an answer could be to let the GUI(or a user only
> > component) manage the access to such user-related data, and let openvpn
> > deal with this component in order to use the certs.
> >
> > Of course, this problem is only windows-related.
> >
> > What do you think of this problem?
> 
> First of all, the current impediments to running OpenVPN on Windows in
> non-admin user mode is:
> 
> (1a) The openvpn.exe process needs to open a device handle to the
> TAP-Win32 adapter.  Windows does not provide a convenient way for the
> TAP-Win32 adapter to allow itself to be opened by non-admin apps.
> 
> (2a) OpenVPN needs to be able to modify the routing table.  Most OSes
> (Windows & Linux included) require admin/root privileges for this.
> 
> Now it appears that we have another obstacle, this time going the other
> way.
> 
> (1b) The SYSTEM account (sort of like "Windows" root, the user under
> which services/daemons run) can't read a specific user's key from the
> Crypto API store.
> 
> Either we need to run openvpn.exe in user mode and solve (1a) and (2a) or
> run openvpn.exe in service mode and solve (1b).  (1a) and (2a) seem
> relatively difficult to solve, so probably it's worthwhile to attempt to
> solve (1b) -- or at least study its difficulty in relation to (1a) and
> (2a).
> 

What about a dual account/ID  user situation?  Where one user is a
normal user with all the restrictions and the other has administrator
rights.  The first is used to login the second, administrator 
equivalent is for storing the certificate and running the service.

-- 
Leonard Isham, CISSP
Ostendo non ostento.

