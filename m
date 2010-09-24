Message-ID: <4C9C6CB5.4070405@...1299...>
Date: Fri, 24 Sep 2010 21:17:41 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4C9C1BB0.7000304@...1299...> <4C9C4DA9.9080108@...1147...>
In-Reply-To: <4C9C4DA9.9080108@...1147...>
Subject: Re: [Openvpn-devel] proper "logout" support for the server?
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

 On 09/24/2010 07:05 PM, Jan Just Keijser wrote:
> it's already available:
>  --explicit-exit-notify
> this is needed only for UDP based connections, as the server will know
> when a TCP connection has ended.
>

Ha! So it is. Given the amount of time I've read the manpage, I'm
surprised I've missed it :-}


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


