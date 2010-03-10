Date: Wed, 10 Mar 2010 12:22:04 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B97E076.7040201@...1114...> (from
	openvpn.list@...1114... on Wed Mar 10 12:09:58 2010)
Message-Id: <1268245324.8679.4@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

On 03/10/2010 12:09:58 PM, David Sommerseth wrote:

> > But how is it then that Alon does not run ./configure
> > on machine 2 above?
>=20
> The fact is that I believe he does run ./configure on all machines.
> Autotools just generates a set up files which is not depending on
> anything else than basic *nix tools, like shell, grep, sed, etc, etc.

Right.  This I've always gotten.

>=20
> But to be able to make the tarball via 'make dist', you need to run
> ./configure first to have a Makefile which knows what the 'dist' rule
> is.  Then the 'dist' rule wraps it all together into a autotools
> independent tarball, including a prepared ./configure script.

Ok.  Thanks.  This is what threw me off.  I was mistaking
this for executing ./configure on the dist tarball.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


