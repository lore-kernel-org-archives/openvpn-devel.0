Message-ID: <4FAFF93F.8010403@...1114...>
Date: Sun, 13 May 2012 20:11:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
In-Reply-To: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
 - Discussion Summary
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>
Cc: Alon Bar-Lev <alon.barlev@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/05/12 18:55, Alon Bar-Lev wrote:
> Hello,
> 
> Now, I also have the courage to ask one more question regarding 
> build....
> 
> We currently have: - auth-pam - defer - down-root - examples

I'm just giving a summary here of the discussion, how I see the
discussion.  And hope we can close this one soon.  The thread is
long and many of the arguments are repeated several times.

Basically, the situation is as now:

Those who opposes a split now are Adriaan, Gert and I, which are all
active with development in the tree.  Seth has also voted against.
And Eric says "not before v3.0".

Those in favour are Alon, Samuli and Eric after v3.0.

- ----------------------------------------------

Then let's look at the commit history for these plug-ins which are
discussed.  The git log goes back to the old BETA21 SVN branch.

auth-pam/auth-pam.c   - 17 changes
auth-pam/pamdl.c      -  7 changes
auth-pam/pamdl.h      -  6 changes
down-root/down-root.c - 12 changes

That is the total number of changes to each of these files since
September 26, 2005.

Further, all *nix platforms have the concept of root users and can do
seteuid() stuff (which makes down-root useful) and all uses PAM as
recommended default (which makes auth-pam useful)

- -----------------------------------------------

So to summarize it, how I see it:

* There is resistance to such a split
* These modules are generally useful on all *nix platforms
* They are not requiring a lot of extra maintenance at all currently
* Current inclusion in main tree makes package maintainers more happy

When the maintenance burden of having these *two* plug-ins in the main
tree gets so big it affects the core openvpn development and release
cycles - that's the time it is appropriate to consider a split.

So, please!  Can we rather spend our precious time and energy to fix
*real* bugs?   <https://community.openvpn.net/openvpn/report/1>

And this is the last thing I'm going to say in this discussion.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+v+T0ACgkQDC186MBRfrp5TACfeIKA5P2GBfKVO031KnXpmo2W
UEkAoJEsZEgN7y5z9qcPjHa1/C3U5i6b
=1/kX
-----END PGP SIGNATURE-----

