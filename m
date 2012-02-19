Date: Sat, 18 Feb 2012 21:49:52 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4F403CA0.80903@...1114...> (from
	openvpn.list@...1114... on Sat Feb 18 18:04:48 2012)
Message-Id: <1329623392.2060.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/18/2012 06:04:48 PM, David Sommerseth wrote:

> Right now, debating tarball/zipball formats is a bit premature.=20=20
> There
> are 8 challenging steps to solve before this.  Even though Windows
> doesn't support tarballs natively, LGPL tools like 7-Zip exists which
> will make that job easier.  And those needing to extract these pieces
> are
> not necessarily end-users, so we should expect people to know how to
> solve these things.
>=20
> But for now, I'd like to see more focus on the steps before the
> packaging
> method.  We first need to have something to package.

Makes sense.

Regardless...

You might try my old patch that produces a tarball of MS binaries,
found here:

http://article.gmane.org/gmane.network.openvpn.devel/2578

It never got applied, partly because it needed supporting documentation
and the accompanying patch to update the website failed to apply
by the time anybody got around to looking at the patch. because
by then the website was reorganized.  Even if it does apply, it should
have supporting documentation before being accepted into the
tree.  I can't say if it's easier to poke about the old thread
to come up with appropriate documentation or to start from
scratch.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


