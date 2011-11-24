MIME-Version: 1.0
In-Reply-To: <4ECE04B8.3000100@...515...>
References: <4ECE04B8.3000100@...515...>
Date: Thu, 24 Nov 2011 11:09:49 +0200
Message-ID: <CAOazyz1XptNoQWsskiEDLk31h0djzB0zLairjLrK0u5YfyxMBw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Topics for today's meeting
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

I won't participate in sync meeting.... don't have the time.
Anyway, for windows build.
I already provide binaries for OpenVPN using mingw-w64 project, and it
works fine!
I use mingw-w64 for both win32 and win64 binaries, much better than
old mingw project, as mingw-w64 is maintained!
You can see my build system at [1][2].
So mingw cross compile is supported. I would have re-written the
openvpn autoconf script to clean it up and make it more standard, but
current is enough to be usable.

msys can be used on Windows to build not sure it worth the effort...
mingw can be used with -mno-cygwin parameter, but from my experience
the toolchain in cygwin are way too old to be usable.

For the tap driver, I always note this... IT SHOULD BE SEPARATE MSI
and SEPARATE PROJECT.
There should be absolutely no dependency between openvpn release cycle
and tap release cycle.
It is just like wireshark and libpcap projects.
OpenVPN installer can embed the tap msi and run it during installation.
When tap installed, it should register its version in registry key, so
openvpn may read it in order to connect (currently it is done
hardcoded within openvpn).

The TAP driver should be built and signed using Microsoft toolchain,
there is no problem in that. There is almost a single developer for
the tap driver..
The usermode components may be signed on Linux using the
osslsigncode[3], so actual signing is not an issue, if this is desired
I can submit a patch for "make install" to sign, as I do in other
projects.

Most (99%) users are interested in building custom user mode component
only, so there is no sense in keeping the tap driver as dependency
(build and sign).

Regards,
Alon.

[1] https://www.opensc-project.org/build/
[2] https://www.opensc-project.org/build/browser
[3] http://sourceforge.net/projects/osslsigncode/

2011/11/24 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Hi,
>
> We're having an IRC meeting today, starting at 18:00 UTC on
> #openvpn-devel@...1422... Current topic list is here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2011-11-24>
>
> If you have any other things you'd like to bring up, respond to this
> mail, send me mail privately or add them to the list yourself.
>
> In case you can't attend the meeting, please feel free to make comments
> on the topics by responding to this email or to the summary email sent
> after the meeting.
>
> NOTE: It's required to use a registered Freenode IRC nickname to join
> #openvpn-devel - look here for details:
>
> <https://community.openvpn.net/openvpn/wiki/GettingHelp#DeveloperIRCchann=
el>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

