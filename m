Message-ID: <5363B7A2.2000109@...1114...>
Date: Fri, 02 May 2014 17:20:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <535ECBB0.2060709@...1901...>
	<5362D3E9.3090001@...1114...>	<5362FA6D.904@...1901...>
	<20140502072322.GT16637@...1296...>
In-Reply-To: <20140502072322.GT16637@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [PATCH] Add support for
 specifying the syslog facility, as requested  in trac #188.
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/05/14 09:23, Gert Doering wrote:
> Hi,
>
> (why is this being discussed on -users?  Taking it over to -devel)
>
> On Thu, May 01, 2014 at 09:52:45PM -0400, Timothe Litt wrote:
>> e.g. the following are valid:
>>            --daemon
>>                      Daemonize, use the default progname (from PACKAGE)
>> for syslog
>>
>>            --daemon my-vpn-daemon
>>                      Daemonize, use "my-vpn-daemon" for the syslog progname.
>>
>>            --daemon [local1]
>>                      Daemonize, use the default progname, use the local1
>> syslog facility (unless --syslog-facility already specified one)
>>
>>            --daemon my[local1]-vpn-daemon  --daemon
>> [local1]my-vpn-daemon --daemon my-vpn-daemon[local1]
>>                      Daemonize, use "my-vpn-daemon" for the syslog
>> progname.
>>                                           Use the local1 syslog facility
>> (unless --syslog-facility already specified one)
>
> Uh.  Feature-NAK - especially the last one really makes me want to throw up.
>
> Using [] as part of an option string is a bad idea, because it is commonly
> used for optional arguments (as you saw in David's question), and intermixing
> option argument "A" and "B" in the same string is not going to help anyone.

Agreed!

> If we take this at all - and I have reservations, because the amount of
> code it brings in is quite significant - it should not touch the --daemon
> command line.  It brings it's own config statement (--syslog-facility),
> so there really is no reason to mess up the syntax for --daemon.
>
> Also, --syslog-facility should be more clean, like
>
>   --sysloc-facility facility [progname]
>
> with "progname" actually being *optional*, not "marked by using rectangular
> brackets".

Agreed as well.  This is primarily what I'd expect this to do too.

> [..]
>> As I explain above, this is to make it possible to specify a facility
>> name in cases where the system init script uses --daemon before the user
>> can put a --syslog-facility.  --syslog-facility must precede --daemon or
>> --syslog because the latter two immediately switch logging to syslog;
>> they are what consume the facility code when they call openlog().
>
> Init scripts can be adjusted.   Obscure code inside OpenVPN stays forever
> (guess why the developers have so little time?  right, maintaining stuff
> that someone else considered "a clever hack" 5 years ago).

On distros which don't have package management, this is probably a fine thing. 
  But on most Linux distros with package management, init.d scripts will be 
replaced on package updates.  As we don't provide init.d script for all 
distros, it will not really be possible to change this.  Further, it's not 
that uncommon that software adds a facility option, so I find this core 
feature a good enhancement.

But!  I do not like the [] syntax.  The core principle in OpenVPN's option 
parsing is that the last argument wins.  So if you have f.ex. --ping-exit 3 
times in a command line and two times in a config file, it's the last one 
which really sets the option.  --syslog-facility should be no different.

IMO, distro init.d scripts should add the config file as the last argument 
when they kick off openvpn.  If they add stuff which overrides the config 
file, then it's a bug in the init.d script.

Anyway NAK to the v2 patch.  Because it really didn't give answers to many of 
my questions.

- We do not need SYSLOG_CAPABILITY, is there another #ifdef which restricts
   SYSLOG somehow?  If yes, use that, if not, don't do this.

- Why not re-use facilitynames[] from sys/syslog.h, instead of adding
   something which is basically a duplicate of exactly that lookup table?

- Further, why the #ifdef's on LOG_FTP, LOG_SYSLOG, LOG_UUCP?

- Don't fiddle around with malloc().  Use gc_arena and the string buffer
   functions defined in buffer.c/h


Please, make the next round a far more simpler version, reuse what is already 
implemented and well tested other places rather than re-inventing the wheel.

Using --syslog-facility is a bare minimum acceptable but not preferred. 
Rather consider --daemon [progname] [facility]  and --syslog [progname] 
[facility].  If facility is not set, default to whatever is the default now 
(IIRC, it is syslog).


-- 
kind regards,

David Sommerseth

