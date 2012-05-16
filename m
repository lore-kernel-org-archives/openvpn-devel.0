MIME-Version: 1.0
In-Reply-To: <4FB3A183.1080508@...515...>
References: <4FB38F35.20103@...515...>
	<4FB3A183.1080508@...515...>
Date: Wed, 16 May 2012 22:11:35 +0300
Message-ID: <CAOazyz104K4bHX8QvVrn7ZKH7MeQ3yhFqzLZYvovEYsW0TRE-g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Pre-2.3-alpha2 Windows installers now available
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello All,

I want to emphasis the request to test as:

1. The installer was fully re-written almost nothing remained from the
original one.

2. We now provide both 32bit and 64bit binaries, so far only 32bit
binaries were provided.

3. All userspace binaries are compiled using mingw-w64 compiler, this
is also a change from previous releases.

4. The tap-windows driver has its own installer which is embedded
as-is within the openvpn installer.

Any input will be much appreciated!

Alon.

On Wed, May 16, 2012 at 3:45 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Forgot to mention... If you're interested in testing just the TAP-driver
> installer, it's available here:
>
> <http://build.openvpn.net/downloads/snapshots/tap-windows-9.9.0_master.ex=
e>
>
> Best regards,
>
> Samuli
>
>
>> Hi all,
>>
>> Here are the first fully-functional Windows installers built (by me)
>> with Alon's new cross-compilation environment (a.k.a. "generic"
>> buildsystem):
>>
>> <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master=
-I000_master-i686.exe>
>> <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master=
-I000_master-x86_64.exe>
>>
>> The installers and executables and libraries in them have been signed
>> with a self-signed test certificate. This means that Windows Vista/7
>> 64-bit will refuse to install the (self-signed) TAP-drivers, unless this
>> CA certificate is in the system keystore:
>>
>> <http://build.openvpn.net/downloads/openvpntestca-cert.cer>
>>
>> This certificate can be imported using Microsoft management console
>> (mmc.exe):
>>
>> - Add =C2=A0the "Certificates" snap-in
>> - Go to "Trusted root certificates"
>> - Right-click "Certificates"
>> - Select "All tasks" -> "Import"
>>
>> After this you can run the OpenVPN installer and it should just work. A
>> version of OpenVPN signed with paid-for certificate is coming soonish.
>> That one will work on any supported Windows version without jumping
>> through these hoops.
>>
>> Have fun (and please report back any issues you find),
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

