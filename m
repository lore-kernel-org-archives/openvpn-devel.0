References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
	<403b6c99-f62f-6d7e-f3b7-ec207505ca3d@...277...>
	<CAKuzo_iQPcDbZVbfMgnouj5XGLfVp=RniKeg==_N1UV0aWQU9A@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f9f6b819-4437-9fa4-ebb9-0457840c6202@...277...>
Date: Tue, 3 Jan 2017 15:23:44 +0000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iQPcDbZVbfMgnouj5XGLfVp=RniKeg==_N1UV0aWQU9A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
 close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 01/01/17 18:15, Selva Nair wrote:
> Hi,
>
> On Sun, Jan 1, 2017 at 10:49 AM, debbie10t <debbie10t@...277...> wrote:
>
>> Hi,
>>
>> I applied this to 2.5 and used the build system to build windows
>> installer using windows-nsis/build-snapshot
>>
>> I tested the windows client against Linux 2.4
>>
>> The test was:
>>
>> Connect to first server, receive DHCP 10.*8*.0.6 (net30)
>> Idle 10 mins / Transfer some data / disconnect
>>
>> Edit the config file to connect to a new server
>> (This was an exact copy of first server on a new --port
>> and with a new --server subnet / PKI identical)
>>
>> Connect to second server, receive DHCP 10.*9*.0.6 (net30)
>> Idle 10 mins / Transfer some data / disconnect
>>
>> No problems encountered.
>>
>
>> Note: I *was* able to replicate the original bug using
>> windows 10 / openvpn 2.4.0 and the same procedure as above.
>>
>>
>
> I am curious about this as I could not reproduce "the bug" with only one
> adapter except in a special case (see below)  -- the issue I described in
> Trac #807 was related to assigning a VPN ip to one adapter, disconnect and
> then try to assign the same to another adapter.

You are correct.

What I have in my tests is as follows:

Server Linux - Openvpn 2.4.0
Client Win10 - Openvpn 2.4.0

Server & client configs are essentially the default config files.

(Both clients are on the same W10 machine)
client-1.conf
tap #1
client ip 10.8.0.6/30

client-2.conf
tap #2
client ip 10.9.0.6/30

Connect both clients and get IP assigned to tap, ping tests OK.
Disconnect both clients, do *not* use --dhcp-release/renew

Change client-1.conf to connect to the port of server-2
Connect to server-2, receive+assign DHCP 10.9.0.6 to TAP #1
This is where something goes wrong ..


> However, some reports in the user list and Trac #665 appears to have
> problems when changing the remote with one adapter. I can see dhcp failure
> in such a case only if the media status on the adapter is set to always
> connected. Is that the case in your tests?
>

#665 is related to 2.3.10/12/13 and while it maybe the same issue I
have not run any tests regarding #665

Regards




