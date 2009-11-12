Message-ID: <4AFBFED6.7080905@...1114...>
Date: Thu, 12 Nov 2009 13:25:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>	<20091111102515.GA19782@...1066...>	<4AFA9AA7.4030600@...260...>
	<4AFAAD5C.4070303@...1114...>
	<20091112115108.GA5230@...1276...>
In-Reply-To: <20091112115108.GA5230@...1276...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the validity of a certificate
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
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/09 12:51, Till Maas wrote:
> On Wed, Nov 11, 2009 at 01:26:04PM +0100, David Sommerseth wrote:
> 
>> 1) The certificate is first dumped to file.  Would it be possible to
>> pass it only via environment table, to avoid the file stage?  The reason
>> for this is primarily security (not to write more to disk than what you
>> really need on disk), and secondarily - SELinux - avoiding writing data
>> to disk you are more sure that SELinux or other MACs will not interfere
>> and deny the write requests.  This is especially crucial if OpenVPN is
>> run in as a contained user (which most daemons really do)
> 
> As far as I understand the tls-verify option, the script will be run
> once for every certificate in the chain. Therefore just passing the
> cert to stdin of the script should be a feasible solution.

But this will not work for --plugin.  A plug-in written in C will not
have access to stdin/stdout for such exchanges.  That's my concern.

>> 2) If an attacker sends a certificate with his certificate and 999 CA
>> certificates in a chain, what will happen?  What happens if the disk
>> goes full or the certificate cannot be written?
> 
> According to the manpage, the tls-verify script won't be executed,
> because the attacker already need to have passed all other verifications
> steps except the check against the CRL list.

True!  I didn't think about that when I thought about this scenario, but
this really covers it.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr7/tMACgkQDC186MBRfrrUJwCgrSVYrvlu3v9ZQlQOcg/oAwwk
OxsAnjN+a0OeSIH0Um/3ICbQBRGNLOEh
=ZEbM
-----END PGP SIGNATURE-----

