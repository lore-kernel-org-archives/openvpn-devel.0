Message-ID: <4BCB8A6B.7080608@...1114...>
Date: Mon, 19 Apr 2010 00:40:43 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC8A2EA.9070602@...1147...>
In-Reply-To: <4BC8A2EA.9070602@...1147...>
Subject: Re: [Openvpn-devel] man page patch
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

On 16/04/10 19:48, Jan Just Keijser wrote:
> man page patch to fix (based on the git page).
> 
> - explicit-exit-notify text is misleading : parameter [n] is the number 
> of attempts not the number of retries
> 
> - I would make a statement that a section starting with 'so I would make 
> a statement' does not belong in a man page
> 
> 
> --- new-openvpn.8    2010-04-16 19:16:08.427860657 +0200
> +++ jjk-openvpn.8    2010-04-16 19:46:01.374609848 +0200
> @@ -3308,8 +3308,8 @@
>  option will tell the server to immediately close its client instance object
>  rather than waiting for a timeout.  The
>  .B n
> -parameter (default=1) controls the maximum number of retries that the 
> client
> -will attempt to resend the exit notification message.
> +parameter (default=1) controls the maximum number of attempts that the 
> client
> +will make to send the exit notification message.

ACK

>  .\"*********************************************************
>  .SS Data Channel Encryption Options:
>  These options are meaningful for both Static & TLS-negotiated key modes
> @@ -3591,7 +3591,7 @@
>  OpenVPN adds to the IPSec model by limiting the window size in time as 
> well as
>  sequence space.
>  
> -OpenVPN also adds TCP transport as an option (not offered by IPSec) in 
> which
> +OpenVPN also adds TCP transport as an option (not offered by plain 
> IPSec) in which

Does some IPSec implementations support TCP transport?  I thought that
IPSec was OSI layer 3 (network) traffic, while TCP starts on OSI layer 4
(transport).

>  case OpenVPN can adopt a very strict attitude towards message deletion and
>  reordering:  Don't allow it.  Since TCP guarantees reliability, any packet
>  loss or reordering event can be assumed to be an attack.
> @@ -3601,11 +3601,6 @@
>  message deletion or reordering attack which falls within the normal
>  operational parameters of IP networks.
>  
> -So I would make the statement that one should never tunnel a non-IP 
> protocol
> -or UDP application protocol over UDP, if the protocol might be 
> vulnerable to a
> -message deletion or reordering attack that falls within the normal 
> operating
> -parameters of what is to be expected from the physical IP layer.  The 
> problem
> -is easily fixed by simply using TCP as the VPN transport layer.


Even though I do agree with you that a "personal message" should not be
in a man page, I also do see the importance of the message given here.
But it can be understood as controversial for some, as it is formulated
in a biased way.  If the message given is false, it should be removed as
well.  But I'd rather see this whole paragraph being rephrased, reworked
and become a bit more unbiased towards the TCP/UDP discussion.

Now it can be understood that TCP is the best security solution - but
that's when you only read this little paragraph.  Changing from TCP to
UDP also got it's fair share of advantages and disadvantages as well,
which should be covered somehow in the man page.


Could we please split these three changes into three different patches,
as they cover three different parts of the man page and tracking their
changes separately is cleaner when people try to figure out what was
discussed and which conclusions was made.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvLimsACgkQDC186MBRfrp0ZACgqcpehduZEOSPoyupKpa3u5qk
g6IAnA2/UzrstnF4nqKrm24aMCna6ftL
=Cdwn
-----END PGP SIGNATURE-----

