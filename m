Message-ID: <fc35080a-036e-e233-f92d-0c308f5522c2@...1227...>
Date: Mon, 20 Mar 2023 13:24:28 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230319075441.13021-1-info@...2666...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230319075441.13021-1-info@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] using OpenSSL3 API for EVP PKEY type
 name reporting
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
To: Michael Baentsch <info@...2666...>, openvpn-devel@lists.sourceforge.net

Am 19.03.23 um 08:54 schrieb Michael Baentsch:
> Signed-off-by: Michael Baentsch <info@...2666...>

Acked-By: Arne Schwabe <arne@...1227...>

Thanks. We had a discussion/review round on gihtub before this. 
Basically the problem is that trying to print the algorithm
for algorithms that are not part of the old OpenSSL 1.x API (like a pq 
algorithm from a provider) results in putting an error on the OpenSSL 
stack and that has than bad consequences.

Arne

