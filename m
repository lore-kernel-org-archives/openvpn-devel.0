Message-ID: <5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...>
Date: Fri, 9 Feb 2024 21:50:36 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20240209155109.110542-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240209155109.110542-1-juliusz@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Am 09.02.24 um 16:51 schrieb Juliusz Sosinowicz:
> Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The include/wolfssl directory is included before openvpn/src. include/wolfssl needs to be included so that openvpn can pick up wolfSSL compatibility headers instead of OpenSSL headers without changing the paths.

Neither the ssl.h (2005, so forever) in OpenVPN nor the ssl.h in wolfssl 
(2014 according to git blame) are particulary new. Why is this now a 
problem when it was never before?

Arne


