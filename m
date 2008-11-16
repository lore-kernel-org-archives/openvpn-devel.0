Message-ID: <49204019.9080002@...1135...>
Date: Sun, 16 Nov 2008 16:45:29 +0100
From: Jochen Wierum <jochen@...1135...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...>	
	<9e0cf0bf0810111522nc8062afl7e727f9d871875ec@...278...>	
	<48F1AE4F.3040305@...1135...>
	<9e0cf0bf0810120211u2c8ec01ejde17ee36e5483872@...278...>
In-Reply-To: <9e0cf0bf0810120211u2c8ec01ejde17ee36e5483872@...278...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Alon,

> You should not do this.
> You should only use the management interface for all tasks.
I know... but this brings new problems: if the configuration is invalid,
OpenVPN prints a warning to stderr, but not to the management interface.
That makes it hard do debug errors.

> Your configuration should contain the following:
> auth-retry nointeract
> management-hold
> management-signal
> management-query-passwords
> management-forget-disconnect
> 
> So that you can stop/start tunnel using signal SIGUSR1, release from hold.
I'm on it, it will be included in the next release... i hope.

> Management interface only GUI implementation is missing for Windows.
> You can take some example from kovpn [1], it is a good starting point.
I am member of the Free Software Lab an I know the maintainer, Daniel
Molkentin. But as far as I know, kovpn also has some problems.

I started a SourceForge project [1] and a website [2]. I will populate
it the next weeks. Feel free to contribute patches and ideas. Perhaps a
link on [3] is also possible? :-)

Jochen

[1] https://sourceforge.net/projects/openvpnmngr/
[2] http://openvpn.jowisoftware.de/
[3] http://openvpn.net/index.php/documentation/graphical-user-interface.html

> Alon.
> 
> [1] https://projects.fslab.de/projects/kovpn
> 
> On 10/12/08, Jochen Wierum <jochen@...1135...> wrote:
>> The Problem is that I read STDIN and STDOUT of OpenVPN. To do this, I
>>  have to run my Application at least with the same rights as OpenVPN.
>>  OpenVPN has to run as admin to control the routes and the Tap-Device. So
>>  my application has a problem.
>>
>>  If somebody knows a solution how to run a program as administrator and
>>  read STDIN and STDOUT without having administrator rights he is welcome :-)
>>
>>
>>  Jochen
>>
>>
>>  Alon Bar-Lev wrote:
>>  > Great!
>>  > I was expected PKCS#11 enabled GUI for a long time!
>>  > But why does it need administrative rights?
>>  >
>>  > Alon.
>>  >
>>  > On 10/11/08, Jochen Wierum <jochen@...1135...> wrote:
>>  >> Hi,
>>  >>
>>  >>  My name is Jochen Wierum and I'm a student at a university of applied
>>  >>  science in Germany. We work with OpenVPN there. Since a few weeks, we
>>  >>  also have the option to use SmartCards instead of pkcs12 files.
>>  >>
>>  >>  One problem was, that we have laptops which are used by many people with
>>  >>  different SmartCards. But the OpenVPN GUI doesn't give the you
>>  >>  opportunity to select which SmartCard to use. So I wrote an own small
>>  >>  GUI for Windows in C#. It uses the Management Interface to control
>>  >>  OpenVPN. It is very simple and not perfect. One Problem is that it
>>  >>  requires administrator rights in Vista.
>>  >>
>>  >>  It is written in C# 2008 and requires the .NET Framework 2.0. I released
>>  >>  it under the GNU GPL v2.
>>  >>
>>  >>  Perhaps someone thinks it is useful too.
>>  >>
>>  >>  The source can be downloaded at:
>>  >>  http://www.jowisoftware.de/openvpnmanager_src.zip
>>  >>
>>  >>  The binarys are located at:
>>  >>  http://www.jowisoftware.de/openvpnmanager.zip
>>  >>
>>  >>  Jochen
>>
>>
> 
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJIEAY6mq7RFXnOeERCn6tAKDBWja8t/OuPBDnGkzYv4FeClJxAQCeKe/U
nA46AXjrV1Rg8TD6UzOmjrQ=
=FCER
-----END PGP SIGNATURE-----

