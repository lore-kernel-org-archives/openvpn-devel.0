Message-ID: <4B97CDF3.6060703@...1114...>
Date: Wed, 10 Mar 2010 17:50:59 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>	
	<4B978D0E.9090606@...1114...>
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
In-Reply-To: <9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 17:42, Alon Bar-Lev wrote:
> This is not the way to do it.
> 
> Use AC_USE_SYSTEM_EXTENSIONS in autoconf, which detects libc settings.
> 
> The current autoconf shape is poor, long ago I offered James to
> rewrite it but he refused. I only made it partially work for cross
> compile.
> 
> There are a lot of none standard/best practice stuff there.
> 
> I did fix automake stuff... :)

Thanks a lot for the feedback!  I am interested in getting this sorted
out.  I'm setting up a RHEL4 box which will be used to check the
lower-end of the autoconf version, which is James' concern about
modifying the current autoconf scripts.

Trust me, I want to fix this issue and get it right. but I'm no big
autoconf expert so all helpful advices are most welcome!

I'm willing to accept patches with updates as long as it don't break the
oldest version OpenVPN need to support (autotools/autoconf v2.59).  If
it can be built an old RHEL4.6 installation, it's good enough for James,
according to the last meeting.

We have also this other update hanging around on the mailing list (cross
compile fixes) which I've not had time to look at yet, which also will
do some updates here as well.


kind regards,

David Sommerseth



> On Wed, Mar 10, 2010 at 2:14 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>>
> On 10/03/10 11:49, David Sommerseth wrote:
>>>> From: David Sommerseth <dazo@...384...>
>>>>
>>>> This is to include peercred support on hosts where _GNU_SOURCE is not
>>>> defined by default.  This issue has been found on Gentoo with glibc-2.8.
>>>>
>>>> The solution was discussed on the IRC meeting March 4, 2010
>>>> in #openvpn-discussions.
>>>> <http://thread.gmane.org/gmane.network.openvpn.devel/3242>
>>>>
>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>> ---
>>>>  syshead.h |    4 ++++
>>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
> 
> This is the "Gentoo patch", modified to be more generic.  In the IRC
> meeting I said I would try to make this change only in socket.c, but
> that was not possible.
> 
> TARGET_LINUX is defined in config.h, and not available before syshead.h
> is included, as that is a wrapper which either includes config.h or
> config-win32.h, depending on OS.  Further defining _GNU_SOURCE after
> including syshead.h would not make any difference at all, as it needs to
> be defined before sys/socket.h is loaded.
> 
> Therefore, I'd prefer a second review on this patch.
> 
> 
> kind regards,
> 
> David Sommerseth
> 
>>
-
------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuXze8ACgkQDC186MBRfrpnMwCgprwvSqOD2aponWxp/Li8/Mg2
kJEAn3T/6k/PNQmbctTuB9ZJ8rO6kFWW
=dMKb
-----END PGP SIGNATURE-----

