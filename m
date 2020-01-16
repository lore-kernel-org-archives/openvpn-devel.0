From: Simon Rozman <simon@...2293...>
Date: Thu, 16 Jan 2020 13:19:47 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D064BDE6@...2294...>
References: <20191219132953.375-1-lstipakov@...277...>
In-Reply-To: <20191219132953.375-1-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_0007_01D5CC78.010256D0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] options.c: do not force route delay
 when not using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

------=_NextPart_000_0007_01D5CC78.010256D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Code looks reasonable. Tested it.

Acked-by: Simon Rozman <simon@...2293...>

Best regards,
Simon

> -----Original Message-----
> From: Lev Stipakov <lstipakov@...277...>
> Sent: Thursday, December 19, 2019 2:30 PM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Lev Stipakov <lev@...515...>
> Subject: [Openvpn-devel] [PATCH] options.c: do not force route delay
> when not using DHCP
> 
> From: Lev Stipakov <lev@...515...>
> 
> Route delay may be only necessary when we perform DHCP handshake. When
> we use IPAPI / netsh / manual, no delay needed.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/options.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> cebcbb07..a6f40e10 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3001,9 +3001,18 @@ options_postprocess_mutate_invariant(struct
> options *options)
>      }
> 
>  #ifdef _WIN32
> +    /* when using wintun, kernel doesn't send DHCP requests, so use
> netsh to set IP address and netmask */
> +    if (options->wintun)
> +    {
> +        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
> +    }
> +
>      if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options-
> >route_delay_defined)
>      {
> -        if (options->mode == MODE_POINT_TO_POINT)
> +        /* delay may only be necessary when we perform DHCP handshake
> */
> +        const bool dhcp = (options->tuntap_options.ip_win32_type ==
> IPW32_SET_DHCP_MASQ)
> +                          || (options->tuntap_options.ip_win32_type ==
> IPW32_SET_ADAPTIVE);
> +        if ((options->mode == MODE_POINT_TO_POINT) && dhcp)
>          {
>              options->route_delay_defined = true;
>              options->route_delay = 5; /* Vista sometimes has a race
> without this */ @@ -3016,14 +3025,8 @@
> options_postprocess_mutate_invariant(struct options *options)
>          options->ifconfig_noexec = false;
>      }
> 
> -    /* for wintun kernel doesn't send DHCP requests, so use netsh to
> set IP address and netmask */
> -    if (options->wintun)
> -    {
> -        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
> -    }
> -
>      remap_redirect_gateway_flags(options);
> -#endif
> +#endif /* ifdef _WIN32 */
> 
>  #if P2MP_SERVER
>      /*
> --
> 2.17.1
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------=_NextPart_000_0007_01D5CC78.010256D0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
MjQxMTU4MjdaFw0yMTA2MjcyMjAwMDBaMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1p
bnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAsOVlssCsZJbyiBuz7Z7kAsZPK4jOLopRgHWvEFvyyzhmm6IObTRHlqWSEa/2NUeidyIM
zhaIYqrTSW4YvC5E2L7GnsIaGaxBjvwwBwLyxmrUWyMA70E02KRzY98ikjOEAaWN84Nc+rjUejXf
7PhtD+BM7a2cOn2G1qUIlL59ehEf/oU/VFqIY4ecpbGnTs23RHOvz4pJax/jzddJTVorF+ZcdrO7
crlvJ9KbiRWI3xBfdiEBascVMQrRnFj4KBYFbdlO2aHXByDLSyaJTZKyp7qW6ONYjyKcAZZaxPcx
TQtJteF4YeJUGAa7nlQ0fgw+6+61gB/dFoQdaDhmZ3P4kQIDAQABo4ICQzCCAj8wEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwOgYDVR0gBDMwMTAvBgRVHSAAMCcwJQYIKwYBBQUH
AgEWGWh0dHA6Ly93d3cuY2EuZ292LnNpL2Nwcy8waQYIKwYBBQUHAQEEXTBbMDYGCCsGAQUFBzAC
hipodHRwOi8vd3d3LmNhLmdvdi5zaS9jcnQvc2ktdHJ1c3Qtcm9vdC5jcnQwIQYIKwYBBQUHMAGG
FWh0dHA6Ly9vY3NwLmNhLmdvdi5zaTAdBgNVHQ4EFgQUcXuKBh8xBVWrYBJ3RyAeA4gY7IkwggE8
BgNVHR8EggEzMIIBLzCBt6CBtKCBsYYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3JsL3NpLXRydXN0
LXJvb3QuY3JshoGCbGRhcDovL3g1MDAuZ292LnNpL2NuPVNJLVRSVVNUJTIwUm9vdCxvcmdhbml6
YXRpb25JZGVudGlmaWVyPVZBVFNJLTE3NjU5OTU3LG89UmVwdWJsaWthJTIwU2xvdmVuaWphLGM9
U0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBzoHGgb6RtMGsxCzAJBgNVBAYTAlNJMRwwGgYD
VQQKExNSZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5WQVRTSS0xNzY1OTk1NzEWMBQGA1UE
AxMNU0ktVFJVU1QgUm9vdDENMAsGA1UEAxMEQ1JMMTATBgNVHSMEDDAKgAhMo8NoXggCYzANBgkq
hkiG9w0BAQsFAAOCAYEAe681I+FjipyKtYmRPCSpo4+o5JXTon9l6kVB9QQnztOWsaOnhdHkUuS1
MARj/tHhKB5vYrw5YSX8qhzUFsfr67Jli99r5aeckRZ5Y6bI/L++ig7t5nI5W9o5HG6tY4sIJUNb
bAGRu1SgplpTLOA/5k88ZFXwYWVtksLMaYCswZcld7y39c2IkMt6EapJZPj01iPJhB0iAj6qL1b4
DoFJRD2Owx1gmoqFdByix8fnWxzqBlXFMoyvc+wi2xrxcWI1rMQIAAWvSazscHrNvxC8dEV4EaT8
IutbhWRkQE38m27KG+CS1DYG+4a1q4S8dlABikxKHfkPunC1q9EymaFoCxBvjI+qEgxzO3BGqwo8
GFahoURVn5WffDFqnmH+gCGhyJ83ORYlM1aPGeg8zZ43Pa5YUmyCw2GXC15S+erv5spM215IpYqv
qkj4ZSxmGYKHlRGlSepRqenRSJ7QwP1/e2I4s6nvXWw1vTHCL5V0O4MHfsh104ix+E8Gih3CmgWt
MYIDETCCAw0CAQEwRTA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3RhdGUtaW5zdGl0dXRpb25z
MREwDwYDVQQLEwhzaWdlbi1jYQIEO0oNLjAJBgUrDgMCGgUAoIIBoTAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDAxMTYxMzE5NDZaMCMGCSqGSIb3DQEJBDEWBBQs
zuI09q2AjUOfBkdj0+eSitUIyzBUBgkrBgEEAYI3EAQxRzBFMD0xCzAJBgNVBAYTAnNpMRswGQYD
VQQKExJzdGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMFYGCyqGSIb3
DQEJEAILMUegRTA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3RhdGUtaW5zdGl0dXRpb25zMREw
DwYDVQQLEwhzaWdlbi1jYQIEO0oNLjCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjAHBgUrDgMC
GjANBgkqhkiG9w0BAQEFAASCAQCn8SxbV5tELYjaeVFuhP9R6CZKGqzt9WSHMukvMDLd9MY0fqdm
8gtXcXpTgg6MP2EDxkMeWYjE2OdBnUrSKSQ3+pnunP97Oa7Lmc7axy+XjXCk1djd+kMYS4kXgBrr
LQWLoeb2W+8mYmzOIMZ3dJKa9OgFAM0X/ms/3Uki1aW7brGTMgAyGPCoZePsBxhNPJ2ZexpR43lM
wo4lAAydVWUkV35Bdwuuu6NMS9hYDEkfJqYBne0Ev5j1fmiLmKXY+tzg7KDWs7lN40uEptgVaZ8G
pVa+I6li5JkfhLVS5Qo/LHsdpuj7WcR9+xZvJd/DQxOxf/9Az6DxpyrCMkXPFlBfAAAAAAAA

------=_NextPart_000_0007_01D5CC78.010256D0--

