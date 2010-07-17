Message-ID: <4C418A4E.7090101@...1114...>
Date: Sat, 17 Jul 2010 12:47:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7EB12E.5000405@...1114...>
	<loom.20100716T203449-26@...171...>
In-Reply-To: <loom.20100716T203449-26@...171...>
Subject: Re: [Openvpn-devel] Compiler warnings when using openssl-1.0.0 -
 beta4
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
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/07/10 20:36, chantra wrote:
> 
>>
>> If nobody responds, I'll try to find some time looking into this in the
>> near future.
>>
> 
> I did in https://community.openvpn.net/openvpn/ticket/5#comment:3
> 

Thanks a lot!  I've tested compiling this patch on an older
openssl-0.9.8e and openssl-1.0.0a.  I've tested the patch with
openssl-1.0.0a running openvpn as a client as well.

I'll do some more testing on this patch, with openssl-0.9.8e both as a
server and client.  If that looks good, you'll get an ACK :)

Thanks again for great work!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxBik4ACgkQDC186MBRfrqRrwCffr7Ufs3OXRrQ+mrfEBudbqus
d3YAn033/cIamTyAfvMSlteyhR/jApjT
=M9h4
-----END PGP SIGNATURE-----

