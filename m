Date: Mon, 22 Feb 2010 10:37:13 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B7F1AAA.5090103@...1114...> (from
	openvpn.list@...1114... on Fri Feb 19 17:11:38 2010)
Message-Id: <1266856633.19847.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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

On 02/19/2010 05:11:38 PM, David Sommerseth wrote:
> On 20/02/10 00:06, Karl O. Pinc wrote:
> > On 02/19/2010 04:57:30 PM, David Sommerseth wrote:
> >
> > Am I wrong or does using --disable-depr-random-resolv
> > not remove the random choice?
>=20
> That is correct.  According to the newly agreed feature removal
> process,
> deprecated features should in the beginning be enabled but give
> warnings
> when they are triggered.  At some point, this behaviour will be
> switched
> to be disabled, and you need to do use --enable-depr-random-resolv.

Irrespective of the actual change being made here, does it
make sense to have a "next release" branch?

If changes to defaults/depreciation of features is to happen
at major release number boundaries, or whatever defined point,
it is important not to "miss" making such a planned change
happen in the first version of the new major release.
Likewise, having to go back and re-visit the code to=20
make the actual change could be error prone.  And we
would not want these changes to conflict with any other
changes either.

Having another branch to track changes that will happen
in the next major release solves all of these problems.
This branch would have the code that by default changes
the existing behavior, enables the new feature, etc.

Just a thought.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


