Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <56b67112-95f1-e57f-bf0a-92ce3b686f82@...2162...>
References: <20170508141939.31224-1-davids@...515...>
	<CAKuzo_jU+ufz5vkLKdzbf5637hF8bPRNrV3q4Ttq+5YQBqWGtA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <55a3770f-be19-4f37-bd29-c8d9f7f47088@...2080...>
Date: Mon, 8 May 2017 16:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jU+ufz5vkLKdzbf5637hF8bPRNrV3q4Ttq+5YQBqWGtA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] plugin: Fix documentation typo for
 type_mask
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 08/05/17 16:38, Selva Nair wrote:
> Hi,
> 
> On Mon, May 8, 2017 at 10:19 AM, David Sommerseth
> <davids@...515... <mailto:davids@...515...>> wrote:
> 
> * * STRUCT MEMBERS * - * *type_mask : The plug-in should set this
> value to the logical OR of all script + * type_mask  : The plug-in
> should set this value to the logical OR of all script *
> types which the plug-in wants to intercept.  For example, if the *
> script wants to intercept the client-connect and client-disconnect 
> *              script types: * - *              *type_mask = 
> OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT) + *
> type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT) *
> | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT) * * *handle
> :    Pointer to a global plug-in context, created by the plug-in.
> This pointer
> 
> 
> 
> Asking to set *handle to context_ptr is wrong too. One can't
> dereference handle. So it will have to be interpreted as set handle
> to pointer to pointer to the context but that is wrong.
> 
> But as discussed in the other thread I think we should also change
> the definition of handle in this struct.
> 
> Reference to *handle in line 390 needs correction too (comment only
> -- struct is fine).

Yes, I saw that, but thought we should fix that when we know what is
the right solution for the *handle vs handle.   Just to keep things
separate.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEIdjAAoJEIbPlEyWcf3yGkQP/AispEyYNNsMKo9X9ZH082Xi
ZMoExmzPJ3cYiDRGZ0Clo8FYOF/Z6xAng3LOuMPIGbFUt/ZGPuEGqJ33Ot5U1qL3
pfjUJdpCb/jLTx4FvTRcpKRPZht9I5EAk4DHXDwhkEph2twKcjCLV3pciKExFEw6
J8jEpH+0qRAODdW2ilsaDsn56omeEQXQzzIS35Pg+mXTG7XaMHGIpFN7Cw6Paq5z
VDW2ScPXbg9O0+vOKi6RDgAy9iiSXoLO291xrld7tA9XWty6FuPvakqemPaW79NI
17QYVqVY+gix4SPkdc1B/Morv4U3Ueif8pVjNV88skBywoPCTTZs6rL0Z2z0b3M4
zjULfVH+tAHnU0S2CM1CdS/EsO7DQ034FmdYhKhUh3DcXm62m0IPKOoMooLZ+3SF
BcKef2cm/v6UFDOlJxmb9b6m2E1Z/msYKFcSjls3sDZCxLbJ2WtDT8rgLX5UMDeh
M/elhBn02x9skfM3Z+Q7kGbq8F865937uweaGlAIb4m96OL2AKAAm1FZQREued3k
DYJ/zh4I/i7WSU/RnyZA7d9Zxt+Ii5tU4hAtCPccqehoSNMbU0K4ZC/2wwpqNRGk
jQ1baWfVzme9swXlZMHIP6htefoL+OWF4Ax41qM32kCDgGNhpT5k0yTA33tYjZh0
KNzigRuu+taxBXeAhKtq
=900I
-----END PGP SIGNATURE-----

