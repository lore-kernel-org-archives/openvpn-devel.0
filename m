Message-ID: <4B8D79BA.1080704@...1114...>
Date: Tue, 02 Mar 2010 21:48:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267486301-8399-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1267486301-8399-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] [PATCHv2] enhance tls-verify possibility
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

On 02/03/10 00:31, David Sommerseth wrote:
> From: Mathieu GIANNECCHINI <mat.giann@...260...>
> 
> It should be nice to enhance tls-verify check possibilities against peer
> cert during a pending TLS connection like :
> - OCSP verification
> - check any X509 extensions of the peer certificate
> - delta CRL verification
> - ...
> 
> This patch add a new "tls-export-cert" option which allow to get peer
> certificate in PEM format and to store it in an openvpn temporary file.
> Peer certificate is stored before tls-script execution and deleted after.
> The name of the related temporary file is available under tls-verify
> script by an environment variable "peer_cert".
> 
> The patch was made from OpenVPN svn Beta21 branches.
> 
> Here is a very simple exemple of Tls-verify script which provide OCSP
> support to OpenVPN (with tls-export-cert option) without any OpenVPN
> "core" modification :
> 
> X509=$2
> 
> openssl ocsp \
>       -issuer /etc/openvpn/ssl.crt/RootCA.pem \
>       -CAfile /etc/openvpn/ssl.capath/OpenVPNServeur-cafile.pem \
>       -cert $peer_cert \
>       -url http://your-ocsp-url
>       if [ $? -ne 0 ]
>       then
>           echo "error : OCSP check failed for ${X509}" | logger -t
> "tls-verify"
>           exit 1
>        fi
> 
> This patch has been modified by David Sommerseth, by fixing a few issues
> which came up to during the code review process.  The man page has been
> updated and tmp_file in ssl.c is checked for not being NULL before calling
> delete_file().
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  init.c    |    1 +
>  openvpn.8 |   13 +++++++++++++
>  options.c |   10 ++++++++++
>  options.h |    1 +
>  ssl.c     |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ssl.h     |    1 +
>  6 files changed, 87 insertions(+), 0 deletions(-)
> 

Applied to the feat_misc branch, to be merged into to allmerged.
Commit a3982181e284f8c5c8fc15bbbd670da4d91a2ba9


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuNeboACgkQDC186MBRfrp52gCfdcomtlYoswujXdrig+zNQxjk
lpQAni83Sopl7NEcK0/mxFAK8J2Ude2O
=Lf0Q
-----END PGP SIGNATURE-----

