Date: Mon, 22 Feb 2010 10:24:19 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B82366D.4080405@...1114...> (from
	openvpn.list@...1114... on Mon Feb 22 01:46:53 2010)
Message-Id: <1266855859.19847.0@...1207...>
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

On 02/22/2010 01:46:53 AM, David Sommerseth wrote:

  The commit log=20
> will
> state that this begins the feature deprecation process, with a=20
> warning
> when this feature is used and the feature can be removed at compile
> time
> with --disable-depr-random-resolv.

I've thought a bit more about this.  It seems to me that the
warning message happens at the wrong time.  In your patch
(IIRC) it happens at dns resolve time, only when there are multiple
A records returned.  It should happen at OpenVPN startup
time for the following reasons:

Someone may be relying on the behavior but, at the moment
or depending on present dns circumstances, does not have
multiple A records returned.  In this case no warning will
be generated.

Generating a message every time dns lookup is done
could result in "too many" messages, increasing the
log files and filling somebody's disk.  (Unlikely, but...)
In any case it adds additional noise in which
legitimate messages could be lost.

Arguably, a message sent at startup time is more
likely to be noticed than one buried amid others
that occur over time.

Generating one message at startup time is "least
invasive" to the code.  Everybody will
execute the code path and so (in the unlikely
event) any bugs will be found and fixed early.
Likewise, any introduced problem will occur during
initialization rather than "runtime" and so will
happen at a predictable point.
The code that actually "does something" will be
untouched, removing any possibility of race
conditions or anything else that might interfere
with actual operation.

In the general case I would think you'd want
warnings regarding features chosen/not chosen/
depreciated/etc. to be generated at config
parse time.

/brain dump

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


