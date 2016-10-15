References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
	<d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
	<105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <11b686a3-1c85-69fb-9463-781c15d34d52@...68...>
Date: Sat, 15 Oct 2016 14:03:09 +0200
MIME-Version: 1.0
In-Reply-To: <105bf86c-4cd3-ba94-3141-e5979faaf507@...2080...>
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
 releases?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.10.2016 um 12:11 schrieb David Sommerseth:
> b) Have the package exclude each other to block both being installed
>    at the same time.

That's the path normally chosen and that I'd recommend for DEB/APT-based
packages because solvers can usually figure that part out. I think the
RPM world needs some support from the dependency solvers, too. Not sure
what dnf is up to these days, but it - as its predecessor yum - seemed
to do the right thing for the limited exposure I gave them in my Fedora
installations, and I stopped caring about other RPM-based distros years ago.


