References: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
 <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
 <CAKuzo_gF00xHdDK++Bj-KpBEeVHb9meq=tAEu=FMfnTovjqE7Q@...278...>
 <dbfda552-b771-cf31-26b2-4917e5b246e7@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <badca6b2-e69c-ec76-0261-c3326eb90f0a@...277...>
Date: Sat, 25 Jul 2020 11:27:27 +0100
MIME-Version: 1.0
In-Reply-To: <dbfda552-b771-cf31-26b2-4917e5b246e7@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Regarding deprecation of --route-nopull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

thanks for the list!

On 24/07/2020 11:00, Arne Schwabe wrote:
> To emulate pull-filter with pull-filter you need to block this list:
> 
> redirect-private
> redirect-gateway
> block-ipv6
> client-nat
> route
> route-ipv6
> route-gateway
> route-metric
> ip-win32
> dhcp-option
> dhcp-renew
> register-dns
> tap-sleep
> block-outside-dns
> 
> but not block
> 
> route-gateway
> route-dealy
> 
> And without looking at the source code you will be hard pressed to come
> up with the same list.

Noted:
https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--route-nopull

