Message-ID: <5866db1a-4c75-fed6-3c45-bfd691bb0427@...1227...>
Date: Tue, 18 Jul 2023 12:59:33 +0200
MIME-Version: 1.0
References: <20230718105233.620193-1-frank@...2641...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230718105233.620193-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: refactor mingw UTs and add missing
 tls_crypt
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 18.07.23 um 12:52 schrieb Frank Lichtenheld:
> I thought instead about moving this into a loop inside
> powershell. But then error handling becomes annoying.
> So let's GitHub handle it.
> 

Acked-By: Arne Schwabe <arne@...1227...>

I personally do not mind the long list of repeated unit tests in the 
file but this way is also fine.

I checked Frank's repository to verify that this actually works.

Arne


