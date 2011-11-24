MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B90128A57E9B4@...1436...>
References: <4ECE04B8.3000100@...515...>
	<1CED409804E2164C8104F9E623B08B90128A57E9B4@...1436...>
Date: Thu, 24 Nov 2011 11:41:24 +0200
Message-ID: <CAOazyz3MMoTPXHau65fR8aWB1Yuzk-q3Y+14AAqCDHbG6evCLw@...278...>
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I hate CMake, it is way too complex, these guys re-invented the wheel
with no decent reuse of any methodology / language that existed
before.
If we take SCons as another example, it took python and used it to do
build... So if you are python developer most probably you know how to
SCons.
Also, look the huge backlog of bugs of CMake, it is amazing!

Common to both CMake and SCons is the ability to work with Microsoft
toolchain to produce binaries. This is a great advantage over the
autotools. However, these tools are inferior when it comes to
autotools (provided you know what you are doing) in *NIX, embedded and
cross compile.

To build using CMake or SCCons you need these tools on *TARGET*
machine, these tools has LONG LIST of dependencies. To build using
autotools you need POSIX utils (sh, sed, ls, rm, ...) and POSIX make
and that's it!

I don't mind if for Windows CMake/SCons will be maintain in addition,
keep autotools usage for windows cross compile and *NIX build using
autotools.

Alon.

On Thu, Nov 24, 2011 at 11:25 AM, Adriaan de Jong <dejong@...1435...> wrote:
> Just to put in my 2cents on the build options: there is a tool that suppo=
rts all of those environments (gmake, cygwin, mingw, nmake, visual studio, =
eclipse, ....), and that's CMake. It's widely used, and has a pretty good t=
rack record. It can also support automated test environments and packaging.
>
> It has one major disadvantage: the current build system would need to be =
converted from an autoconf-based to a new CMake-based system, together with=
 all of the knowledge contained within it. Further, there is less knowledge=
 of CMake than autoconf within the OpenVPN community.
>
> Disclaimer: I'm not trying to start a holy war here, I know every system =
has its own advantages and drawbacks. I just want to get the option on the =
table :). I've had some positive experience with CMake, through PolarSSL an=
d some projects at work. I'll try to make it to the meeting this evening fo=
r the discussion.
>
> Kind Regards,
>
> Adriaan
>
>> -----Original Message-----
>> From: Samuli Sepp=C3=A4nen [mailto:samuli@...515...]
>> Sent: donderdag 24 november 2011 9:48
>> To: openvpn-devel@lists.sourceforge.net
>> Subject: [Openvpn-devel] Topics for today's meeting
>>
>> Hi,
>>
>> We're having an IRC meeting today, starting at 18:00 UTC on #openvpn-
>> devel@...1422... Current topic list is here:
>>
>> <https://community.openvpn.net/openvpn/wiki/Topics-2011-11-24>
>>
>> If you have any other things you'd like to bring up, respond to this
>> mail, send me mail privately or add them to the list yourself.
>>
>> In case you can't attend the meeting, please feel free to make comments
>> on the topics by responding to this email or to the summary email sent
>> after the meeting.
>>
>> NOTE: It's required to use a registered Freenode IRC nickname to join
>> #openvpn-devel - look here for details:
>>
>> <https://community.openvpn.net/openvpn/wiki/GettingHelp#DeveloperIRCcha
>> nnel>
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>> -----------------------------------------------------------------------
>> -------
>> All the data continuously generated in your IT infrastructure contains
>> a definitive record of customers, application performance, security
>> threats, fraudulent activity, and more. Splunk takes this data and
>> makes sense of it. IT sense. And common sense.
>> http://p.sf.net/sfu/splunk-novd2d
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
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
>

