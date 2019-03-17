References: <CAEYw=WpUJNWUtjoBNkZrewsTxcbxfOe5u=t5vxuyMzsb6Z=Eug@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6bd0356c-ed50-6602-c39c-9a41ad5b31cb@...1856...>
Date: Sun, 17 Mar 2019 09:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAEYw=WpUJNWUtjoBNkZrewsTxcbxfOe5u=t5vxuyMzsb6Z=Eug@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] Why is the authentication tag
 transmitted before the encrypted data?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Pieter,

[ Adding in -devel, because this really is more of a devel topic. ]

On 15-03-19 15:29, Pieter Hulshoff wrote:
> I was wondering why the authentication tag is transmitted before the
> encrypted data in stead of after it (like in e.g. MACsec).

As far as I understand, mostly because the V1 data channel protocol put
the HMAC before the ciphertext. James might remember why the original
data channel protocol put the tag in front.

The current GCM wire spec was proposed by James in
<54648EAC.70204@...515...>
(https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg09516.html).

I had a short (off-list) discussion with James in 2015 where I proposed
moving the tag to the end of the data frame, to facilitate hardware
implementations. But because (software) implementation of the proposed
protocol had already progressed, we ended up not adopting that proposal.

-Steffan

