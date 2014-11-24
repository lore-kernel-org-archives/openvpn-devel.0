Message-ID: <5473551D.3070403@...1114...>
Date: Mon, 24 Nov 2014 16:56:13 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>	<54705AA4.2010105@...1856...>
	<20141122102138.GA17158@...1296...>	<547069A9.8020306@...1227...>
	<20141122115728.GB17158@...1296...>
	<CAGm1_ktj1i_DfuXwBYrKX1qk-sZHpxV8jR6Fbr4TnSJgGdFNvA@...278...>
In-Reply-To: <CAGm1_ktj1i_DfuXwBYrKX1qk-sZHpxV8jR6Fbr4TnSJgGdFNvA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Yegor Yefremov <yegorslists@...1030...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 23/11/14 20:49, Yegor Yefremov wrote:
> On Sat, Nov 22, 2014 at 12:57 PM, Gert Doering <gert@...1296...> wrote:
>> Hiya,
>>
>> On Sat, Nov 22, 2014 at 11:47:05AM +0100, Arne Schwabe wrote:
>>> Almost anybody always turns this feature on, at least all distribution
>>> have it on.
>>
>> Which is indeed a strong argument for removing the conditional... maybe
>> quickly discuss this ("anyone strongly opposed?") at the next meeting?
> 
> Btw another mismatch:
> 
> AC_ARG_ENABLE(
>         [small],
>         [AS_HELP_STRING([--enable-small], [enable smaller executable
> size (disable OCC, usage message, and verb 4 parm list)
> @<:@default=yes@:>@])],
>         ,
>         [enable_small="no"]
> )

That some features are disabled by default is not related to any kind of
"mismatch".  First things first.

Regarding --enable-password-save, I don't see any reasons why we want to
change that.  I don't buy the argument that "all distros do it", because
they already have added --enable-password-save in their build tools.  In
fact, for those who depend on this being disabled by default may get a
bigger surprise if we change this default.  And it's been off by default
since the beginning of OpenVPN, iirc, so this may have a bigger impact
than what we can foresee right now.  Changing defaults are tricky,
especially when it comes to compile time options.

The only place this is enabled by default is on our Windows binary
builds, as it would be generally too much to ask Windows users to
rebuild OpenVPN themselves with this feature enabled + we had several
queries about this feature from Windows users.  For non-Windows
environments, people are usually far more capable of building OpenVPN
themselves and if not, they can report this to the package maintainers
for their distros and they can decide whether this is a good idea or not
for their distro.

So I'm saying NACK on --enable-password-save unless I get a really good
argument why we need to change this default.


When it comes to --enable-small.  I encourage you to try that on your
own box first and to see what happens with --help and the log files.
Further, go through the source code and look for #ifdef ENABLE_SMALL,
and you might get yourself a big surprise, especially when playing with
the --verb option in the config.

The --enable-small feature is here to reduce the size of the openvpn
binary by reducing information generally not found useful on embedded
systems - due to people configuring these systems generally have a
better understand of what they are doing and can do their testing on
systems without --enable-small.  For "normal" users, it is generally far
better to have the "fatter" version of OpenVPN.


Please don't fall into the trap thinking that "everything should be
enabled by default".  It's really not that simple.


--
kind regards,

David Sommerseth

