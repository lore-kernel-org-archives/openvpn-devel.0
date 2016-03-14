References: <56E185E9.60506@...515...>
	<1457945194.124630.191.camel@...1866...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56E6AC00.4090700@...515...>
Date: Mon, 14 Mar 2016 14:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <1457945194.124630.191.camel@...1866...>
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
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Thu, 2016-03-10 at 16:34 +0200, Samuli Sepp=C3=A4nen wrote:
>>
>> A second problem should be limited to Windows 7 and Windows Server 2008
>> R2 installations that are booted through a non-Windows bootloader (e.g.
>> grub):
>>
>> <https://support.microsoft.com/en-us/kb/3033929>
>
> Is there a link to the corresponding grub bug? In an ideal world,
> things like the above would never be posted *without* such a link. But
> I suppose we don't necessarily expect Microsoft to do the right thing.
> Hopefully *someone* has?

I believe the bug is not in Grub, but in the said Windows update, which=20
can put the computer into reboot loop:

<http://answers.microsoft.com/en-us/windows/forum/all/kb3033929-
does-not-install-multi-boot-win7-linux/8f35f8f8-c0b2-461a-a8aa-4bbf16c49920=
?auth=3D1>

I could not find a bug report in Grub bug tracker[1] using the above KB=20
number. However, this problem is only tangentially related to the new=20
OpenVPN installers:

- If KB3033929 has been installed, the problem will manifest itself=20
regardless of OpenVPN
- If the said update has not been installed, then Windows 7 will/might=20
fail to verify the signature of the installer and the libraries/binaries=20
in it, showing "Unknown publisher" in UAC

Lack of the update might become more problematic after I rebuild the=20
tap-windows6 driver and sign it with our new key, in which case Windows=20
7 might reject the driver altogether. So that part requires more=20
thorough pre-release testing.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <http://savannah.gnu.org/bugs/?group=3Dgrub>


