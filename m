Message-ID: <558C143F.30400@...1147...>
Date: Thu, 25 Jun 2015 16:46:23 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <558C0F5D.9060104@...2039...>
In-Reply-To: <558C0F5D.9060104@...2039...>
Subject: Re: [Openvpn-devel] Windows build fix for CVE-2015-4000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Joseph S. Testa II" <jtesta@...2039...>
Cc: openvpn-devel@lists.sourceforge.net

Joseph S. Testa II wrote:
> Hi all,
>
>     I was wondering if an updated Windows build is being planned for 
> release soon to fix CVE-2015-4000, et. al, as described in 
> http://www.openssl.org/news/secadv_20150611.txt.
>
>     I haven't seen anyone talk about this on the mailing list since the 
> advisory came out two weeks ago, so I thought I'd ask.
>
>   
I think you're referring to the logjam bug. We've a short discussion on 
this on May 21st when the vulnerability was announced:

the main gist of this vulnerability is to use DH param files (on the 
server) that are at least 1024, preferable 2048 or even 3072 bits in 
length.
As Steffan wrote:

1) OpenVPN encourages users to generate their own DH-group using
'openssl dhparam', instead of using common groups. The man page /
examples used to provide 1024 bits DH keys (updated to 2048 recently),
and although 1024 bits dh params *can* be broken, that is still *very*
expensive. Probably too expensive for your data if you don't share the
group with others.
2) OpenVPN's tls-auth feature can prevent the downgrade attack on TLS
from happening (but, only if you use tls-auth, of course).

Still, use DH params of at least 2048 bits, please! Upgrading is easy
and only needs a change on the server. Generate new params using e.g.:

  openssl dhparam -out dh3072.pem 3072

update your server config to use this file:

  dh dh3072.pem

and restart the server.




So, in view of this I don't think a rebuild of the client is in order, 
as this bug can be easily circumvented (server-side) by using the 
appropriate DH file.

HTH,

JJK


