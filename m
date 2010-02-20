Date: Fri, 19 Feb 2010 21:39:40 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B7F1AAA.5090103@...1114...> (from
	openvpn.list@...1114... on Fri Feb 19 17:11:38 2010)
Message-Id: <1266637180.23846.1@...1207...>
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
> And if nobody complains in the end, this code will be removed
> completely.

I understand the point of the policy, but it seems a bit crazy
to ask for the feature to be disabled and have it _not_ be disabled
but to get a warning instead.=20=20

What you have right now is (unless I mis-understand the code):

Regardless of whether you ask for the feature to be disabled
or not the feature remains _enabled_ and you get a
runtime warning.

If you ask for the feature to be enabled you get no warning.


What makes sense to me is:

By default the feature remains enabled but there _is_ a=20
runtime warning.

If you explicitly ask for the feature to be disabled then it
is disabled and there is _no_ runtime warning.

If you explicitly ask for the feature to be enabled then
it is enabled and there is _no_ runtime warning.


This trinary choice conforms to the policy whereby
depreciated features remain _by_ _default_ enabled but=20
generate warnings.  However it also allows those
who make explicit choices to choose desired functionality,
which not-incidentally allows those who wish a change in=20
functionality to test out how the change works.  And it
recognizes that those who make explicit choices are aware
of what those choices do and so do not need warnings.
Especially because anyone who makes an explicit choice
from this point forward will get the requested feature
and does not care about the default
because they are not using the default.

If someone who explicitly chooses a functionality
needs to get a warning about the default they
should get this warning at ./configure time --
the time they make the choice.  Not at runtime.
(Of course those who rely on the default should,
IMO, get a runtime warning message because most of these
people won't be doing the ./configure step.)

Whatdayathink?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


