Message-ID: <48C257A9.6030307@...41...>
Date: Sat, 06 Sep 2008 04:12:57 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20080821181836.GE2516@...30...>	<20080821222720.GA25720@...33...>
	<48AF217A.3030007@...41...>
In-Reply-To: <48AF217A.3030007@...41...>
Subject: Re: [Openvpn-devel] rc9 and external commands
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> Matthias Andree wrote:
>> On Thu, 21 Aug 2008, Alberto Gonzalez Iniesta wrote:
>>
>>> It seems that tightening the security on OpenVPN brought some surprises
>>> [1] to users and broke some features [2].
>>>
>>> As for [1], I included a note in the Debian NEWS file on the new
>>> --script-security option. But those updating a VPN using the very same
>>> VPN (and without previous knowledge of this option) may find themselves
>>> without access to the remote system (if the VPN/system is restarted, and
>>> a script is to be executed). Also, those using NetworkManager [3] aren't
>>> able to specify the '--script-security' option, and since NetworkManager
>>> may/will call external scripts, this new security feature will break
>>> their VPNs. The option is really useful, but 2 would be a more sensible
>>> default IMHO.
>> One might argue that NetworkManager doesn't support all *RC versions of
>> OpenVPN's. At the end of the day, it will be a NetworkManager issue.
>> Interfaces change...
>>
>>> Regarding [2] an strace shows that calls to external commands with
>>> arguments include the arguments as part of the command filename:
>>> For: 
>>> --up "/tmp/foo up"
>>>
>>> The call is:
>>> [pid  3519] execve("/tmp/foo up", ["/tmp/foo up", "tun0", "1500", "1542",
>>> "10.XXX.XXX.X", "10.XXX.XXX.X", "init"], [/* 30 vars */]) = -1 ENOENT
>>> (No such file or directory)
>> Apparently argument splitting - as documented in the --up section of the
>> manpage - no longer works; it was probably formerly done by the implicit
>> /bin/sh -c that is now gone with the switch to exec*().
>>
>> (I didn't check, and didn't check the two Debian BTS reports either.)
>>
>> So either the code needs argument splitting or you need a two-line shell
>> wrapper similar to:
>>
>> #! /bin/sh -e
>> exec /tmp/foo up "$@"
>>
>> Not my call to make.
> 
> I agree that argument splitting in --up "/tmp/foo up" should be
> supported, as it doesn't detract from the sought-after security goals in
> migrating from system() to execve(), and preserves backward compatibility.

Okay, argument splitting should be working again with this patch.

One of the above posters asked if --script-security could be defaulted 
to 2 to preserve backward compatibility.  I would tend to disagree on 
this as it would defeat, in my view, the primary purpose of 
--script-security.

I think the guiding principle here is that security software should 
refrain from doing potentially dangerous things (and I don't think 
anyone can deny that running user-defined scripts from a VPN daemon is 
potentially dangerous) unless explicit permission is given by the user.

------------------------------------------------------------------------
r3311 | james | 2008-09-06 03:42:17 -0600 (Sat, 06 Sep 2008) | 20 lines
Changed paths:
    M /branches/BETA21/openvpn/buffer.c
    M /branches/BETA21/openvpn/buffer.h
    M /branches/BETA21/openvpn/errlevel.h
    M /branches/BETA21/openvpn/init.c
    M /branches/BETA21/openvpn/misc.c
    M /branches/BETA21/openvpn/misc.h
    M /branches/BETA21/openvpn/multi.c
    M /branches/BETA21/openvpn/socket.c
    M /branches/BETA21/openvpn/ssl.c

2.1_rc8 and earlier did implicit shell expansion on script
arguments since all scripts were called by system().
The security hardening changes made to 2.1_rc9 no longer
use system(), but rather use the safer execve or CreateProcess
system calls.  The security hardening also introduced a
backward incompatibility with 2.1_rc8 and earlier in that
script parameters were no longer shell-expanded, so
for example:

   client-connect "docc CLIENT-CONNECT"

would fail to work because execve would try to execute
a script called "docc CLIENT-CONNECT" instead of "docc"
with "CLIENT-CONNECT" as the first argument.

This patch fixes the issue, bringing the script argument
semantics back to pre 2.1_rc9 behavior in order to preserve
backward compatibility while still using execve or CreateProcess
to execute the script/executable.

------------------------------------------------------------------------

