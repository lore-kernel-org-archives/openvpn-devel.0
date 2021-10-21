References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-6-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <c77e595a-b65d-fc4d-ce09-aa63977ac9b2@...2507...>
Date: Thu, 21 Oct 2021 11:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-6-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 05/21] [OSSL 3.0] Use EVP_PKEY based
 API for loading DH keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> OpenSSL 3.0 replaces the DH API with a generic EVP_KEY based API to
> load DH parameters.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Looked at the patch, compiled with OpenSSL 3.1.0, tested that I can get 
a server and client to talk to each other on localhost.

