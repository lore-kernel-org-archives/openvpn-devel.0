Message-ID: <4CA08840.3030107@...1147...>
Date: Mon, 27 Sep 2010 14:04:16 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4CA0551F.70703@...1410...>
In-Reply-To: <4CA0551F.70703@...1410...>
Subject: Re: [Openvpn-devel] HTTP/1.1 Host header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Lars Hupel <hupel@...1410...>
Cc: openvpn-devel@lists.sourceforge.net

Lars Hupel wrote:
> Hi,
>
> as the subject states, I would like that OpenVPN sends an appropriate
> Host header, because my server configuration relies on Apache's
> VirtualHosts. Because OpenVPN doesn't send this header, I patched it
> myself. Recently, I found the discussion on openvpn-devel from 10/2008
> (subject was "enhance compatibility with HTTP/1.1 proxies", from Frank
> Behrens) about a very similar patch. However, I was not able to extract
> from that discussion why the patch was rejected (or simply ignored?).
> Are there any objections to accept the patch?
>
>   
I'm not sure if I understand the question ; openvpn already has the 
option to use http/1.1 headers using
  --http-proxy-option VERSION 1.1
which should send HTTP/1.1 type messages - doesn't that work?

HTH,

JJK


