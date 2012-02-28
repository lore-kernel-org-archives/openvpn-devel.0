Message-ID: <4F4CD34B.5010202@...1435...>
Date: Tue, 28 Feb 2012 14:14:51 +0100
From: Adriaan de Jong <dejong@...1435...>
MIME-Version: 1.0
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...> <4F4CAEF1.9070001@...1114...>
	<4F4CB771.5060004@...1550...> <4F4CBBCF.8050409@...1114...>
	<4F4CBD28.9060001@...1550...> <4F4CBF04.404@...1114...>
In-Reply-To: <4F4CBF04.404@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 02/02] Remove calls to OpenSSL when
 building with --disable-ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 02/28/2012 12:48 PM, David Sommerseth wrote:
> On 28/02/12 12:40, Igor Novgorodov wrote:
>> On 28.02.2012 15:34, David Sommerseth wrote:


>> And when building with SSL support, it won't be called here, but
>> in ssl_openssl.c in tls_init_lib() instead.
> 
> Indeed.  This looks good.  So unless Adriaan see some other
> concerns.
> 
> Again, sorry about the noise!
> 

Ack! Thanks, that looks good.

Adriaan

