Message-ID: <cd65576e-b0e3-3b48-578c-e7c53503d937@...1227...>
Date: Wed, 19 Jan 2022 17:35:55 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220119151941.37529-1-openvpn@...2080...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220119151941.37529-1-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] crypto: Fix OPENSSL_FIPS enabled
 builds
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Am 19.01.22 um 16:19 schrieb David Sommerseth:
> From: David Sommerseth <davids@...515...>
> 
> On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS
> module enabled by default.  On these platforms, the OPENSSL_FIPS macro
> is always defined via /usr/include/openssl/opensslconf-*.h.
> 
Acked-By: Arne Schwabe <arne@...1227...>

Arne

