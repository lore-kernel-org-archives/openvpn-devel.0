References: <56C32BCD.1050407@...515...>
	<CAFChrgL43Fr_1GSYc6qryC8eVncdSURKJJu-oMPWrtYcNf2wjw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C46321.50500@...515...>
Date: Wed, 17 Feb 2016 14:10:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAFChrgL43Fr_1GSYc6qryC8eVncdSURKJJu-oMPWrtYcNf2wjw@...278...>
Subject: Re: [Openvpn-devel] Handling bitness (32/64) for OpenVPN Windows
 installers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Haar <jason_haar@...1490...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
> On Wed, Feb 17, 2016 at 3:01 AM, Samuli Sepp=E4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>     1) Combine 32-bit and 64-bit installers into one
>
>     Is there a use-case for installing 32-bit OpenVPN on a 64-bit system?
>     If not, we could combine both 32-bit and 64-bit binaries into a single
>     installers and, at install time, select the correct ones to install.
>     This would increase installer size from ~1.8MB to ~3.3MB.
>
>
>
> 3.3M? Umm, what year is this? :-)
>
> I'd say put them both into the installer and auto-install the
> appropriate one. If it was 18M vs 36M you might want to be more finer
> grained - but <2M difference? It's not worth thinking about.
>
> Ditching WinXP is definitely the right thing to do. People shouldn't be
> running security software on dead OSes. They will do it poorly. Just sayi=
n'

Well, that would mean the installer will have to split into three floppy=20
disks instead of two for transport.

But seriously, a combined installer looks like a reasonable way=20
forwared. It will, however, require significant changes to=20
openvpn-build/openvpn.nsi, so it will take a bit of effort to get it done.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

