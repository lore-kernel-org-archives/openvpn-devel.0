Date: Mon, 27 Apr 2009 10:42:27 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...> <m3zle2cwmx.fsf@...1176...>
In-Reply-To: <m3zle2cwmx.fsf@...1176...> (from benny+usenet@...1175...
	on Mon Apr 27 03:45:58 2009)
Message-Id: <1240846947l.13043l.1l@...1207...>
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
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Benny Amorsen <benny+usenet@...1175...>
Cc: openvpn-devel@lists.sourceforge.net


On 04/27/2009 03:45:58 AM, Benny Amorsen wrote:

>=20
> It seems that OpenVPN is quite far away from the theoretical
> performance
> where kernel-userspace-kernel copying becomes an issue. Right now
> encryption is quite expensive, except on a few platforms with
> dedicated
> AES instructions.

Dedicated encryption hardware is cheap. (<$100) And it seems
that using it can also involve a kernel/userspace
transition.

I've a box with an AMD Geode LX.  This chip supports
AES-128 bit encryption.  The same box also has a Hi/fn 7955
chip on a separate PCI card, which supports AES-256
as well as other algorithms.

When I switch from AES-128 to AES-256, or other, cheaper,
choices supported by the Hifn but not the Geode,
I see a large performance hit.  Assuming my tests
are right; I've not put a lot of effort into it.

I suspect the problem is again kernel/userspace.
The CPU is available to userspace, but the Hifn
is not.  (There are other possibilities.  Perhaps
OpenSSL does not play well with multiple hardware
accelerators, or maybe my tests are just plain bad.)

So, I believe it's easy and cheap to add hardware
to a OpenVPN box and create a situation where
the kernel/userspace transition cost does matter.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

