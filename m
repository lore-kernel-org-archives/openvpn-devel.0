Message-ID: <4B8AF4AD.8060402@...1114...>
Date: Sun, 28 Feb 2010 23:56:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>
	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
	<4B8A8DC9.3020502@...1114...>
	<20100228221425.GT9556@...1296...>
In-Reply-To: <20100228221425.GT9556@...1296...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 23:14, Gert Doering wrote:
> Hi,
> 
> On Sun, Feb 28, 2010 at 04:37:45PM +0100, David Sommerseth wrote:
>> On 28/02/10 16:10, Eric F Crist wrote:
>>> ACK,
>>>
>>> It's not you, that's duplicate code.
>>
>> ACK.  I this is indeed duplicated.
> 
> Thanks.  I have committed this to my branch (because I'm too tired right 
> now to get branching right) as dd66b12647852e3f1267be70b0fb3b11deedf377
> 
> David, could you please pull my branch from Berni, and move that patch
> to wherever bugfixes/code cleanups go?  It should merge easily into 
> all branches.

Pushed and pulled.  I've only put your extra commit into the bugfix2.1
branch (as a cherry-pick), and merged it into allmerged.

At some point, you might consider to pull in the bugfix2.1 branch into
your feat_ipv6_payload branch, just to get in those bug fixes.

> (As a side note: there is new IPv6 related code in my branch, of course,
> so please pull that to feat_ipv6_payload as well :-) - mostly code cleanups,
> and Win32 preparations)

Done!

A crash course for branching:

  git checkout -b <my branch name> <branch point>

Branch point can be a commit ID, a tag name or another branch name.
It's that easy :)  This will also "move" you over to the new

If you want to branch without "moving" over to the newly created branch,
you can use:

   git branch <branch name> [<branch point>]

If you don't provide branch point, it will branch at your last commit in
the branch you are at when doing this.

To push a new branch ... git push <remote name> <branch name>.



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuK9KwACgkQDC186MBRfroEnwCfdDZ2buGz50TAjUuZyp0hb0SG
4KMAoJQX0eKkhXFF7sfjMrXUG1c+MTJ4
=QWB7
-----END PGP SIGNATURE-----

