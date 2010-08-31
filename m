Message-ID: <4C7CD670.4030706@...1147...>
Date: Tue, 31 Aug 2010 12:16:16 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
In-Reply-To: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
Subject: Re: [Openvpn-devel] My results of OpenVPN Benchmarking
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
To: Ansis Atteka <ansisatteka.dev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Ansis,

very interesting results, it's been on my TODO list to do some extensive 
benchmarking for some time, especially in a 1 Gbps and 10 Gbps network 
environment. See some comments below

Ansis Atteka wrote:
> Hello
>
> I have done some benchmarking of OpenVPN and wanted to share my 
> numbers and also ask some questions. Here is a table that shows how 
> OpenVPN scales. I ran up to 4 instances of OpenVPN servers 
> simulatenously with different ciphers:
>
>
>       ICMP test (MiByes/s)
>
> *Cipher\OpenVPNs instances*
>
> 	
>
> *1*
>
> 	
>
> *2*
>
> 	
>
> *3*
>
> 	
>
> *4*
>
> *BF-CBC*
>
> 	
>
> 35
>
> 	
>
> 65
>
> 	
>
> 84
>
> 	
>
> 96
>
> *AES-128-CBC*
>
> 	
>
> 45
>
> 	
>
> 80
>
> 	
>
> 94
>
> 	
>
> 96(lower CPU)
>
> *AES-256-CBC*
>
> 	
>
> 40
>
> 	
>
> 76
>
> 	
>
> 96
>
> 	
>
> 96(low CPU)
>
>
> Total of 800 tunnels were established in each test. Each tunnel was 
> utilized with following ping command: "ping -I tunX -s 800 -i 0.003 
> <OpenVPN IP>". Lower CPU indicates that CPU usage was lower than in 
> other tests.
>
> Deployment was as follows:
>
> 1. Server (Intel Xeon E5530 6GB of RAM with two 1GBit NICs; Ubuntu 
> 10.04) connected directly with two clients (without a switch, so that 
> total throughput could be 2Gbits)
>
> 2. Client1 (Q6600) runs half of the OpenVPN client instances
>
> 3. Client2 (Intel Xeon E5530) runs the other half of OpenVPN instances.
>
>
> Questions:
>
> 1. Why single OpenVPN server instance never consumes more than 85% of 
> a CPU core in the System Monitor? Is this related to ep_pool() call 
> that has a minimum wait interval and OpenVPN does not do anything at 
> that time?
> 2. During the ping test on the server I observed that incoming traffic 
> (ping requests) pushed out outgoing traffic (ping responses). The 
> incoming and outgoing traffic should be equal, but this does not hold 
> true in a load test. Any explanation why that happened? Maybe because 
> ICMP is unreliable protocol and datagrams(responses) were dropped?
this depends on your openvpn setup ; was compression enabled (it is by 
default) ? what kind of encryption was used? was 'keep-alive' used at 
all (this adds extra traffic) ?

> 3. Have anyone tried to run OpenVPN on a newer CPU that has AES-NI 
> instruction set (e.g. Xeon E56XX series)? I would like to know what 
> would be the bandwidth benefit when AES is chosen as the data Tunnel 
> Cipher?
openvpn is based on openssl; if openssl supports the AES-NI instructions 
then openvpn can use it as well. I've downloaded a patch for openssl 
1.0.0 to support the AES-NI instruction set (engine 'aesni' ) and tried 
on a machine which supports these instructions but found no speed up at 
all ('openssl speed was actually SLOWER). The guy who wrote the patch 
still has to get back to me on that ...

> 4. During a OpenVPN 1200 client bomb test I observed that OpenVPN 
> stalled with 100% CPU. In the openvpn log I saw that there are too 
> many opened files (output of "ls /proc/PID/fd | wc -l" showed that 
> there were 1027 opened files). The bad thing is that killing all those 
> 1200 clients did not help the OpenVPN server to recover and it 
> remained in stall state. It looks like a bug for me.
>
sounds like it ; what does 'lsof' report? what files were opened and 
never closed?
>
>
> Are there any tools which are already developed and would help in 
> benchmarking multiple OpenVPN clients/servers?
nothing that I know of - if you find any, please let me know :)

cheers,

JJK


