Message-ID: <4D87C556.3000606@...1114...>
Date: Mon, 21 Mar 2011 22:38:30 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTinSNNNtmS78KquJbmA81eZdxubr1rdZcKHD0Y0n@...278...>
In-Reply-To: <AANLkTinSNNNtmS78KquJbmA81eZdxubr1rdZcKHD0Y0n@...278...>
Subject: Re: [Openvpn-devel] [PATCH] common_name passing in auth_pam plugin
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
To: Joe Patterson <j.m.patterson@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/03/11 17:44, Joe Patterson wrote:
> I had wanted to have the capability of forcing users to match their
> username with their cert common name.  It's possible to do this using
> the environment variables passed to an auth script, but I figured it
> would be useful to add the capability to the auth_pam plugin.  It
> would be nice to be able to pass arbitrary strings from envp to pam so
> that you could, for instance, use an OU to hold a domain or realm name
> or some such, but for now I'm just passing the common_name and using
> it to replace "COMMONNAME", much as the USERNAME and PASSWORD strings
> get replaced in the pam auth dialog.  Here's the patch for the 2.1.3i
> source I pulled from svn (apologies if this format isn't as it should
> be, I seldom submit code anywhere):
> 

Thank you very much for your patch.  Unfortunately I cannot make this patch
apply to the git tree which we primarily use now for community patches.  If
you can please fix this and resubmit this patch, I'll make sure this one
gets applied to the bugfix2.1 branch.

One comment:
@@ -709,7 +715,8 @@
     {
     case COMMAND_VERIFY:
       if (recv_string (fd, up.username, sizeof (up.username)) == -1
- -          || recv_string (fd, up.password, sizeof (up.password)) == -1)
+          || recv_string (fd, up.password, sizeof (up.password)) == -1
+        || recv_string (fd, up.common_name, sizeof (up.common_name)) == -1)

It seems like you're missing some spaces in the if() statement.  Please fix
this as well.

I'm keen on giving this one an ACK.  This seems sensible at first glance to me.

A very quick git crash course:

 $ git config --global user.name 'Your name'
 $ git config --global user.email 'my@...1452...'
 $ git clone
git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git
 $ cd openvpn-testing
 $ git checkout -b bugfix2.1 origin/bugfix2.1
[do your hacking, applying your patch changes]
 $ git add <modified files>
 $ git commit -s
 $ git format-patch origin/bugfix2.1..HEAD

This last command produces a patch file for each commit you have done.
Please send these patch files to the mailing list again for another review.

For more info about the development process, look here:
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>

For a little bit more verbose git crash course:
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2HxVYACgkQDC186MBRfrplqwCeP4Swqfhg6L2otdSE9K9hAtYn
dzUAnjcM5adFKpiDRraGEwC7aw9rHTKf
=1xSv
-----END PGP SIGNATURE-----

