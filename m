Date: Wed, 08 Apr 2009 12:48:46 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...> <1239203062l.18482l.11l@...1207...>
	<49DCC18D.6040509@...273...>
	<1239210120l.18482l.13l@...1207...>
In-Reply-To: <1239210120l.18482l.13l@...1207...> (from kop@...1206... on Wed Apr  8
	12:02:00 2009)
Message-Id: <1239212926l.18482l.14l@...1207...>
MIME-Version: 1.0
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
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Karl O. Pinc" <kop@...1206...>
Cc: Matt Wilks <matt@...273...>, openvpn-devel@lists.sourceforge.net

I apologize for not starting a separate thread for this.

On 04/08/2009 12:02:00 PM, Karl O. Pinc wrote:
>=20
> On an unrelated note I notice that building the 2.1 rc15
> nsis installer on Linux for Windows gives me 3 warnings:
>=20
> 3 warnings:
>    install function "GetWindowsVersion" not referenced - zeroing code
>=20
> (125-174) out
>=20
>    label "fileass" not used
>    label "tryaddtap" not used
>=20
> I don't get the first when I build an installer on Windows.
> (I do get the second 2 warnings.)

If I tar up the windows build tree and use that on Linux
to build the installer I don't get the first message.

So it seems I was doing something wrong.

As far as the last message goes, that's likely
because I've not downloaded the tap code
from Microsoft.  (I found the instructions
in domake-win unclear on whether this is necessary
when using a pre-built environment.)  In any
case I don't need the tap device so I'm not
going to worry about it.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

