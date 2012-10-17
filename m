Message-ID: <507E7A7E.5010303@...1147...>
Date: Wed, 17 Oct 2012 11:29:34 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <507E7822.1070006@...1114...>
In-Reply-To: <507E7822.1070006@...1114...>
Subject: Re: [Openvpn-devel] RFC - Usage of --script-security with the
 'system' flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

Hi David,

David Sommerseth wrote:
> Hi all,
>
> I've been reviewing a bug reported to the v2.3 code base.  We're in the 
> beta phase currently, and this is a bug I'd like to get fixed before 
> we're moving on further.  The bug is related to the use of the 'system' 
> flag in --script-security.
>
> <https://community.openvpn.net/openvpn/ticket/228>
>
> The use of the 'system' flag has been deprecated for a long time.  And 
> it is really a potential security issue to use it, due to shell 
> expansions which might happen.  The preferred (and default way) is to 
> use execve(), which is far safer and does not do the shell expansions 
> while executing the script or binary.
>
>   
on Linux the difference is not that big, however watch out for Windows 
servers - with the old (system) like functionality it was possible to 
specify e.g. a VBS script directly. With the 'exec' style you need to 
specify the vbscript.exe, the full path to the script etc etc. There's 
even an example about this in the book you're reviewed for me ;)
If at all possible I'd leave in the 'system' like functionality , as it 
is very valuable for debugging scripts. We can add warnings about it 
being deprecated and the fact that there's the risk of memory leaks , 
but I do see value in this feature.

JM2CW,

JJK


> The fix I'm currently considering is to remove support for the system() 
> call completely.  This support was introduced in 2.1_rc9 (Nov 17, 2008).
>
> Does anyone depend on --script-security where the 'system' flag is 
> required?  If you need this feature, can you please elaborate why this 
> support is needed and why you cannot use the preferred default with 
> execve?
>
> The main differences between execve() and system() calls are:
>
> system() loads a shell before executing the script or binary, which
> also provides all system environment variables defined by
> /etc/profile etc.  On top of that, all the OpenVPN configured
> environment variables are added.
>
> execve() will load and execute the script or binary directly, which
> will only provide the environment variables provided by OpenVPN by
> default.  Example:
>
>    -------------------------------------
>    #!/bin/bash
>
>    printenv
>    -------------------------------------
>
> Using this with '--script-security 2' will dump this out:
>
>    -------------------------------------
>    dev_type=tap
>    ifconfig_local=192.168.100.1
>    proto_1=udp
>    tun_mtu=1500
>    ifconfig_netmask=255.255.255.0
>    script_type=up
>    verb=4
>    local_port_1=10443
>    dev=tap0
>    remote_port_1=10443
>    PWD=/home/test/openvpn
>    daemon=0
>    ifconfig_broadcast=192.168.100.255
>    SHLVL=1
>    script_context=init
>    daemon_start_time=1350465187
>    daemon_pid=19045
>    daemon_log_redirect=0
>    link_mtu=1573
>    -------------------------------------
>
> If you need system variables as well with execve, you can either modify
> the #!/bin/bash line to add --login, or you can source /etc/profile in
> your script.
>
> If you modify the --script-security to look like
> '--script-security 2 system', printenv will dump a rather massive list
> with environment variables.
>
>
>
> * Technical details regarding a possible fix:
>
> The reason this is hard to fix, is that it will require a massive work 
> to avoid memory leaks.  An first example:
>
>    --------------------------------------------------------------------
>      char *envvar = malloc(100);
>
>      snprintf(envvar, 30, "TESTVAL=abc");
>      putenv(envvar);     /* NOTE: We only do putenv() here */
>      system("/bin/sh");  /* echo $TESTVAL returns 'abc' */
>
>      snprintf(envvar, 30, "TESTVAL=123456");  /* A simple change */
>      system("/bin/sh");  /* echo $TESTVAL returns '123456' */
>
>      free(e);
>      system("/bin/sh");  /* echo $TESTVAL is not set */
>    --------------------------------------------------------------------
>
> The current implementation will clean up the environment variables too 
> early when using 'system'.  When using 'execve', OpenVPN provides a the 
> environment variables via a completely different mechanism which cleans 
> up the memory properly at the right time.
>
> The result is that with 'system', we're seeing assertion issues as it 
> is now.  Trying to fix this, leads easily to other fun memory 
> corruption issues.  And fixing this requires a more massive amount of 
> adding proper gc_arena garbage collection higher up in the call paths.  
> This is needed to let the system() call have all the environment 
> variables set by OpenVPN untouched while running and first clean them 
> up afterwards.
>
> Considering that using system() is less safer than execve(), I would 
> prefer to remove support for system(); instead of passing around a lot 
> more gc_arena pointers to get the memory management correct for 
> system() to function properly.
>
> My first hackish attempt (without cleaning it up) gives this change stat:
>
>  $ git diff --stat
>  src/openvpn/misc.c     |   65 ++++++++++++++++++++++++++++++++++++++++++-----------------------
>  src/openvpn/misc.h     |    6 ++++--
>  src/openvpn/platform.c |    6 +++---
>  src/openvpn/platform.h |    2 +-
>  4 files changed, 50 insertions(+), 29 deletions(-)
>
> I personally find that a bit too much to make a deprecated feature work.
> Unless there are some strong arguments why we really do need system()
>
> Any thoughts, ideas or suggestions are most welcome!
>
>
> kind regards,
>
> David Sommerseth
>
>   
> ------------------------------------------------------------------------



