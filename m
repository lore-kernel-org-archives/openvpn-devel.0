Date: Wed, 27 Jan 2010 19:59:50 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B4DBCE6.2010500@...515...>
	<20100113174945.12137.qmail@...1287...> <4B56DD56.6000804@...515...>
	<C9D1AE76-F7C2-4913-8F8D-0C0718922538@...1286...>
	<4B571019.7040506@...515...> <4B60C881.7060404@...1114...>
	<20100128012824.31346.qmail@...1287...>
In-Reply-To: <20100128012824.31346.qmail@...1287...> (from peter@...1287... on
	Wed Jan 27 19:28:24 2010)
Message-Id: <1264643990.28066.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN development model"
 meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 01/27/2010 07:28:24 PM, Peter Stuge wrote:
> David Sommerseth wrote:
> > For those of us not being heavily involved in development processes
> > from day-to-day, we can probably survive with whatever VCS is being
> > used.
>=20
> Fair enough. But I think two git features in particular matter also
> in the casual patcher case. It's very nice that git keeps both author
> and committer information, and it's doubleplus nice that git can
> transport commits via email. These two in particular allow regular
> developers to accept casual patches very easily.

The general case is that people maintaining their own trees benefit
from a distributed revision control system.  These people might not
be the same people who are heavily developing the official version,
but might be people who need their own patches for whatever reason.

A distributed VCS allows _everybody_ to have a VCS and benefit
therefrom, not just the OpenVPN developers themselves.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


