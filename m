From: "dave" <dev@...575...>
Date: Tue, 7 Apr 2009 22:21:36 -0500
Message-ID: <56AB1F7945F84C2688EC35B942109195@...576...>
MIME-Version: 1.0
In-Reply-To: <1239152310l.18482l.7l@...1207...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
	building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Karl O. Pinc'" <kop@...1206...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: Karl O. Pinc [mailto:kop@...1206...] 
...
> What I really want is a Windows binary and whatever
> else gets built, _not_ packaged in an installer, so I can build
> my own installer.  It would be nice if OpenVPN would
> release such a binary.  Absent that I'm forced to
> drag out a Windows machine, torture myself
> for hours with it, and pester you. :-)
...

OK, low-tech, but...

When I used to package OpenVPN for Portable Apps, I used to just install
openvpn, and pluck what I wanted out of the Program Files\OpenVPN
directory.

I now have a MingW environment working, so I don't do that anymore (and
so I can patch if I want), but it worked in a pinch and may allow you to
get on with the business of focusing on creating your installer for now,
then one day you can return to the MingW if you want to.

-Dave


