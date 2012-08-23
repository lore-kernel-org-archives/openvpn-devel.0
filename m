Message-ID: <50364E1E.7000109@...1114...>
Date: Thu, 23 Aug 2012 17:37:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345727389.42365.YahooMailNeo@...1744...>
In-Reply-To: <1345727389.42365.YahooMailNeo@...1744...>
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
To: "ammdispose-vpn@...109..." <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/08/12 15:09, ammdispose-vpn@...109... wrote:
> Hello all,
> 
> I am submitting a minor patch which includes an option to specify
> --script-dir.
> i.e. any user defined script will be run ONLY IF it is present in
> "script-dir".
> 
> The reason I needed this is because I had a frontend to configuration
> file which allowed administrator to change configuration.
> 
> I also have script-security set to 2 because I wanted to run a script
> when client connects.
> 
> These two option make it insecure. As admin (with bad intention or if
> admin password is leaked) can simply call "rm -rf /" for certain commands.
> 
> So my idea was
> 1) Add a new option called script-dir
> 2) Frontend will not allow word "script-dir" in config file (so admin
> cant change it)
> 3) script-dir will be passed on command line
> 
> This way admin can not run anything other than what I have put in
> script-dir. This also helps prevent accidentally run script in some
> other path.

This patch will indeed do what you propose, and to some degree I can see
the purpose.  But this kind of sanity checks does not belong inside
OpenVPN, IMO.  Putting it here, is the most difficult place to put it.

There are two approaches for this kind of security.  If you have a gun,
you can either lock it safely inside some lockers, to avoid your kids
playing with it.  Or you can add an advanced trigger mechanism which
checks if it's an adult holding the gun when trigger is pushed.  Then
let your gun float around on the floors where you find it practical, not
minding your kids playing with it.  The approach on your patch reminds
me of the latter one.  I suggest going for the former one.

Rather design your solution so that the OpenVPN executable can 100%
trust the input it is given, effectively putting the responsibility for
security/sanity to the front-end which starts OpenVPN.

Your patch also adds the condition that *any* front-end cannot allow
"script-dir" in the configs.  Which means more GUIs needs to be modified
to filter out this statement from users configs, if found.  This won't
work out in reality.

I'm also worried about potential ways this can be abused as well.
Something along where the sysadmin prepares /usr/share/openvpn/scripts
as the place for all safe scripts.  And somehow the user manages to
replace this path with /home/mrevil/myscripts ... and then these "evil
scripts" in that directory are run with elevated privileges.  In this
case, --script-dir would cause a false sense of security.

Also adding this as a runtime parameter is tricky, as the options parser
is recursive.  Lets take an example with three config files and a
command line override:

....config-1.cnf......
dev tun
config config-inc.cnf
......................

....config-inc.cnf...
key client.key
cert client.crt
ca ca.crt
.....................

....config-client.cnf.....
client
remote x.x.x.x 1194
..........................

And from the command line:

 $ openvpn --config config-client.cnf \
      --remote y.y.y.y --config config-1.cnf

(of course, it's not a complete config ... but you hopefully get the idea)

And adding --script-dir in a safe way to avoid this to be abused
requires a much more well thought patch than this simple approach you
suggested here.  From where should --script-dir be allowed, and in which
order?  All to avoid being overridden somehow.

To make your idea bullet-proof inside OpenVPN, --script-dir would have
to be a compile time restriction, where OpenVPN is hard-coded with which
directory to trust.  But this won't scale well, as then each who wants
this needs to compile their own OpenVPN according to their requirements.

So for me, it makes more sense to put this --script-dir feature into the
GUI/front-end, where it can better do the proper sanity checks of the
configs, and prepare a sanctioned openvpn command line *before* OpenVPN
is started.  This way it will be harder to abuse OpenVPN, if the openvpn
binary is well protected.

This way we can also keep OpenVPN simpler, and still stay flexible for
those who need more flexibility too.  And I hope to see that we can
reduce the complexity of OpenVPN even further, preferably so much that
it can be configured to be started completely by an unprivileged user on
all platforms and still being able to configure the network correctly.
The default approach of OpenVPN currently is to depend on root/admin
privileges for network configurations.

Bottom line is, I'm giving a NAK to this patch.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlA2ThsACgkQDC186MBRfrpfAACgjBKKp5I6VByWqYutsuw6l227
698AnRb0MfO0MyAk0CPtWoMAbCPCulA9
=60wm
-----END PGP SIGNATURE-----

