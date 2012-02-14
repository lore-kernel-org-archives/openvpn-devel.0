Message-ID: <4F3A41B0.3090701@...1114...>
Date: Tue, 14 Feb 2012 12:12:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329216527-14035-1-git-send-email-davids@...1347...>
In-Reply-To: <1329216527-14035-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Connection entry {tun,
 link}_mtu_defined not set correctly
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

On 14/02/12 11:48, David Sommerseth wrote:
> Commit 76809cae0eae07817160b423d3f9551df1a1d68e enabled setting MTU 
> variables inside <connection> blocks.  But in that process, the 
> tun_mtu_defined and link_mtu_defined was not set as it should.
> 
> By moving this out of the options_postprocess_mutate_invariant() 
> function and into options_postprocess_mutate_ce(), these variables
> get these *_mtu_defined variables are set correctly in each
> connection entry.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c | 32
> +++++++++++++++++--------------- 1 files changed, 17 insertions(+), 15
> deletions(-)
> 

Just a bit more useful info, why this is needed.  If you just put the
- --remote option in a connection block like this:

<connection>
remote x.x.x.x 1194
</connection>

Then you will get an assert() error in mtu.c in the frame_finalize().

With this patch, it will work as expected, both with no connection
blocks, one like the example above or more connection blocks.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk86QbAACgkQDC186MBRfrrM3wCdG5sB6PPj3ruB/1eX1QtbPFqS
xYEAn3JWSDWWo3Tm5YYF39Gk/+P17eSV
=h8Dd
-----END PGP SIGNATURE-----

