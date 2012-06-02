Message-ID: <4FCA4403.7070702@...1227...>
Date: Sat, 02 Jun 2012 18:49:07 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-2-git-send-email-arne@...1227...>
	<4FCA3E23.9010805@...1114...>
In-Reply-To: <4FCA3E23.9010805@...1114...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 02.06.12 18:24, schrieb David Sommerseth:
>
> First of all, thank you very much for your work on this patch set!
> And you have a lot of good things here.
>
> So to this patch ...
>
> On 02/06/12 15:03, Arne Schwabe wrote:
>
> > Signed-off-by: Arne Schwabe <arne@...1227...> ---
> > src/openvpn/options.c | 1 + 1 files changed, 1 insertions(+), 0
> > deletions(-)
>
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> > 08f9cb2..8e5d3b9 100644 --- a/src/openvpn/options.c +++
> > b/src/openvpn/options.c @@ -4506,6 +4506,7 @@ add_option (struct
> > options *options, goto err; } re.remote_port = port; +
> > options->ce.port_option_used = true;
>
> Instead of this change, wouldn't it rather make sense to just remove
> the whole "#if 1 /* JYFIXME -- port warning */" block in init.c:2470
> instead? This "new" port number was introduced in November 2004, so
> I'd say this warning has been laying around long enough.
I did not realise that the warning is around that long. It is probably
more confusing than helping now.

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/KRAMACgkQe8+cMNS4zRceugCfRbJ/CdSV7/fSCkJXQhFsablz
ycYAoJB9dUw8w3Va1Hz3U6WNxjK2XuVP
=dSi/
-----END PGP SIGNATURE-----


