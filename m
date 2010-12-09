Message-ID: <4D00AAEA.2050505@...1114...>
Date: Thu, 09 Dec 2010 11:09:46 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTi=0bWqKxGcr7fdiZSG+9h4tFkhm1i2vry_5Rw6E@...278...>	<20101209050405.5497.qmail@...1287...>	<AANLkTikEe8bhZggrC5O4PECKQ6iSfUsJ_OrvUVToj787@...278...>
	<AANLkTi=+cQxk0P+vzyyFyby6X0gp_BUXQNALRd4Gd4op@...278...>
In-Reply-To: <AANLkTi=+cQxk0P+vzyyFyby6X0gp_BUXQNALRd4Gd4op@...278...>
Subject: Re: [Openvpn-devel] how to limite the bandwidth of every client ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: hmy <huangmingyou@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/12/10 09:29, hmy wrote:
> may be I'm wrong ,tc can do that.

First of all, yes tc can do that.  That's the concept of traffic control
and traffic shaping.

Second ... this is the developers mailing list, not the users mailing.
This topic belongs to the openvpn-users list.

Third:
   A: Because it messes up the order in which people normally read text.
   Q: Why is top-posting such a bad thing?
   A: Top-posting.
   Q: What is the most annoying thing in e-mail?

   For more info: <http://www.html-faq.com/etiquette/?toppost>


kind regards,

David Sommerseth


> 2010/12/9 hmy <huangmingyou@...277... <mailto:huangmingyou@...277...>>
> 
>     I think tc can't do this. may be iptables can do it ? 
> 
>     2010/12/9 Peter Stuge <peter@...1287... <mailto:peter@...1287...>>
> 
>         hmy wrote:
>         > I use openvpn in server mode. more than 100 clients to connect it
>         > . I want limit every client's bandwidth ? how to do it ?
> 
>         Suggest on networking layer in the operating system.
> 
> 
>         //Peter
> 
>         ------------------------------------------------------------------------------
>         This SF Dev2Dev email is sponsored by:
> 
>         WikiLeaks The End of the Free Internet
>         http://p.sf.net/sfu/therealnews-com
>         _______________________________________________
>         Openvpn-devel mailing list
>         Openvpn-devel@lists.sourceforge.net
>         <mailto:Openvpn-devel@lists.sourceforge.net>
>         https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF Dev2Dev email is sponsored by:
> 
> WikiLeaks The End of the Free Internet
> http://p.sf.net/sfu/therealnews-com
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0AqugACgkQDC186MBRfrqVPwCfe+NWxApUz0l60cY0a5m2iVLJ
+E0AoIvYbpjE5NDBkT2wyCJ800MWGaVT
=EVKK
-----END PGP SIGNATURE-----

