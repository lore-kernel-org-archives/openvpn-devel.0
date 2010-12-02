Message-ID: <4CF76B01.5020308@...193...>
Date: Thu, 02 Dec 2010 10:46:41 +0100
From: Farkas Levente <lfarkas@...193...>
MIME-Version: 1.0
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
	patches
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/02/2010 10:05 AM, Adriaan de Jong wrote:
> Hi List, 
> 
> We've been working on OpenVPN in preparation for a security evaluation. This entailed documenting OpenVPN at a relatively high level, removing the dependencies on OpenSSL, and adding support for a simpler, easier to evaluate library (PolarSSL).
> 
> This was done in a series of patches:
> - Patch 1: Adds documentation to OpenVPN through Doxygen.
> - Patch 2: Splits out OpenSSL-specific code, defining a clean "backend" interface for both the crypto and SSL modules. Splits the SSL module into channel setup and verification sub-modules.
> - Patch 3: Adds a backend for PolarSSL.
> 
> We'd love to release these patches to the community. Unfortunately, the patches are now based on 2.1.4, and need to be rebased to a newer version. Before we spend time on updating the patches to the current revision of OpenVPN, we'd like to know whether there is an interest in these patches from the community.

most distro switch from openssl to nss. is there any reason you switch
to polarssl in stead of nss?

-- 
  Levente                               "Si vis pacem para bellum!"

