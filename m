Message-ID: <49457DAF.3060808@...1114...>
Date: Sun, 14 Dec 2008 22:42:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <18396.65.118.50.246.1229115049.squirrel@...1166...>
	<4942D914.7030605@...1114...> <49447F76.9000709@...1085...>
In-Reply-To: <49447F76.9000709@...1085...>
Subject: Re: [Openvpn-devel] 2.1_rc13 & rc15 Segfault when client connects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Daniel Johnson <progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

Daniel Johnson wrote:
> David Sommerseth wrote:
>> I am willing to believe that this issue might be caused by the
>> plugin, somehow.  I see you posted a auth-pam.c patch, and it might
>> be you have already fixed this issue by now.
> 
> To my understanding, the segfault is indeed occurring when the plugin
> could to be evaluating the username and password, but until I can
> engineer another round of crashes I can't confirm it.  My patch
> merely improves the substitution of "USERNAME" and "PASSWORD",
> and has been in use since my tests began around mid-August.  It could
> still be the source of my occasional crashes, but even then something
> has changed to magnify the effect.

Well, what I struggled with was that I was using the srand() function.  I did not detect any memory
leaks, but I got some pointers which might have become wild.  I replaced my functions to use OpenSSL
rand-functions, and since that time, OpenVPN has been stable.  A stray memory pointer is all you
need to make it crash.

>> One thing to do, to grab more debug info, is to run openvpn server
>> via gdb.  Another approach can be to run it via valgrind (but that
>> chokes performance, noticeably).  That way you will be able to get a
>> backtrace on more where concretely things goes wrong.
> 
> I'll look into using gdb on Monday.  If these were physical machines
> I'd think that valgrind wouldn't hurt too badly, we've only got a
> 3mbps internet connecting in the first place.  But since these are
> VMs....well, do you think valgrind might be an additional burden
> to the host computers?

Valgrind will not give any extra load on the servers, it will just slow down OpenVPN ... and it
easily goes down to 20-25 times slower, so with slow, I really mean reeeeaaaaally sloooooow.  In
small "file" transfers, and especially if not time critical, you might not notice it so much.  But I
guarantee you that you will notice it if you try to stream media over such a link or do bigger file
transfers.

Anyway, valgrind with --leak-check=full gives a good overview.  If run with --show-reachable=yes, it
will provide even more info, but might not reveal too much in this phase.  And be aware, it might
show up a lot of false positives as well.  Many of them seems to be connected to OpenSSL (BIO calls,
among others)

>> The main reason I am guessing it is the plugin, is that I've been
>> writing a plugin myself and struggled with a very unstable OpenVPN
>> solution until I found some NULL pointers and string functions, which
>> caused SEGV.  After those things were sorted out and fixed, the
>> plugin and OpenVPN have been rock solid again.
> 
>> Please confirm my suspicion or send a backtrace from gdb.  To do that
>> in a good way, OpenVPN must have debug information, ie. compiled with
>> '-g'.
> 
> I'll go ahead and compile with -g on both servers, but I think I'll
> wait to upgrade Mercury to v2.1_rc15 until I look at gdb.  Perhaps
> it will be helpful to have one crash in rc13 and one in rc15?

Probably will not make a big difference, if the assumption is correct that the instability is caused
by the plug-in.  Btw. I'm running v2.1_rc15 on the server side with my plug-in
(http://www.eurephia.net/ - also an authentication plug-in, with iptables integration) without any
such issues at all.

Both valgrind and gdb will give an idea of where things crashes.  gdb will be more precise, but
valgrind can often confirm or give a very good indication as well.  If you set ulimit -c unlimited,
you should get a core file as well, which can be used with gdb afterwards.


kind regards,

David Sommerseth

