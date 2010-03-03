Message-ID: <4B8E2070.6050208@...1299...>
Date: Wed, 03 Mar 2010 21:40:16 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <1267588345473303500@...1315...>
In-Reply-To: <1267588345473303500@...1315...>
Subject: Re: [Openvpn-devel] Erratic TCP Throughput
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
To: openvpn-devel@lists.sourceforge.net

On 03/03/2010 04:52 PM, openvpn@...1315... wrote:
>
> 1) Without OpenVPN - consistent performance, ~ 70 Mbps total
> throughput (on a 100 Mb LAN).
>
> bin/iperf.exe -c server.home -P 8 -i 1 -p 5001 -f m -t 10
>
...results removed
>
> 2) With OpenVPN - very consistent performance, sometimes fine, other
> times very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but
> bounces around a lot.
>
> bin/iperf.exe -c server -P 8 -i 1 -p 5001 -f m -t 10
>
>
...results removed

So what you're saying is that on a ~70Mbs network you sometimes see
~70Mbs via "openvpn-via-proxy-server" and sometimes you don't? As the
performance of openvpn varies - and I assume you know the client and
server aren't the bottleneck - then that leaves....?

The proxy! :-) See how it's running. Does it have inline AV? Does it do
content filtering/rate shaping/etc. Could it be simply overloaded? When
you're nailing 70Mbs through it, how does it look?


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


