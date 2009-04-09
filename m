MIME-Version: 1.0
In-Reply-To: <1239246215l.5600l.0l@...1207...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
	<1239203062l.18482l.11l@...1207...>
	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
	<1239246215l.5600l.0l@...1207...>
Date: Thu, 9 Apr 2009 09:01:50 +0300
Message-ID: <9e0cf0bf0904082301ia16b642n3781adc357958de3@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, dave <dev@...575...>

On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...> wrote:
> It occurs to me that if I want to do more than
> beg I should submit a patch, so one is attached.
>
> On 04/08/2009 05:46:46 PM, Alon Bar-Lev wrote:
>>
>> Available as part of OpenSC build [1].
>>
>> [1] http://www.opensc-project.org/build
>
> I noticed that. =C2=A0Does that build all of what
> OpenVPN 2.1 packages for Windows, i.e. includes
> OpenVPN GUI? =C2=A0The project does not seem to release
> binaries for OpenVPN GUI, which is a requirement
> for me.

OpenVPN GUI is an application that is not part of OpenVPN.
The fact that it is provided within the same installer is a
mistake in my view.
It also does not working in many scenarios OpenVPN support
as it does not use the management interface.

The tap also is not provided as it also should have been provided
by a different package, as it is too being used by other projects,
such as coLinux.

> I was also a little put off by:
> "The OpenVPN overlay is provided in order to solve OpenSSL version
> incompatibility between OpenSC and OpenVPN projects."
> How can I make sure that I've got what OpenVPN is releasing
> so that I can go to OpenVPN for support?

As OpenSSL does not have stable ABI, compiling two projects with
different versions of OpenSSL, and loading the two into the same
process results in invalid behavior.

> The OpenVPN devs have a "built" source tree in which they run
> install-win32/buildinstaller. =C2=A0My point being that
> if they would package it up
> and release it alongside the resultant installer
> none of these sorts of issues would ever come up.

Wrong.

Alon.

