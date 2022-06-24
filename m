Message-ID: <97bd8269-172d-4dcd-49a5-aee3c9c19b01@...1227...>
Date: Fri, 24 Jun 2022 12:25:54 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-5-arne@...1227...>
 <YrV3TEqU1KF0Q+AB@...2678...>
 <YrV4GkLwPbEiV0XU@...2678...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YrV4GkLwPbEiV0XU@...2678...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Change default MTU in server mode
 to 1420 and push it to client
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 24.06.22 um 10:38 schrieb Frank Lichtenheld:
> On Fri, Jun 24, 2022 at 10:35:24AM +0200, Frank Lichtenheld wrote:
>> Code changes look fine to me, but several documentation suggestions.
> 
> Hmm, after reading the next patch might I suggest to move the
> change to push.c actually to the next patch? Both references
> to IV_MTU and tun-max-mtu only make sense then, right?

Well basically this implements the server side functionality while the 
next patch implements the client side. And the changes to push.c are 
server side. I could also reorder these two to first introduce the 
client side support and then make use of it.

Arne

