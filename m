Date: Thu, 07 Apr 2011 09:52:07 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4D9DB36B.3010202@...1114...> (from
	openvpn.list@...1114... on Thu Apr  7 07:51:55 2011)
Message-Id: <1302187927.31738.5@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
 more suitable path
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

On 04/07/2011 07:51:55 AM, David Sommerseth wrote:
> [resend copy to openvpn-devel list as well]

> I checked for the $TMPDIR variable on CentOS 5.5, Fedora 14 and=20
> Gentoo
> installations.  And $TMPDIR didn't show up at all, hence I thought
> this was
> not a really useful option.  However, I see from the wikipage that
> this is
> supposed to be part of SuS.  But it seems not to be respected in=20
> Linux
> at
> least.=20

FYI After poking about the man pages of various Un*xs I find:

login(1) does not have to set $TMPDIR, although the whole
login process can be configured to do so there's no=20
requirement that $TMPDIR exist.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


