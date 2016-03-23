References: <56E185E9.60506@...515...>
	<1457945194.124630.191.camel@...1866...>
	<56E6AC00.4090700@...515...>
	<20160314195809.GQ24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56F25198.8050107@...515...>
Date: Wed, 23 Mar 2016 10:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <20160314195809.GQ24952@...1296...>
Subject: Re: [Openvpn-devel] Windows installer with SHA-256 signatures ready
 for testing
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@...1866...>


> Hi,
>
> On Mon, Mar 14, 2016 at 02:18:08PM +0200, Samuli Sepp=E4nen wrote:
>> Lack of the update might become more problematic after I rebuild the
>> tap-windows6 driver and sign it with our new key, in which case Windows
>> 7 might reject the driver altogether. So that part requires more
>> thorough pre-release testing.
>
> The old key is still valid, just not "good enough" for win8+, right?
>
> In that case we might consider building two tap driver packages, one
> signed with the vista/win7 key, one with the win8+ key.
>
> Or maybe I'm totally misunderstanding this, so ignore me :)
>
> gert
>

In case I did not respond to this earlier (my email client claims that)...

Old tap-windows6 signatures will be as valid as they were before. We=20
might run into trouble whe we sign tap-windows6 with the EV dongle,=20
which probably generates SHA-2 signatures. The same goes for our new=20
generic code-signing certificate, which was recently rekeyed to SHA-2.

My view of what will happen once we fully move to SHA-2 for signing the=20
executables, libraries and drivers:

- Windows XP will show "Unknown publisher" for everything
- Some Windows 7 installations _might_ have issues:
   - Might not recognize the SHA-2 signatures ("Unknown publisher")
   - Might fail to install the SHA-2 tap-windows6 driver
- Windows 8.1+ should work just fine

That said, the Windows 7 issue has not been verified. So far nobody has=20
complained about the new SHA-2 based Windows installers I published. The=20
tap-windows6 driver contained in the installers was still signed with=20
the non-EV SHA-1 key, so at worst we'd see the "Unknown publisher" problem.

I can probably sign Windows XP (I00x) installers with the old SHA-1 key=20
until it expires in September. After that I will need to sign everything=20
with SHA-2. I think that at that point we should consider dropping=20
official Windows XP support, namely:

- Stop publishing tap-windows-based (I00x) OpenVPN installers
- Stop caring about "Unknown publisher" warnings on Windows XP

We could still allow use of I60x installers on Windows XP, and let=20
people downgrade to tap-windows manually.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

