Message-ID: <4921cec7-eedc-a426-51cc-1fe1f98721ac@...1227...>
Date: Wed, 20 Apr 2022 10:50:36 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <000001d8548f$4891c980$d9b55c80$@chinatelecom.cn>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <000001d8548f$4891c980$d9b55c80$@chinatelecom.cn>
Subject: Re: [Openvpn-devel] :openvpn dco connection problem
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
To: yuanxun <yuanx3@...2645...>, openvpn-devel@lists.sourceforge.net

Am 20.04.22 um 10:18 schrieb yuanxun:
> Hi
> 
> I recently encountered a bug when using the openvpn dco branch. When the 
> client connection reaches max_cliants, I reconnect one of the clients, 
> and the client will fail to reconnect when it reaches the set number of 
> reconnections. At this time, the client state is Not connected, but on 
> the management interface, always online.

Can you post logs of the openvpn server? Preferrable with verb 4 at least?

Arne

