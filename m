Message-ID: <492EE0F6.6010300@...1114...>
Date: Thu, 27 Nov 2008 19:03:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <492DBF02.1070305@...213...>
	<492EABB8.6050908@...1114...>	<492ECD60.1060502@...213...>
	<492EDCFC.6010503@...1114...>
In-Reply-To: <492EDCFC.6010503@...1114...>
Subject: Re: [Openvpn-devel] Tunnel Speed Tunning with many clients connected
Reply-To: dazo@...384...
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
To: James MacLean <macleajb@...213...>
Cc: openvpn-devel@lists.sourceforge.net



David Sommerseth wrote:
> James MacLean wrote:
>> David Sommerseth wrote:
>>>
>>> James MacLean wrote:
>>>> Hi Folks,
>>>>
>>>> I have parsed around a bit but have not come up with a solid 
>>>> suggestion to increase performance in the following environment :
>>>>
>>>> . +150 clients always on, always via COAX modem 15Mb/s down 1.5Mb/s up.
>>>> . OpenVPN-2.0.9 and 2.1rc13 tested, setup as single server
>>>> . Server Kernel 2.6.25.4
>>>> . Server 64bit
>>>> . Server CPU % rarely goes above 30
>>>> . Server is fed over a 10G link
>>>>
>>>> Currently we get what appears to be only between 5 and 6 MB/s average 
>>>> using this setup.
>>>>
>>>> If only activity is over a single tunnel we can get the expected max 
>>>> (about 14Mb/s to the remote site) for the COAX sites. Once traffic 
>>>> builds during the day, that number drops.
>>>>
>>>> We know if we hit it locally we can get 160Mb/s. We know if we do hit 
>>>> it locally and are getting the 160Mb/s that the COAX tunnels do 
>>>> suffer. Starting by almost 1/2 of their normal throughput tunnel 
>>>> speed of almost 14Mb/s.
>>>>
>>>> So in my small mind, I am thinking we are seeing around 48Mb/s 
>>>> (6MB/s*8) used, but that we should be able to get over 150Mb/s. CPU 
>>>> isn't hurting. Almost feels like there is a governor slowing down the 
>>>> traffic :).
>>>>
>>>> Important settings from latest config :
>>>>
>>>> verb 1
>>>> dev tap
>>>> tun-mtu 1500
>>>> tun-mtu-extra 32
>>>> mssfix 1468
>>>> proto udp
>>>> ca SSCert.pem
>>>> cert servercert.pem
>>>> key serverkey.pem
>>>> dh dh1024.pem
>>>> tls-auth ./tlspass
>>>> keepalive 30 63
>>>> ping-timer-rem
>>>> persist-tun 1
>>>> persist-key 1
>>>> cipher none
>>>> tcp-queue-limit 4096
>>>> sndbuf 131072
>>>> rcvbuf 131072
>>>>
>>>>
>>>> Anyone have any words of wisdom :) ?
>>>>
>>> Have you tried different ciphers and/or cipher key sizes?  I know you 
>>> say the server do not suffer with too high load, but it could be 
>>> inefficiency in the cipher algorithm.  If that's the case it might be 
>>> as well an OpenSSL issue too.  It's a shot in the dark, but would be 
>>> good to wipe this one out.  The default is blowfish, so I really do 
>>> not expect an improvement.
>>>
>>> Do you know if threads are enabled in your OpenVPN setup? 
>>> (compile/configure setting).  I believe the default is not to use 
>>> threads.
>>>
>>> Does the performance drop if you have 150+ clients connected while 
>>> being passive (not sending any traffic over the tunnel) and only 
>>> having 1 client sending traffic?
>>>
>>>
>>> kind regards,
>>>
>>> David Sommerseth
>> Hi David,
>>
>> I had hoped that "cipher none" would have the least overhead. Perhaps 
>> there is a better one to try?
> 
> Hehe ... no, "cipher none" should have the very least overhead.  I would be 
> very much surprised if anything goes through OpenSSL at this moment.  But I 
> probably don't need to say anything about the security level by doing it. 
> Anyway, for testing and debugging - good approach!
> 
>> Threads are enabled in the build, but I only ever see one in the running 
>> program. Maybe 64bit is showing it differently or "ps axms" and "ps 
>> -eLf" are not the way to display them ?
> 
> ps -eLf should display all threads, afaik.
> 
> Not sure though how the really threads are implemented, but when I dig into 
> the code it seems to be initialised as a single thread.  I cannot find 
> traces in the code that indicates that multiple threads is implemented. 
> But it seems like the code is getting ready for it.
> 
> I will need to be corrected if my suspicion is wrong, that the core 
> behaviour between threaded and non-threaded binaries is almost behaving the 
> same, and not spawning out a thread per connection.  If this is the case, 
> I'm not sure if it has any performance impact to use the threaded model. 
> Unless OpenSSL encryption is running in an own separate thread (I have not 
> investigated this)
> 
>> Performance seems fine if they are doing nothing. We can get the full 
>> expected bandwidth from a single client, or even a small number of clients.
>>
>> But when the general use of the tunnels comes up, that's when they 
>> appear to suffer.
>>
>> I regret I do not have much in depth info, but I'm really not sure which 
>> direction I should be aiming :).
> 
> Hmm ... that just seems to indicate that it is a drastic performance drop 
> when too many clients are using the tunnels.
> 
> When I look at the code, which is quite complex when it comes to the part 
> when clients connect, it seems like OpenVPN has it own way of scheduling 
> for when and how to handle the clients.  And it might be that you've found 
> a limit in the implementation.
> 
> This code is taken from mudp.c
> 
>    /* per-packet event loop */
>    while (true)
>      {
>        perf_push (PERF_EVENT_LOOP);
> 
>        /* set up and do the io_wait() */
>        multi_get_timeout (&multi, &multi.top.c2.timeval);
>        io_wait (&multi.top, p2mp_iow_flags (&multi));
>        MULTI_CHECK_SIG (&multi);
> 
>        /* check on status of coarse timers */
>        multi_process_per_second_timers (&multi);
> 
>        /* timeout? */
>        if (multi.top.c2.event_set_status == ES_TIMEOUT)
>          {
>            multi_process_timeout (&multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGNAL);
>          }
>        else
>          {
>            /* process I/O */
>            multi_process_io_udp (&multi);
>            MULTI_CHECK_SIG (&multi);
>          }
> 
>        perf_pop ();
>      }
> 
> 
> This seems to me to be the main loop.  Here it seems that OpenVPN server is 
> listening for traffic on the network connections and processes each packet, 
> no matter which client sending it - and then analysing the packet and let a 
> connection "object" take care of further processing of the packet.  This is 
> just a wild-guess, as I only spent 10-15 min looking through the code.  But 
> a lot of process magic happens in multi_process_io_udp(), and a couple of 
> levels deeper a scheduling function is called.
> 
> If this really is true, it might be that this model works very well for a 
> good number of clients, until you reach a limit around 150+, when the cost 
> of doing this rescheduling begins to be too costly.  If this scheduling is 
> not efficient enough (having a small "sleep" in between, waiting for IO, 
> inefficient or too many code jumps, etc), you will not see that the load on 
> the server increases too much - but you will most probably feel the 
> performance loss on the client side.  With few active clients, this will of 
> course go better, as the internal scheduler has less clients to switch between.
> 
> In addition, I see that the code path is quite long, doing a lot of jumps 
> between a lot of function, and this of course also adds some penalty - even 
> though each function seems to be optimised.
> 
> This is of course a way how to avoid forking out or starting a new thread 
> per client which works independently, being task switched by the OS.  But 
> to be honest, I think the OS scheduler might be much more efficient in the 
> scheduling and process switches than to have a separate one.
> 
> Can anyone with deeper knowledge than me verify or correct me?  I would 
> like to understand this part of the code much better.
> 
> 

Just a follow up ... I found these links regarding multi-threading:

http://openvpn.net/archive/openvpn-users/2004-08/msg00186.html
http://openvpn.net/archive/openvpn-users/2005-05/msg00214.html

So, it seems to be on the way back in into OpenVPN with v2.1.  But most 
probably not completely there yet.


kind regards,

David Sommerseth


