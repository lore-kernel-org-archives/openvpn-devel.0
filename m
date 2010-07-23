Message-ID: <4C494C31.7020601@...1114...>
Date: Fri, 23 Jul 2010 10:00:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC] - (ticket #29) - Fix for --push-reset
 resetting --topology and --route-gateway
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
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

In yesterdays developer meeting we discussed Trac ticket #29:
<https://community.openvpn.net/openvpn/ticket/29>

The issue is that when using --topology subnet together with
- --client-config-dir together with a client configuration using
- --push-reset, a little bit too much is removed from the PUSH_REPLY to
the client.

Currently, the --push-reset feature will remove *all* options from the
PUSH_REPLY.  This will harm setup where --topology subnet is used, as
this will implicit do a 'push "topology subnet"' and 'push
"route-gateway X.X.X.X"' to the clients.  When this push is removed via
- --push-reset, it will break the tunnel from function.

A working workaround now is to manually add the needed 'push' statements
in the client configs after --push-reset have been added.

However, we did agree on that this is a misbehaviour and needs a fix.
We discussed three scenarios, and would like some input on which
solution might be most beneficial.



1) Adding a new configure option which "unpush" chosen elements
This will make it possible to do, f.ex '--push-filter route' in ccd
based client configs, which will remove only routes from the inherited
main configuration.

Pro: Very flexible and do not lock certain OpenVPN options as immutable
against a --push-reset

Cons: Adds complexity to those configuring OpenVPN and adds a parsing
overhead to each option when preparing the PUSH_REPLY, to filter out
selected --push statements.



2) Add a new immutable option list for PUSH_REPLY
Currently there are one list which contains all options to be pushed.
This idea is to add a second list which will contain immutable options
when preparing PUSH_REPLY.  If --push-reset is used, this immutable
option list will be pushed anyway.

Pro: No configuration changes is needed.

Cons: Makes the PUSH_REPLY generator a bit more complex, as it needs to
parse two lists.  Need to consider which options should be immutable and
if they should always be immutable or not, depending on other used options.



3) Add a flag to the PUSH_REPLY list indicating if it is immutable
This is a variant of suggestion 2), but uses only one list which is
extended with an immutable boolean flag.  The idea here is that when
adding elements to the PUSH_REPLY list, it will be indicated if this
option is immutable or not by a true/false value.  When preparing the
PUSH_REPLY, the elements which are flagged as non-immutable will be
skipped if --push-reset is activated.

Pro: No configuration changes.  Compared to suggestion 2), it simplifies
the PUSH_REPLY function by just adding an if() statement, compared to
parsing two separate lists.

Cons: All places calling push_option() needs to be adopted to the new
immutable flag argument - or changed to use yet another function,
push_option_immutable(), which will set the immutable flag.  Need to
consider which options should be immutable and if they should always be
immutable or not, depending on other used options.


Does anyone see another solution which is better?  Or which suggestion
do you consider preferable?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxJTCwACgkQDC186MBRfro1ywCeKHXJJh20TaWwgpqCEaSm1iWf
ql8AmwfcS5mOlZe/zWHZiVtqqutUH8Zz
=ByJh
-----END PGP SIGNATURE-----

