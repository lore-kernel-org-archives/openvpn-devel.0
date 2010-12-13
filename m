Date: Mon, 13 Dec 2010 14:23:45 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4D06503C.8090900@...1114...> (from
	openvpn.list@...1114... on Mon Dec 13 10:56:28 2010)
Message-Id: <1292271825.25909.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Open log files as text files on Windows
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

On 12/13/2010 10:56:28 AM, David Sommerseth wrote:
> On 13/12/10 17:29, Karl O. Pinc wrote:
> > On 12/13/2010 05:56:16 AM, David Sommerseth wrote:
> >> By giving the "t" flag to _fdopen() on Windows, the file will be
> >> opened in a "translate mode", where it will take care of=20
> converting
> >> \n to \r\n, and also look for the CTRL-Z mark when opening the log
> >> file in append mode.
> >
> > It should be possible to have a consistent log format
> > across hydrogenous hosts so that, need be, the logs can all
> > be processed in the same fashion.  (Think swatch,
> > etc.)  Which raises the following
> > questions in my devoid-of-MS-isms mind:
> >
> > How does this affect network logging; syslog et-al?
> >
> > Shouldn't there be a flag that turns this on (or off)?
> >
>=20
> This last patch will only add the "text/translate mode" on Windows
> platform when it opens a log file.  In all other scenarios, the
> behaviour will be as it was before.

Just because it's a file does not mean that it's
local to MS Windows.  E.g., there could be a samba mount
involved.

It just sounds spooky to have a sometimes-this-way
sometimes-that-way file format without a way to
force a single file format.  Especially when
this is a backwards-incompatible change.

Having said that I've no immediate need for
the log format to be universally uniform.
We could always add a flag later if someone
complains.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


