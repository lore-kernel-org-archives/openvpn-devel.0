Message-ID: <4F6C9EB5.9090602@...1147...>
Date: Fri, 23 Mar 2012 17:03:01 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4F6BEA34.5020602@...1030...>
In-Reply-To: <4F6BEA34.5020602@...1030...>
Subject: Re: [Openvpn-devel] two tls-auth questions
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Mr Dash Four wrote:
> Is there a way to generate a symmetric ta.key without using "openvpn --genkey --secret ta.key"? 
>   
yep, just use any freeform key that has enough entropy. For example, 
this ta.key file is good enough

]# cat mykey
garble warble we need lots of entropy

when openvpn starts you'll see something

Control Channel Authentication: using '/etc/openvpn/cookbook/mykey' as a 
free-form passphrase file

It is NOT possible to use the direction parameter for this

> Is it possible to embed the contents of the above file in my openvpn config file in a similar fashion as it is done with the <key></key> tag for example? If so, what tag should I use for this?
>   

in theory you co do this using

tls-auth [inline]

<tls-auth>
....
</tls-auth>

but this seems to work only for --genkey keys ; so it's either a 
freeform key or an inline , not both. I think you actually may have 
found a (minor) bug.

cheers,

JJK


