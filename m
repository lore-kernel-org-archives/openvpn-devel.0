Message-ID: <4FCA3E23.9010805@...1114...>
Date: Sat, 02 Jun 2012 18:24:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-2-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-2-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/8] Silence Port is now 1194 IANA
 warning if remote option with port is used
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


First of all, thank you very much for your work on this patch set!
And you have a lot of good things here.

So to this patch ...

On 02/06/12 15:03, Arne Schwabe wrote:
> 
> Signed-off-by: Arne Schwabe <arne@...1227...> --- 
> src/openvpn/options.c |    1 + 1 files changed, 1 insertions(+), 0
> deletions(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> 08f9cb2..8e5d3b9 100644 --- a/src/openvpn/options.c +++
> b/src/openvpn/options.c @@ -4506,6 +4506,7 @@ add_option (struct
> options *options, goto err; } re.remote_port = port; +
> options->ce.port_option_used = true;

Instead of this change, wouldn't it rather make sense to just remove
the whole "#if 1 /* JYFIXME -- port warning */" block in init.c:2470
instead?  This "new" port number was introduced in November 2004, so
I'd say this warning has been laying around long enough.

When doing that, we can also get rid of the port_option_used member
completely too.  If you do:

   $ git grep -n port_option_used

in the source tree, you see where this is used, and it's not many
places at all.


kind regards,

David Sommerseth


> if (p[3]) { const int proto = ascii2proto (p[3]);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/KPiAACgkQDC186MBRfrouAACgmv1F0CiIM0HyrhNYAFltqpPv
szEAnj8O/j/vqx8884KDjZlNrLhLOfyh
=fMoA
-----END PGP SIGNATURE-----

