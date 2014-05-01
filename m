Message-ID: <5362D919.2080002@...1114...>
Date: Fri, 02 May 2014 01:30:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1398415277-6880-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1398415277-6880-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix bug that incorrectly refuses oid
 representation eku's in polar builds
Reply-To: openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

On 25/04/14 10:41, Steffan Karger wrote:
> The return value of x509_get_numeric_string() was interpreted incorrectly
> by ssl_verify_polarssl.c's x509_verify_cert_eku(). This patch enables the
> usage of oid represenation in --remote-cert-eku options.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>   src/openvpn/ssl_verify_polarssl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
> index 5db4f02..f2b0574 100644
> --- a/src/openvpn/ssl_verify_polarssl.c
> +++ b/src/openvpn/ssl_verify_polarssl.c
> @@ -340,7 +340,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
>   		}
>   	    }
>
> -	  if (0 == x509_oid_get_numeric_string( oid_num_str,
> +	  if (0 < x509_oid_get_numeric_string( oid_num_str,
>   	      sizeof (oid_num_str), oid))
>   	    {
>   	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
>

ACK.

I've only glared at the code, and read the PolarSSL source code. 
x509_oid_get_numeric_string() is just calling oid_get_numeric_string() which says:

  * \return Length of the string written (excluding final NULL) or
  * POLARSSL_ERR_OID_BUF_TO_SMALL in case of error

So returning 0 is not necessarily a failure at all, and 
POLARSSL_ERR_OID_BUF_TO_SMALL is a negative number (-0x00B).


-- 
kind regards,

David Sommerseth

