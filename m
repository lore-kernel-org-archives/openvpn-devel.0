Message-ID: <4AFA789B.4070607@...1114...>
Date: Wed, 11 Nov 2009 09:40:59 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>
In-Reply-To: <20091110161632.GA31301@...1276...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the	validity of a	certificate
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
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/09 17:16, Till Maas wrote:
> I would like to get a notification in case a client certificate is used
> for a connection to an OpenVPN server, that is about to expire soon. Is
> there currently a way to do this? I looked into the tls-verify hook, but
> according to the documentation, only the Subject line of a certificate
> is available and not the validity. Is there maybe a way to log the
> expiration dates?

I don't think this is possible without patching openvpn to put these
values into some environment variables for the --tls-verify hook.  I've
done something similar in regards to the SHA1 fingerprint for my own
project (I have had an OpenVPN patch pending since RC7).  But I'd be
willing to carry such a feature in my eurephia patch for OpenVPN, as
that sounds very useful.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAkr6eJgACgkQDC186MBRfrq6NACVESQtnCHS/SljNEAMXdR4xNmY
5gCfbRyDvGgJDguKhCIm3kiLaID6V1g=
=wjKX
-----END PGP SIGNATURE-----

