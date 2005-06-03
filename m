From: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Message-ID: <d7q8hf$jos$1@...165...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...> <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...> <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...> <1116334849.14388.43.camel@...23...> <Pine.LNX.4.58.0505170713570.2777@...41...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jun  3 11:54:55 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I have again two questions about the counter for the bytes send and
received:

What is the datatype of the counters? 
Radius only knows 32-bit unsingned integers.

Which traffic is counted?
Is only the real payload counted without the encryption overhead?
What about the keepalive packets? 
I see there is always a little bit of traffic.
Is it possible to count only the real payload or must I subtract the other
bytes from the counters in the plugin?

Greetings
Ralf

James Yonan wrote:

> On Tue, 17 May 2005, Torge Szczepanek wrote:
> 
>> Am Dienstag, den 17.05.2005, 15:20 +0400 schrieb Ralf Lübben:
>> 
>> > I want to send following attribute:
>> > Username
>> > Password
>> > NAS-Port = number of the tun interface
>> 
>> This is bad, since you must send a unique identifier to the Radius
>> Server for every connected client if I understand this correctly.
>> 
>> The Radius servers decides based on a unique NAS-IP-Address:NAS-Port
>> pair which IP-Addresse should be handed out to the client and which is
>> in use.
>> 
>> Example:
>> 
>> NAS:XXX.XXX.XXX.40 port:0x0 - ipaddr:YYY.YYY.76.YYY active:1 cli:0 num:1
>> NAS:XXX.XXX.XXX.40 port:0x1 - ipaddr:YYY.YYY.75.YYY active:1 cli:0 num:1
>> [...]
>> NAS:XXX.XXX.XXX.40 port:0x10 - ipaddr:YYY.YYY.76.YYY active:1 cli:0
>> num:1
>> NAS:XXX.XXX.XXX.40 port:0x11 - ipaddr:YYY.YYY.78.YYY active:1 cli:0
>> num:1
>> NAS:XXX.XXX.XXX.40 port:0x12 - ipaddr:YYY.YYY.72.YYY active:1 cli:0
>> num:1
>> NAS:XXX.XXX.XXX.40 port:0x13 - ipaddr:YYY.YYY.73.YYY active:1 cli:0
>> num:1
>> [...]
>> NAS:XXX.XXX.XXX.40 port:0x100 - ipaddr:YYY.YYY.78.YYY active:0 cli:0
>> num:0
>> NAS:XXX.XXX.XXX.40 port:0x103 - ipaddr:YYY.YYY.77.YYY active:0 cli:0
>> num:0
>> 
>> Since the tun interface is the same for every connected client connected
>> to the same openvpn process, this will not work. One might correct me,
>> if I am wrong on this.
>> 
>> So at the moment one has to generate a unique client id (NAS-Port) for
>> every connected user. This should be done in a way that the first client
>> gets the id (NAS-Port) 0 assigned. The next one the id 1 and so on. On
>> disconnect the id should be reused.
>> 
>> For example:
>> 
>> client 1 connects, gets id 0
>> client 2 connects, gets id 1
>> client 3 connects, gets id 2
>> client 4 connects, gets id 3
>> client 2 disconnects, releases id 1
>> client 3 disconnects, releases id 2
>> client 5 connects, gets id 1
>> client 6 connects, gets id 2
>> [...]
>> 
>> 
>> I wondered whether it is possible to have a seperate tunx interface for
>> each connected client. That would solve the problem and mimic the
>> behaviour of ppp Connections, where you have a seperated ppp Interface
>> for each connected client.
>> Is this easy possible or would that mean to rewrite most parts of
>> OpenVPN?
> 
> It's more like the opposite:  1.x supported a specific tunx interface and
> port for each client.  2.0 was rewritten to allow all clients to share a
> single tun/tap interface and TCP/UDP port.  The 2.0 approach tends to be
> preferred because it scales better and is easier to manage.
> 
> James
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_idt12&alloc_id344&opclick



