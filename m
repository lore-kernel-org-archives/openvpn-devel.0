From: "oyk" <oyk@...89...>
Subject: Re: [Openvpn-devel] how to implement the multi client in openvpn?
Mime-Version: 1.0
Message-ID: <E1BXVKI-0006ya-HK@...110...>
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
Date: Mon Jun  7 18:23:17 2004
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
To: 

Hi=A3=ACDenis Vlasenko
Best Regards
   Ouyang Kai
>On Monday 07 June 2004 15:45, oyk wrote:
>> Hi=A3=ACguys
>>    I want to know how the openvpn control the multi-client case in 2.0
>> version. for example:
>>   clientA---Internet---|             |----Internal Server1
>>                        |----Server---|----Internal Server2
>>   clientB---Internet---|             |----Internal Server3
>>
>> Based on my comprehension, clientA (10.1.0.2) and clientB (10.1.0.3) can
>> make a tunnel with Server (10.1.0.1) respectively using TCP connection.
>> clientA sockA----------Server SockA1
>> clientB sockB----------Server SockB1
>> When Server recieves the package from clientA or clientB, it pushs the
>> packages to the tun/tap device. And the Server box could route the packa=
ge
>> to the internal server. And the internal server response the package to
>> Server.
>
>No. Internal server replies to client's IP address.
>Whether it will be sent to client thru "Server" or not
>depends on routing. Typically you will have symmetric
>routing setup, and it will go thru "Server".
I am not sure whether my comprehension is right.
ClientA(tap ip: 10.1.0.2, real ip: 1.2.3.4)
Server(tap ip: 10.1.0.1, real ip: 5.6.7.8, internal subnet: 10.1.1.0/24)
when ClientA connects an internal ServerB (10.1.1.2)
The package from ClientA should be:
|IPheader(src:1.2.3.4, dst: 5.6.7.8)|TCPheader||etherheader|IPHeader10.1.0.=
2|.....||
                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~content
right?
Server recieved the package, push the content into the tap/tun device.
When the internal ServerB revieves the content, it response another package
to 10.1.0.2, right?
When the Server recieved the response package, it encapsulate the package i=
nto:
|IPheader(src:5.6.7.8, dst: 1.2.3.4)|TCPheader||etherheader|IPHeader10.1.0.=
2|.....||
and send to ClientA, right?
The OpenVPN Server differ clients' package based on the response package's =
IPHeader, right?
Could you tell me where I can find the interrelated code? the OpenVPN
source code is too much.
>
>> My question is: when OpenVPN Server recieves one package from one intern=
al
>> server, how does it control the package and redirect to whom(clientA or
>> clientB)?
>
>By looking at destination IP.
>
>>    Please help, thanks!
>>
>> PS: could I use windows version as OpenVPN Server?
>
>As a last resort only ;)
>--
>vda
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
>installation-authoring solution that does it all. Learn more and
>evaluate today! http://www.installshield.com/Dev2Dev/0504
>_______________________________________________
>Openvpn-devel mailing list
>Openvpn-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>.





