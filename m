Message-ID: <551ABCE6.5090502@...1800...>
Date: Tue, 31 Mar 2015 11:27:34 -0400
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <5519B242.2020009@...1856...>	<20150330210636.GF21893@...1296...>	<551AA3A2.5000300@...1800...>	<20150331142352.GI21893@...1296...>
	<551AAF8F.7010502@...1800...>
In-Reply-To: <551AAF8F.7010502@...1800...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

On 3/31/2015 10:30 AM, Mike Tancsa wrote:
> On 3/31/2015 10:23 AM, Gert Doering wrote:
>> Hi,
>>
>> On Tue, Mar 31, 2015 at 09:39:46AM -0400, Mike Tancsa wrote:
>>> I am not able to reproduce this.
>>
>> You need to use --daemon to make openvpn fork().  Otherwise, it will
>> "just work", but after forking, the cryptodev file descriptor is no
>> longer valid -> boom.  Steffan's patch should fix that.
>
> Hi,
> 	Is having in the config
>
> daemon openvpn-hq
>
> not the same as --daemon from the arguments ?

commenting out daemon in the config, and starting it up with

openvpn --daemon --config /usr/local/etc/openvpn/openvpn.conf

also works for me.  Perhaps its the way the engine is loaded with this 
version of openssl in the base of FreeBSD ?

# openssl engine -t -c
(cryptodev) BSD cryptodev engine
  [RSA, DSA, DH, AES-128-CBC, AES-192-CBC, AES-256-CBC]
      [ available ]
(rsax) RSAX engine support
  [RSA]
      [ available ]
(rdrand) Intel RDRAND engine
  [RAND]
      [ available ]
(dynamic) Dynamic engine loading support
      [ unavailable ]

	---Mike





-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

