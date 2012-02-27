Message-ID: <4F4B5535.40709@...1114...>
Date: Mon, 27 Feb 2012 11:04:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
	<eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
	<4F47E175.3030008@...1114...>
In-Reply-To: <4F47E175.3030008@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: debrabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/02/12 20:13, David Sommerseth wrote:
> On 22/02/12 20:49, debrabander wrote:
>> This is not the a problem when building using the latest Mac OS X 
>> SDK. I've did a quick search and it seems to be a more common issue
>> on some (old) Darwin platforms. Please try building again after
>> applying the patch below.
> 
> 
>> Signed-off-by: Frank de Brabander <debrabander@...277...> ---
>> socket.c |    5 +++++ 1 files changed, 5 insertions(+), 0
>> deletions(-)
> 
>> diff --git a/socket.c b/socket.c index 1a772af..6337900 100644 --- 
>> a/socket.c +++ b/socket.c @@ -893,8 +893,13 @@ create_socket_udp6 
>> (const unsigned int flags) else if (flags & SF_USE_IP_PKTINFO) {
>> int pad = 1; +#ifndef IPV6_RECVPKTINFO /* Some older Darwin
>> platforms require this */ +      if (setsockopt (sd, IPPROTO_IPV6, 
>> IPV6_PKTINFO, +		      (void*)&pad, sizeof(pad)) < 0) +#else if 
>> (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO, (void*)&pad, 
>> sizeof(pad)) < 0) +#endif msg(M_SOCKERR, "UDP: failed setsockopt
>> for IPV6_RECVPKTINFO"); } #endif
> 
> Right now, I'm a bit sceptic to this patch, as the JJO fixed a bug 
> related to the --multihome feature by moving over to IPV6_RECVPKTINFO
> 
> commit 5d6dbb03776de4d38f45e429ef674313a2bda8cc Author: JuanJo
> Ciarlante <jjo@...410...> Date:   Sun Feb 6 09:52:46 2011 +0100
> 
> * fix --multihome for ipv6: IPV6_RECVPKTINFO - setsockopt
> IPV6_RECVPKTINFO (not IPV6_PKTINFO!)  <<<< [1] - do check for
> setsockopt() failures
> 
> 
> [1] This is why I'm nervous for this patch.
> 
> If we can confirm that --multihome works as expected on platforms
> without IPV6_RECVPKTINFO, then I'm fine with this patch.  Otherwise,
> we need to figure out how to make --multihome work too.
> 
> JJO, please have a look at this.

(somehow JJO fell off the Cc list; re-adding)

Gert and I discussed this a little bit further.  We are concerned about
breaking --multihome.  But we're also not sure how important that feature
is on OSX.  The use case is server setups with UDP and who use either
- --proto udp6 to accept incoming IPv4 and IPv6 traffic - or accepting
traffic from multiple IPv4 (or IPv6) addresses.

So if someone could test this patch on OSX which is lacking
IPV6_RECVPKTINFO, setting up a test server with --multihome and --proto
udp6 and test incomming IPv4 and IPv6 traffic, especially simultaneously
(2-3 IPv4 and 1-2 IPv6 clients at the same time).  If this works, please
report back to the mailing list.

The second test would be to see how this setup would work _without_
- --multihome.  And then document the test results here too.


If all this works fine, then we don't need to worry - and I'll pull this
patch in instantly.  But if it does not and we don't get a good fix at
some point, we need to consider if we will allow --multihome to break on
OSX.  A related question to this is, how many do use the server features
in OpenVPN on OSX?   Not being able to build on OSX is also not a real
option.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LVTUACgkQDC186MBRfrqKcQCdF/9/A1XIDgeTh8H+5Wv4xoZI
aQMAn11Y0miv3LjH271SF0GKxPW9OVfQ
=09kn
-----END PGP SIGNATURE-----

