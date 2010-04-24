Date: Fri, 23 Apr 2010 23:09:04 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <s2w1757b0251004222336v1ff497bcsd7bfd0dbd9ec95fa@...278...>
	(from sidhpurwala.huzaifa@...277... on Fri Apr 23 01:36:56 2010)
Message-Id: <1272082144.16099.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn error messages on the administrative
 interface?
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
To: Huzaifa Sidhpurwala <sidhpurwala.huzaifa@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/23/2010 01:36:56 AM, Huzaifa Sidhpurwala wrote:
> Hi All,
> I have been patching NetworkManager-openvpn for some time now, trying
> to
> enable some functionality, which a lot of
> people use.
> The main problem we have been facing for some time now, is that
> openvpn
> throws error messages only in the logs,
> due to which any form of graphical output for us, is only possible by
> screen
> scraping these logs, which is a real pain.
>=20
> I am thinking if we can make openvpn show these messages on the
> administrative interface or something similar so that programatically
> it
> would become easier to parse them and show them graphical to the=20
> user.

Wny not configure your syslog program to pipe log messages straight
into some program you write that delivers the messages where ever you
want them?   Or use UDP, TCP or RELP instead of a pipe.

Or is the problem that MS Windows does not support --syslog?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


