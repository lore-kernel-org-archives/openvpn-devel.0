Message-ID: <4F4D08EF.6040404@...1114...>
Date: Tue, 28 Feb 2012 18:03:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <4F4D019B.2090704@...1030...>
In-Reply-To: <4F4D019B.2090704@...1030...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 released
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 17:32, Mr Dash Four wrote:
> 
>> * Improved plug-in API (v3) which can more easily be expanded in
>> the future: includes support for direct access to X.509 certificate
>> data in plug-ins [...] * One-to-one NAT to circumvent IP address
>> conflicts between local and remote networks
>> 
> Is there any help/doc/wiki where I could get more information/learn
> more about these new features?

For the plug-in API ... look at openvpn-plugin.h ... look for
openvpn_plugin_*_v3.  Especially openvpn_plugin_open_v3() and
openvpn_plugin_func_v3().  If fact, most of the openvpn-plugin.h is a
pretty comprehensive reference for the plugin API.  For a working
example, look at plugin/examples/log_v3.c.

For the --client-nat ... look at the man new page.
<http://openvpn.net/index.php/manuals/523-openvpn-23.html>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NCO0ACgkQDC186MBRfrpXDQCghQoK0eW927kHqHtzri5KOdme
p2IAn0WIwLjrv5rTwWtA7FcFzo5IKLbU
=zu4J
-----END PGP SIGNATURE-----

