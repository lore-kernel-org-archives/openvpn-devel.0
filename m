From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0.2-TO4 released -- major progress on
 allowing non-admin access
In-Reply-To: <Pine.LNX.4.61.0509241332520.18014@...210...>
Message-ID: <Pine.LNX.4.58.0509241247170.25922@...41...>
References: <Pine.LNX.4.58.0509240210210.25922@...41...>
 <Pine.LNX.4.61.0509241332520.18014@...210...>
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
Date: Sat Sep 24 12:35:51 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...454...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 24 Sep 2005, Mathias Sundman wrote:

> On Sat, 24 Sep 2005, James Yonan wrote:
> 
> > One of the interesting ramifications of this feature, is that it sets the
> > stage for non-admin accounts to be able to run OpenVPN directly, without
> > using the service wrapper.
> >
> > With OpenVPN 2.0, this couldn't happen for two reasons: (a) opening the
> > TAP-Win32 device object required administrative privileges, and (b) if the
> > server pushed routes, the client couldn't add them because adding routes
> > on Windows requires privilege.
> >
> > This new release addresses (a).  (b) is still an issue if the server is
> > pushing routes.  However (b) is less of an issue now since the "topology
> > subnet" feature was added, because it allows a tun-based tunnel to operate
> > without requiring any mandatory route pushes in order to function.  Of
> > course, if you are pushing custom routes, or are pushing
> > "redirect-gateway" to clients, then those routes cannot be added if the
> > user lacks administrative privileges (is there a finer-grained
> > privilege that allows route modification without full admin privileges?).
> 
> You're awesome! How did you solve it? Last time it was discussed on the 
> list I remember there was another way to open the TAP driver but it was a 
> non supported way and would probably not pass WHQL Driver tests so you 
> didn't want to use that method. Did you come up with an other solution, or 
> did you chose this way after all?

Well as it goes, trying to solve intractable windows driver problems
usually starts with the requisite tearing out of hair, followed by the 
transmission of a distress signal to 
microsoft.public.development.device.drivers:

http://groups.google.com/group/microsoft.public.development.device.drivers/browse_thread/thread/f5baddd33208d68e/ff903d776234414c

That gave me some ideas, such as using the ZwSetSecurityObject call on the 
device object after it has already been created with admin-only 
permissions.  While the code for this seems reasonable, the 
ZwSetSecurityObject kernel call is not officially documented in the DDK, 
though I believe it's documented in another MS toolkit.

I think the bottom line is that MS didn't really think this through, and
we're going to have to wait until NDIS 6.0 (vista) to get an elegant
solution.  So while I'm not sure that using ZwSetSecurityObject would pass
muster with the WHQL fashion police, my current sense is that it's a 
stable workaround.

> Could we perhaps solve (b) in the TAP driver as well. I mean implement an 
> interface between userspace and the TAP driver that allows us to tell the 
> TAP driver to add/delete routes?

That's tricky -- I'm sure that kernel space has some kind of API for route
manipulation, I'm just not sure that it's documented.

> Or do you still think the final solution is to run the whole openvpn 
> process via a service wrapper?
> 
> The good thing with using the TAP driver also for adding routes is that 
> openvpn could continue running as a non-admin userspace application and 
> give us all the benefits of a potential security voulnerability found in 
> the openvpn code only beeing executed as non-admin.
> 
> Of cource the same thing could be implemented in a seperate service module 
> only used for route additions and perhaps script execution.

Right -- one could have a sort of "route" service.  But when you start 
talking about script execution, then there's going to be a lot of security 
concerns, and I think you would end up with something that looks more like 
sudo.

> The tricky part of cource would be how to control that only the openvpn 
> process is able to control the TAP driver or service module so we don't 
> allow normal users to execute arbitrary code as admin.

I think making the TAP device object accessible from non-admin is
reasonable from a security perspective.  In fact, would argue that it 
actually improves security, in the same way that user/group nobody on *nix 
does.

James

