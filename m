From: Jon Nelson <jnelson-openvpn@...135...>
Subject: Re: [Openvpn-devel] Working with 2.6
In-Reply-To: <200311181004.25751.matt@...137...>
Message-ID: <Pine.LNX.4.58.0311181109080.17332@...136...>
References: <Pine.LNX.4.58.0311180916570.17332@...136...>
 <200311181004.25751.matt@...137...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 18 09:12:04 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Matt <matt@...137...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 18 Nov 2003, Matt wrote:

> I've had a simular problem too. 2.6 and Openvpn are a no go.

Why?  I easily got it running after just a few minutes of debugging.
Indeed, it's been working fine for me for the last few days.
Didn't you read the whole email?  The solution is contained within.
If you want to simply test it out, do this:

cd /dev/net
ln -s ../misc .

That should allow openvpn to open the tun interface.
If that works, and you can't figure out what lines in the devfs
configuration to edit, post to this list and I'll see if I can determine
what exactly it is that I changed in the (devfsd) config.


> On Tuesday 18 November 2003 08:18 am, Jon Nelson wrote:
> > Just so you all know, I'm using OpenVPN 1.5beta12 (soon to be beta14)
> > with Linux 2.6.0-test9 (vanilla, no patching).
> >
> > The only problem I encountered is that I had to alter by devfs
> > configuration because the tun device has moved from /dev/net/tun to
> > /dev/misc/net/tun -- fortunately there are existing (commented out)
> > directives in the devfs configuration for this.

--
Democracy is two wolves and a sheep voting on what to have for dinner.
Liberty is two wolves attempting to have a sheep for dinner and
finding a well-informed, well-armed sheep.

Jon Nelson <jnelson-openvpn@...135...>

