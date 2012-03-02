Message-ID: <4F51227C.1060508@...1114...>
Date: Fri, 02 Mar 2012 20:41:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <97ea10c3e48081835960380fd7ba76e0@...1528...>
In-Reply-To: <97ea10c3e48081835960380fd7ba76e0@...1528...>
Subject: Re: [Openvpn-devel] setting common-name from plugin
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
To: michael-dev <michael-dev@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/03/12 15:32, michael-dev wrote:
> Hi,
> 
> I've got a openvpn radius authentication plugin (username/password) 
> here [1,2]. Though my radius server is really friendly to users (e.g.
>  you might add or strip the domain as you like, upper/lower-case does
> not matter, users might have multiple usernames for different
> reasons), I still want each user to connect only ones to openvpn in
> order to mitigate sharing credentials. Radius has the
> chargeable-user-identity reply attribute that could be used to set the
> common-name, but I did not find any way in openvpn to do this from
> plugin. Could a patch adding a way to set the common name from radius
> plugin similar to return_list in OPENVPN_PLUGIN_CLIENT_CONNECT_V2 be
> accepted?
> 

I'm probably not awake enough to really understand what you try to solve.
 But if you want to change the username to become the common-name after
the authentication, I struggle to see what that really solves.

You seem to have users with multiple usernames, but want them to only
connect once - no matter which user name they use.

The username itself is sent from the client and is never really used in
OpenVPN, except being sent further to either --auth-user-pass-verify or
the a --plugin which has set the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
flag set.

So changing the username from the plug-in would not really make any
difference at all, as a new connection from the same user would still
send the "other" username to the plug-in.

I would rather suggest enhancing your radius plug-in.  On each successful
authentication save the chargeable-user-identity response in a
lookup-table.

For each authentication, first check the user name against this
lookup-table.  If you get a match, tell OpenVPN to reject the connection
(OPENVPN_PLUGIN_FUNC_ERROR).  If there's no match, continue with the
radius authentication, retrieve chargeable-user-identity response and do
another lookup to see if you get a match on this identity instead.  If
you do, reject again.  If you don't have a match, save this identity and
report OPENVPN_PLUGIN_FUNC_SUCCESS.

You would also need to add an extra plug-in hook,
OPENVPN_PLUGIN_CLIENT_DISCONNECT.  This hook need to remove the user from
this lookup table, to allow the user to connect again later on.

Does this make sense to you?


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9RInoACgkQDC186MBRfrrA+wCgh3x98Q5d4qhoUyQz5K0Av2/q
KmUAn3DclppZHfR2YfNKJLwTlPcB47s/
=O5BL
-----END PGP SIGNATURE-----

