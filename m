Date: Wed, 10 Mar 2010 11:57:21 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
	<1268242750.8679.0@...1207...>
	<9e0cf0bf1003100941y30780002qcd62ca2d9e9355f2@...278...>
In-Reply-To: <9e0cf0bf1003100941y30780002qcd62ca2d9e9355f2@...278...>
	(from alon.barlev@...277... on Wed Mar 10 11:41:49 2010)
Message-Id: <1268243841.8679.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not defined
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/10/2010 11:41:49 AM, Alon Bar-Lev wrote:
> On Wed, Mar 10, 2010 at 7:39 PM, Karl O. Pinc <kop@...1206...> wrote:
> > In other words ./configure is not expected to be run under normal
> > circumstances.
> >
> > The whole point of autoconf is to produce something that can
> > be made into a tarball that only requires "make; make install"
> > to compile and install.
>=20
> You do not understand the tools. Nor the common use of them.
>=20
> You *MUST* run ./configure when compiling from sources.

You are right, on all of the above.  I don't use them every
day.=20

But, you _don't_ have to run ./configure every time.  You
yourself wrote that you do the ./configure on the _new_
machine, and then move the tarball to the old machine
and recompile.  This is often the situation, or at least
I found so, when making rpm spec files.

You are quite correct in pointing out that ./configure
should be able to be run on the old machine, which
means that it can be executed within the build portion
of the spec file.

Thanks for the correction and please tell me if I'm
wrong again.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


