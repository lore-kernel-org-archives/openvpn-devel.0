Date: Tue, 28 Apr 2009 13:45:03 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...> <m3zle2cwmx.fsf@...1176...>
	<1240846947l.13043l.1l@...1207...> <49F6FA03.6070608@...1032...>
In-Reply-To: <49F6FA03.6070608@...1032...> (from siim@...1032...
	on Tue Apr 28 07:43:47 2009)
Message-Id: <1240944303l.12737l.0l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: =?iso-8859-1?q?Siim_P=F5der?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>


On 04/28/2009 07:43:47 AM, Siim P=F5der wrote:
> Hi
>=20
> Karl O. Pinc wrote:
> > So, I believe it's easy and cheap to add hardware
> > to a OpenVPN box and create a situation where
> > the kernel/userspace transition cost does matter.
>=20
> It's easy and cheap if you add a second box or third. But if you are
> approaching tens of openvpn boxes (at various locations) and you want
> to
> maintain rendundancy, it is not especially cheap nor is it especially
> easy. Maintaining the system gets a bit trickier and simply relying on
> ssh and grep doesn't cut it any more.

I believe you, but you lost me when it comes to the explanation.
What do ssh and grep have to do with adding a hardware encryption
card?  (I think maybe you're thinking I'm still talking about
additional boxes. Recap: My point was that hardware encryption seems
to involve kernel/userspace transitions too.)

> Also our own test show that using standard (ie, not neccessarily
> optimized for routing) Opteron servers and intel e1000, we can
> saturate
> 1G easilly (with up to 300Kpps in one direction), with about 10% of a
> single core working in softirq (50% if conntrack is in the picture).
> However, with openvpn, we can go up to ~80 Kpps without encryption and
> in that case, rougly half of the load goes into softirq and the other
> half goes into userland. Most of the drop from 300 to 80 should be
> wasted work.

Out of curiosity, did you test the scheduler per
the link supplied by James MacLean?
http://sourceforge.net/mailarchive/forum.php?thread_name=3D492DBF02.1070305=
%40ednet.ns.ca&forum_name=3Dopenvpn-devel

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

