Message-ID: <cc7b3bfb-b90c-3c5b-65c6-cf3dd2226090@...1227...>
Date: Thu, 17 Feb 2022 16:41:16 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220217142306.8108-1-a@...2181...>
 <20220217143241.18766-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220217143241.18766-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] crypto: unify key_type creation code
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 17.02.22 um 15:32 schrieb Antonio Quartulli:
> At the moment we have tls_crypt_kt() and auth_token_kt that basically do
> the same thing, but with different algorithms used to inizialise the
> structure.

Should be initialise or initialize depending on your dialect.

> 
> In order to avoid code duplication and copy/paste errors, unify code and
> make it parametric, so that it can be re-used in various places.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> 

Acked-By: Arne Schwabe <arne@...1227...>

