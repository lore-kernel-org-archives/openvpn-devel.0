Message-ID: <4BC47655.10101@...1114...>
Date: Tue, 13 Apr 2010 15:49:09 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1269951178-30419-1-git-send-email-dazo@...384...>	
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
In-Reply-To: <p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
 ./configure information to --version
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

On 10/04/10 09:05, Alon Bar-Lev wrote:
> Highly none standard autotools usage.
> Also requires awk which may not be available.
> Please REVERT.

First of all, let's bring in the history.  This feature was discussed in
the weekly meeting February 26, 2010.  See the chat log at [1], around
the time stamp 20:45:15.

This patch-set provides one way of doing this, and it is a requested
feature.  There are probably several ways how to solve this, this is one
way - and it might not be the best way.  However, it is what we got
right now.

Alon, with all respect, it is great getting feedbacks to submitted
patches, even REVERT suggestions.  Could you perhaps share some thoughts
about how to solve it, instead of just rejecting it?

For now, this patch-set is only in feat_misc branch.  I've halted the
merge into allmerged for now.  But unless we can get a better solution
(meaning: new patches with enhancements) to this feature within
reasonable time, this is how it will look like.  The initial patch is
already ready and accepted.  I am willing to drop using awk or whatever
else, as long as we do get this feature.  How the feature is implemented
is less important.

But this feature will be important for us when we begin to receive
feedbacks on the openvpn-testing version.


kind regards,

David Sommerseth


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/3143>


> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
> On 30/03/10 14:12, David Sommerseth wrote:
>>>> This patch will create ./configure.h which will contain two new #define
>>>> strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED and
>>>> DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
>>>> complete ./configure line which was used when configuring the package
>>>> for building.
>>>>
>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>> ---
>>>>  Makefile.am       |    7 +++++++
>>>>  configure_h.awk   |   39 +++++++++++++++++++++++++++++++++++++++
>>>>  configure_log.awk |   36 ++++++++++++++++++++++++++++++++++++
>>>>  options.c         |    3 +++
>>>>  4 files changed, 85 insertions(+), 0 deletions(-)
>>>>  create mode 100644 configure_h.awk
>>>>  create mode 100644 configure_log.awk
> 
> Applied to the openvpn-testing.git feat_misc branch.  To be merged into
> allmerged soon.
> Commit f27bf509315a48b0070294c3993a718df0c2626c
> 
> 
> kind regards,
> 
> David Sommerseth
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
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvEdlIACgkQDC186MBRfrrimwCfYMO4m2CuY1KPNkLAtHFqL+pr
dqYAn3T0jEowiV9NQZ+8H3onrH+JFb1B
=qAhn
-----END PGP SIGNATURE-----

