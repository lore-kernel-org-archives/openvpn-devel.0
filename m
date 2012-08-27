Message-ID: <503B48EB.5090406@...1114...>
Date: Mon, 27 Aug 2012 12:16:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345727389.42365.YahooMailNeo@...1744...>
	<50364E1E.7000109@...1114...>
	<1345828643.55420.YahooMailNeo@...1750...>
	<503A8633.5090308@...1114...>
	<1346030651.69898.YahooMailNeo@...1752...>
In-Reply-To: <1346030651.69898.YahooMailNeo@...1752...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
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
To: Amm Vpn <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/08/12 03:24, Amm Vpn wrote:
> Hi,
> 
> First I just wanted to know if you are the decision maker for
> OpenVPN?

I am one of more.  But I'm kind of the main community gatekeeper for
the public git trees.  Patches go through me.  But I listen to the
majority of the trusted community members.  Eric is one of them, Heiko
is another one.  But feel free to approach OpenVPN technology people
directly, if you prefer that.

> Because, the reasons/scenarios you are giving do not make sense to
> me. You are not at all considering the real danger (a what-if
> case)
> 
> (Do not take it in offensive way please)

No problem.  But I thought I already did that, even though not
explicitly.  But from what I understand your clients are Linux or BSD
based.  And I still do not see your approach as useful.

a) The user can after having established a connection do a 'ps' and
list all openvpn processes and it's arguments.  Save this and disconnect.

b) Download it's own source code of OpenVPN, and compile it.  Either
on the same box (if all needed tools are needed) or another one with
same libraries and copy over the new executable.

c) Modify the $PATH variable ... or try different approaches to run
its own compiled OpenVPN binary with a modified configuration file
(without --script-dir).

And if that doesn't work ... the user can boot the box into
single-user mode, or with a rescue disk ... and forcefully replace
your openvpn binary on the filesystem.

And how does --script-dir change anything in regards to security in here?

A more sane approach to avoid users from execute random scripts as
root is to:

  1. have openvpn somewhere on the disk where only root can access and
     execute the binary.

  2. Save configs in a directory where only root can read/write and do
     not allow the user to even read these config files at all.

  3. Have a "kick-off" service running, which just takes a reference
     to a configuration file, which can start the openvpn process
     with the appropriate config - and nothing more.  This needs to be
     run with root privileges.

  4. Have a front-end which the user runs completely unprivileged, which
     contacts the "kick-off" service with info about which config to
     start.

Point 3 and 4 is outside the core part of OpenVPN.

This is the only way you can be sure the configurations can't be
modified by the user *except* if the user boots the box using a rescue
tool or similar, where it gains root access to the file system.  Then
the game is lost.

Bottom line is, you need to ensure that your configuration files are
to be trusted.  Telling OpenVPN to bailout if one of the paths in the
config file is wrong, won't add much to improve this situation.  That's
more an annoyance than anything else.

In general, you can't trust any clients.  Security needs to be tackled
on the places you fully control and where the clients have no
possibility to gain root access.  In the moment the user can get root
access somehow, you're out of control.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlA7SOgACgkQDC186MBRfrpX7wCfdEUvdSUtnj2svgJKE4WswAYO
bnQAoJU1QyBLtC+6/4dNJDB+oX3ZHB2i
=ApYy
-----END PGP SIGNATURE-----

