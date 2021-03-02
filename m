References: <CAAUX2SUj97L-Omhg0o60dYFyjf1W0+GvmvQYFb3Hf43Ruhn5Kw@...278...>
 <950bc7b2-6cd7-d8c7-e6f1-0286742c3dc7@...1227...>
 <CAAUX2SX=a853vJ=ozE7T0Q_7ohgkVxfit+myzebeoGV1QUMDsw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b250b76b-1990-5f74-6bbf-f5b377925b0e@...1227...>
Date: Tue, 2 Mar 2021 12:18:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SX=a853vJ=ozE7T0Q_7ohgkVxfit+myzebeoGV1QUMDsw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] compiling issue in openvpn 2.6.0+ supporting
 ovpn-dco
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <antonio@...515...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 02.03.21 um 10:41 schrieb Tony He:
> No, same error. This error happens on my Ubuntu 20.04 VM. Another Ubuntu
> 18.04 is fine. Checking.
> What's your Linux distribution?

As said in the announcement. Ubuntu 20.04 and 20.10 work fine. The code
that breaks for you has been in Openvpn since 2017 so it is very
unlikely to be related to the dco branch but rather on something on your
autconf broken. ./configure should tell you that it found this function.


Arne

