Message-ID: <5ce09cc4-63d9-d287-19b4-198c7dc8c6e3@...1227...>
Date: Thu, 14 Apr 2022 13:47:44 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <000201d84fe6$fa5b7600$ef126200$@chinatelecom.cn>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <000201d84fe6$fa5b7600$ef126200$@chinatelecom.cn>
Subject: Re: [Openvpn-devel] a problem with openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: yuanxun <yuanx3@...2645...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.04.22 um 12:03 schrieb yuanxun:
> Recently found a problem with openvpn
> 
> environment:
> 
> Linux version 5.4.0-100-generic (buildd@...2671...) (gcc version 
> 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04))
> 
> OpenVPN 2.6_git [git:dco/a503c91735538f21] x86_64-pc-linux-gnu [SSL 
> (OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]
> 
> When the Windows client is disconnected, the management interface 
> “status” is used on the server, and the connected client will not exit 
> immediately.
> 

explicit-exit-notify does not work with DCO. That is a known issue.

Arne

