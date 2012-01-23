Message-ID: <4F1D2474.3020501@...1114...>
Date: Mon, 23 Jan 2012 10:12:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120122214129.GJ5060@...1296...>
In-Reply-To: <20120122214129.GJ5060@...1296...>
Subject: Re: [Openvpn-devel] t_client.sh enhancements
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

On 22/01/12 22:41, Gert Doering wrote:
> Hi,
> 
> I run all my cross-platform clients tests via t_client.sh, and a few 
> things started to annoy me:
> 
> - must run "make check" as root (which is problematic for buildbot) -
> just prints "test #4", but doesn't tell me what this particular test 
> is doing ("tcp/tap/ipv4-only").
> 
> So - add a variable that can be used to call sudo, and add another
> set of config variables that will make it print out a user-specified
> title of what it's doing.  Fairly trivial, really, but might be useful
> for someone else as well :-)

Just one comment, please feel free to put such verbose messages directly
in the commit log.  The more verbose they are, the easier it is in the
future to understand what were were thinking when adding these commits.

Anyhow ... ACK!  Applied to master branches on -testing/-stable.

commit 9c6ee9d1ecd85535c5529df1144fb02f613f5134
Author: Gert Doering <gert@...1296...>
Date:   Sun Jan 22 22:37:25 2012 +0100

    add "print test titles" and "use sudo" functionality to t_client.rc

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8dJHQACgkQDC186MBRfrqBgwCeMVXsQW7uMbU9g4Jrjm4QfbLZ
iTkAoJYuntv7qjAGJsf0jas8cvrpodlA
=tM9Q
-----END PGP SIGNATURE-----

