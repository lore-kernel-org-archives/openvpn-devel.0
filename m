Message-ID: <492ECD60.1060502@...213...>
Date: Thu, 27 Nov 2008 12:40:00 -0400
From: James MacLean <macleajb@...213...>
MIME-Version: 1.0
References: <492DBF02.1070305@...213...> <492EABB8.6050908@...1114...>
In-Reply-To: <492EABB8.6050908@...1114...>
Content-Type: multipart/mixed; boundary="------------030702000101050703070401"
Subject: Re: [Openvpn-devel] Tunnel Speed Tunning with many clients connected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: dazo@...384...
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030702000101050703070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Sommerseth wrote:
>
>
> James MacLean wrote:
>> Hi Folks,
>>
>> I have parsed around a bit but have not come up with a solid 
>> suggestion to increase performance in the following environment :
>>
>> . +150 clients always on, always via COAX modem 15Mb/s down 1.5Mb/s up.
>> . OpenVPN-2.0.9 and 2.1rc13 tested, setup as single server
>> . Server Kernel 2.6.25.4
>> . Server 64bit
>> . Server CPU % rarely goes above 30
>> . Server is fed over a 10G link
>>
>> Currently we get what appears to be only between 5 and 6 MB/s average 
>> using this setup.
>>
>> If only activity is over a single tunnel we can get the expected max 
>> (about 14Mb/s to the remote site) for the COAX sites. Once traffic 
>> builds during the day, that number drops.
>>
>> We know if we hit it locally we can get 160Mb/s. We know if we do hit 
>> it locally and are getting the 160Mb/s that the COAX tunnels do 
>> suffer. Starting by almost 1/2 of their normal throughput tunnel 
>> speed of almost 14Mb/s.
>>
>> So in my small mind, I am thinking we are seeing around 48Mb/s 
>> (6MB/s*8) used, but that we should be able to get over 150Mb/s. CPU 
>> isn't hurting. Almost feels like there is a governor slowing down the 
>> traffic :).
>>
>> Important settings from latest config :
>>
>> verb 1
>> dev tap
>> tun-mtu 1500
>> tun-mtu-extra 32
>> mssfix 1468
>> proto udp
>> ca SSCert.pem
>> cert servercert.pem
>> key serverkey.pem
>> dh dh1024.pem
>> tls-auth ./tlspass
>> keepalive 30 63
>> ping-timer-rem
>> persist-tun 1
>> persist-key 1
>> cipher none
>> tcp-queue-limit 4096
>> sndbuf 131072
>> rcvbuf 131072
>>
>>
>> Anyone have any words of wisdom :) ?
>>
>
> Have you tried different ciphers and/or cipher key sizes?  I know you 
> say the server do not suffer with too high load, but it could be 
> inefficiency in the cipher algorithm.  If that's the case it might be 
> as well an OpenSSL issue too.  It's a shot in the dark, but would be 
> good to wipe this one out.  The default is blowfish, so I really do 
> not expect an improvement.
>
> Do you know if threads are enabled in your OpenVPN setup? 
> (compile/configure setting).  I believe the default is not to use 
> threads.
>
> Does the performance drop if you have 150+ clients connected while 
> being passive (not sending any traffic over the tunnel) and only 
> having 1 client sending traffic?
>
>
> kind regards,
>
> David Sommerseth
Hi David,

I had hoped that "cipher none" would have the least overhead. Perhaps 
there is a better one to try?

Threads are enabled in the build, but I only ever see one in the running 
program. Maybe 64bit is showing it differently or "ps axms" and "ps 
-eLf" are not the way to display them ?

Performance seems fine if they are doing nothing. We can get the full 
expected bandwidth from a single client, or even a small number of clients.

But when the general use of the tunnels comes up, that's when they 
appear to suffer.

I regret I do not have much in depth info, but I'm really not sure which 
direction I should be aiming :).

Cheers,
JES

--------------030702000101050703070401
Content-Type: text/x-vcard; charset=utf-8;
 name="macleajb.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="macleajb.vcf"

begin:vcard
fn:James B MacLean
n:MacLean;James B
org:Education;ITS Technical Services
adr:;;;Halifax;NS;;Canada
email;internet:macleajb@...213...
url:http://www.ednet.ns.ca/~macleajb
version:2.1
end:vcard


--------------030702000101050703070401--

