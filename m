Message-ID: <4FCA427D.2020504@...1114...>
Date: Sat, 02 Jun 2012 18:42:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-6-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-6-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/8] Add the name of the context where
 option is not allowed to the error message.
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

On 02/06/12 15:03, Arne Schwabe wrote:
> Changes
> 
> Options error: option 'dhcp-option' cannot be used in this context
> 
> to
> 
> P:Options error: option 'dhcp-option' cannot be used in this
> context ([PUSH-OPTIONS])
> 
> Signed-off-by: Arne Schwabe <arne@...1227...> --- 
> src/openvpn/options.c |    5 +++-- 1 files changed, 3
> insertions(+), 2 deletions(-)
> 

ACK.  Will apply this soonish, unless somebody objects during next week.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/KQn0ACgkQDC186MBRfrri5ACaA9G/8yK0yb3t/y7ZIKddKMIg
KT8AoKftgquym05zyrXimZk2DZc+9d6J
=nQLp
-----END PGP SIGNATURE-----

