Message-ID: <4F396381.6050905@...1114...>
Date: Mon, 13 Feb 2012 20:24:49 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
In-Reply-To: <7c22eb11c37c167998cc7975576fe585@...1550...>
Subject: Re: [Openvpn-devel] [PATCH] Check for ENABLE_MANAGEMENT for
	ENABLE_CLIENT_CR
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/02/12 19:40, igor@...1550... wrote:
> When building a very minimal OpenVPN for OpenWRT with 
> --disable-management among others, the compilaton fails due to 
> ENABLE_CLIENT_CR being defined, although the management interface, 
> which makes use of it, has been disabled.
> 
> The attached simple patch checks for ENABLE_MANAGEMENT before defining
> ENABLE_CLIENT_CR.
> 

I've already ACKed this patch in another response in this mail thread.  But
here is the complete overview of all patches pushed out on the master branch
for the -testing and -stable source trees.


commit 2ee0dc2bd72ec318fcc227af54e5ca7e1384a6cc
Author: Igor Novgorodov <igor@...1550...>
Date:   Sun Feb 12 22:40:02 2012 +0400

    The code blocks enabled by ENABLE_CLIENT_CR depends on management

    If the management interface is not enabled, it makes no sense in
    including the ENABLE_CLIENT_CR #ifdef blocks.  This will also in
    some configurations cause build issues if these blocks are enabled.

    Signed-off-by: Igor Novgorodov <igor@...1550...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit ecede953d6366e9fbfecea62cc1f61fd2347dab7
Author: David Sommerseth <davids@...1347...>
Date:   Mon Feb 13 16:03:46 2012 +0100

    Remove --show-gateway if debug info is not enabled (--disable-debug)

    The --show-gateway feature depends on functions only being enabled when
    --disable-debug is _not_ used.  As this I consider --show-gateway more
    a handy function for debugging, removing this feature when
- --disable-debug
    is used seems like the proper approach.

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>

commit 22277ec675847f73203bf908144f9903d13e2869
Author: David Sommerseth <davids@...1347...>
Date:   Mon Feb 13 15:52:00 2012 +0100

    Fix compile issues when plug-ins are disabled.

    Commit 1876ccd012e9e2ca6f8e1cd9e7e9bb4bf24ccecb modified
    plugin_call() and introduced plugin_call_ssl().  But the similar
    approach was missing for situations without plug-ins.

    Solution: Rename plugin_call() in the #else !ENABLE_PLUGIN
    section to plugin_call_ssl().  Then move the plugin_ssl() function
    inside the #ifdef ENABLE_PLUGIN section outside the #ifdef, making
    it available for builds with and without plug-ins enabled.

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85Y4EACgkQDC186MBRfrpXCQCfbm+HLw3OwXQb3lcXXs1QWE3q
g5AAn0NvBrUZbEMryUQgVQaX+yNrUuk3
=TeUL
-----END PGP SIGNATURE-----

