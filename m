Message-ID: <4DD6389E.2000209@...1114...>
Date: Fri, 20 May 2011 11:47:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1305544215-12654-1-git-send-email-davids@...1347...>
In-Reply-To: <1305544215-12654-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Make '--comp-lzo no' the default
 behaviour if LZO is enabled
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

On 16/05/11 13:10, David Sommerseth wrote:
> This makes 'comp-lzo' pushable without requiring clients to have
> --comp-lzo defined in the client configs.  To make 'comp-lzo' not
> pushable on the client, a new 'disabled' argument have been added.
> 
> Trac-ticket: 128
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  openvpn.8 |   12 ++++++------
>  options.c |   10 +++++++---
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 

As announced on the developers meeting yesterday (Samuli will paste the
summary with the discussion), I'm withdrawing this patch in the current form.

The reason is that the OpenVPN wire protocol changes slightly when using
'--comp-lzo no' versus not having --comp-lzo in the config file.  This
change will cause server/client incompatibilities.

Alon proposed another approach with white/blacklist of pushed options which
should be processed.  And this approach do make a lot of sense, and we
should implement this as well.  But this will be a bigger change.

However, I'm looking at a different approach right now isolated to
- --comp-lzo, where OpenVPN can detect incompatible --comp-lzo settings and
rather provide a better error and stop OpenVPN.  This I consider better
than to try to reconnect indefinitely when critical config options on
client and server is incompatible.

- From a quick brain storm, for --comp-lzo, the only compatible/valid
combinations are:

   Client                      Server
   (no --comp-lzo)             (no --comp-lzo)
   --comp-lzo {,adaptive} (*)  --comp-lzo {,adaptive}
   --comp-lzo yes         (*)  --comp-lzo yes
   --comp-lzo no          (*)  --comp-lzo no

(*) In these combinations, comp-lzo should be pushable which can change the
client setting.  If client does not have comp-lzo in its config, it should
disconnect from the server if the server pushes --comp-lzo settings, as the
wire protocol from the server will be different from what the client expects.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3WOJ4ACgkQDC186MBRfrq8/gCfYJz7aoPQwNrSTIaz9letMTTC
ufsAnR7MdJtsZz6wvRyJOxCwKOU3tZcs
=SaAA
-----END PGP SIGNATURE-----

