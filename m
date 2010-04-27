Date: Mon, 26 Apr 2010 21:25:49 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1272309086.19417.1@...1207...> <4BD61B96.3050005@...1114...>
In-Reply-To: <4BD61B96.3050005@...1114...> (from
	openvpn.list@...1114... on Mon Apr 26 18:02:46 2010)
Message-Id: <1272335149.8910.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
 [Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
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
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 04/26/2010 06:02:46 PM, David Sommerseth wrote:
> On 26/04/10 21:11, Karl O. Pinc wrote:
> > On Debian all I had to do was "aptitude install nsis" and then
> > run it to make MS Windows installers.  Plug and play, no
> > compiling necessary.
> >
>=20
> Just a little nitpick, when you run makensis, that's actually
> compilation of the installer - even when you're doing it on Linux.=20
> You
> get a Windows binary as the result.

As long as we're nitpicking... ;-)

That's interesting.  I figured the nsis install scripts
were interpreted and, if I thought about it at all,
running makensis setup some data structures and did
some linking.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


