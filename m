Message-ID: <4FC89BB3.9010300@...1114...>
Date: Fri, 01 Jun 2012 12:38:43 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120527202737.GV1161@...1296...>
In-Reply-To: <20120527202737.GV1161@...1296...>
Subject: Re: [Openvpn-devel] build revolution lost t_client test?
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

On 27/05/12 22:27, Gert Doering wrote:
> Hi,
> 
> working on the test server, I noticed that t_client.sh was no
> longer run from "make check", and that it lost "read t_client.rc
> from build dir" (which is needed when building different clients
> from a common source dir, and wanting to run t_client with
> different option sets).
> 
> The attached patch restores lost functionality, and adds one extra 
> feature, optionally waiting longer for OpenVPN startup (if the
> server has a high RTT, 10 seconds is not always enough).
> 
> David, this has been tested on FreeBSD 7.4 (so far) and is
> essential for the buildbot client tests :-) - more platform tests
> will follow as soon as I have all the server stanzas up and
> running.
> 
> gert

Applied to master branch and pushed out to -testing and -stable trees.


commit 47c990009c79fe2a96206c54e0240cb2dd8cdf02
Author: Gert Doering <gert@...1296...>
Date:   Sun May 27 23:19:11 2012 +0300

    repair t_client.sh test after build system revolution

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 20120527202737.GV1161@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6616
    Signed-off-by: David Sommerseth <davids@...1347...>


This patch was preferred over the patch from Alon, due to:

- - Both solves the same issue, with minor differences
- - This patch has an informative commit message
- - The alternative doesn't provide any arguments why that approach is
  better; in fact, the commit message is completely lacking.
- - The alternative reduces the information in an error message which
  can be helpful for the user running this test.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Im7AACgkQDC186MBRfrp/ogCbB9GIgwl6c+aU3mjC9xZNn5n6
UPMAoKSxjgbYJOSGHBNHsIKdAwVnOiar
=ZOom
-----END PGP SIGNATURE-----

