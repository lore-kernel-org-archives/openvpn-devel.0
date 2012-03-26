Message-ID: <4F703565.3070008@...1114...>
Date: Mon, 26 Mar 2012 11:22:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332575918-3384-4-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] tree: ChangeLog: add ident attribute
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/03/12 08:58, Alon Bar-Lev wrote:
> --- .gitattributes |    1 + ChangeLog      |    2 ++ 2 files changed,
> 3 insertions(+), 0 deletions(-) create mode 100644 .gitattributes
> 
> diff --git a/.gitattributes b/.gitattributes new file mode 100644 
> index 0000000..9cf9e1f --- /dev/null +++ b/.gitattributes @@ -0,0 +1
> @@ +ChangeLog ident diff --git a/ChangeLog b/ChangeLog index
> d498344..d7cc77c 100644 --- a/ChangeLog +++ b/ChangeLog @@ -1,6 +1,8
> @@ OpenVPN Change Log Copyright (C) 2002-2011 OpenVPN Technologies,
> Inc. <sales@...515...>
> 
> +$Id$ +

What is the purpose of this change?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9wNWEACgkQDC186MBRfrqE8wCeJXzMntgvqVJG52zqP0u4YJA/
mCMAnRXr5Uu7f04U300O/7ycFOCFB5rt
=htU2
-----END PGP SIGNATURE-----

