Message-ID: <50F7257C.9010404@...1800...>
Date: Wed, 16 Jan 2013 17:11:08 -0500
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,
	I have been following the steps to build OpenVPN from the sources and
was scratching my head as to why the prebuilt binary would work, but my
build from the sources would bork on --show-pkcs11-ids ?!?!   Searching
through the mailling list archives shows the patch below, which fixes my
problem.  It seems that this patch is not in the generic sources?

I was following the directions at
https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem#Checkingoutopenvpn-buildrepository

My question is, why would I not get the correct sources with the fix
below using the generic build ?  Is there a different / better way to do
it that whats outlined in the above url ?

Thanks!

	---Mike

On 11/14/2012 4:03 AM, Adriaan de Jong wrote:
> [PATCH] Fix --show-pkcs11-ids (Bug #239)
> 
> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
> 
> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
> ---
>  src/openvpn/pkcs11.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c index 645f1f4..3a15ef6 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -887,7 +887,7 @@ show_pkcs11_ids (
>  		      (dn = pkcs11_certificate_dn (
>  				certificate,
>  				&gc
> -		      ))
> +		      )) == NULL
>  		) {
>  			goto cleanup1;
>  		}
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> Monitor your physical, virtual and cloud infrastructure from a single
> web console. Get in-depth insight into apps, servers, databases, vmware,
> SAP, cloud infrastructure, etc. Download 30-day Free Trial.
> Pricing starts from $795 for 25 servers or applications!
> http://p.sf.net/sfu/zoho_dev2dev_nov
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> 


-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

